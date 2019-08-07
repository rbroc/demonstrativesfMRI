function out = DICOM_convert_EPI_allSubj(debug)
%% Create input structure for SPM batch for field map conversion to .nii

scripts_dir = '/projects/MINDLAB2016_MR-demonstratives/scripts/AnalysisFeb/Preprocessing';
cd(scripts_dir);

% Define the batch of interest
jobfile = 'DICOM_convert_EPI.mat';

% Get dbhandle
dbhandle = stormdb_get_handle();
project = 'MINDLAB2016_MR-demonstratives';

% Define scratch directories
scratch_dir = '/scratch1/MINDLAB2016_MR-demonstratives/AnalysisFeb';

%% Create input structure

%Get subjects ID
subjects  = stormdb_get_subjects(dbhandle, project); % 5 to 35

for s = 1:28
    
    input(s).subject = subjects(s);

    % Extract files
    serieno = stormdb_get_serie_numbers(dbhandle, project, subjects(s), 1, 'MR', 'Story1_mbep2d_bold_MB9_2.5iso_ANC_ON');
    input(s).EPI_img = stormdb_get_files(dbhandle, project, subjects(s), 1, 'MR', serieno);

    % Create subj ID 
    if subjects(s) < 10
        subj_id_scratch = char(strcat('00', string(subjects(s))));
    else
        subj_id_scratch = char(strcat('0', string(subjects(s))));
    end
     
    % scra
    subj_dir = char(strjoin({scratch_dir, subj_id_scratch}, '/'));
    
    % Create the directories if they do not exist
    input(s).scratch_dir = char(strjoin({subj_dir, 'FuncImg'}, '/'));

    if 7 ~= exist(input(s).scratch_dir, 'dir')
        mkdir(subj_dir, 'FuncImg')
    end

    % Define jobfile and scripts directory
    % Scripts directory
    input(s).scripts_dir = scripts_dir;
    cd(scripts_dir);

    % Define the batch of interest
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
    jobid = job2cluster(@DICOM_convert_EPI_single, input);
end
