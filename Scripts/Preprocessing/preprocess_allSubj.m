function out = preprocess_allSubj(debug)
%% Create input structure for preprocessing pipeline
% Finds DICOM structural images and output folder
% Finds functional images to realign
% Finds VDM

% Input structure fields:
%   Project
%   Subject
%   Jobfile
%   scripts_dir (path to jobfile directory)
%   DICOM_struct (raw structural images, needed in SPM batch)
%   scratch_dir_struct (scratch directory for structural images (needed in
%   SPM batch)
%   scratch_dir_EPI (scratch dir for functional images)
%   scratch_dir_VDM (scratch dir for voxel displacement map)
%   EPI_img (functional images, needed in SPM batch)
%   VDM (voxel displacement map, needed in SPM batch)

% Created 25 Feb 2018

scripts_dir = '/projects/MINDLAB2016_MR-demonstratives/scripts/AnalysisFeb/Preprocessing';
cd(scripts_dir);

% Define the batch of interest
jobfile = 'Preprocess_pipeline.mat';

% Get dbhandle
dbhandle = stormdb_get_handle();
project = 'MINDLAB2016_MR-demonstratives';

% Define scratch directories
scratch_dir = '/scratch1/MINDLAB2016_MR-demonstratives/AnalysisFeb';

%% Create input structure

%Get subjects ID
subjects  = stormdb_get_subjects(dbhandle, project); % 5 to 33

for s = 1:28
    input(s).subject = subjects(s);
    
    % Find DICOM structural images
    serieno = stormdb_get_serie_numbers(dbhandle, project, subjects(s), 1, 'MR', 'T1');
    input(s).DICOM_struct = stormdb_get_files(dbhandle, project, subjects(s), 1, 'MR', serieno);
    
    % Create subj ID 
    if subjects(s) < 10
        subj_id_scratch = char(strcat('00', string(subjects(s))));
    else
        subj_id_scratch = char(strcat('0', string(subjects(s))));
    end
     
    % Parent scratch directory
    subj_scratch = char(strjoin({scratch_dir, subj_id_scratch}, '/'));
    
    % Scratch subdirectories
    input(s).scratch_dir_struct = char(strjoin({subj_scratch, 'StructImg'}, '/'));
    input(s).scratch_dir_EPI = char(strjoin({subj_scratch, 'FuncImg'}, '/'));
    input(s).scratch_dir_VDM = char(strjoin({subj_scratch, 'FM_2'}, '/'));

    if 7 ~= exist(input(s).scratch_dir_struct, 'dir')
        mkdir(subj_scratch, 'StructImg')
    end
    
    % Find functional images to realign
    EPI_img_find = strcat(input(s).scratch_dir_EPI, '/f*.nii');
    EPI_img_files = dir(EPI_img_find);
    EPI_img = arrayfun(@(S) strcat(S.folder, '/', S.name), EPI_img_files, 'UniformOutput', false);
    input(s).EPI_img = EPI_img;

    % Find voxel displacement map
    VDM_find = strcat(input(s).scratch_dir_VDM, '/vdm*.nii');
    VDM_files = dir(VDM_find);
    VDM = char(strjoin({VDM_files.folder,VDM_files.name},'/'));
    input(s).VDM = VDM;
    
    % Define jobfile and scripts directory
    input(s).scripts_dir = scripts_dir;
    cd(scripts_dir);
    input(s).jobfile = jobfile;
    input(s).project = project;
    
end

%% Set cluster and run

%Check if debugging is on and otherwise submit the job to the cluster
clusterconfig('queue','all.q')

%clusterconfig('long_running',2)
%clusterconfig('slot',2)

if nargin > 0
    display('Debug status is active returning input structure instead of jobid')
    jobid=input;
else
    display('Submitting job to cluster. Use  joberrors jobstatus and jobinfo for more information')
    jobid = job2cluster(@preprocess_single, input);
end
