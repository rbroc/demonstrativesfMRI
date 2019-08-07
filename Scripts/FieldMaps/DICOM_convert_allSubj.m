function out = DICOM_convert_allSubj(debug)
%% Create input structure for SPM batch for field map conversion to .nii

scripts_dir = '/projects/MINDLAB2016_MR-demonstratives/scripts/AnalysisFeb/FieldMaps';
cd(scripts_dir);

% Define the batch of interest
jobfile = 'DICOM_convert.mat';

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
    serieno = stormdb_get_serie_numbers(dbhandle, project, subjects(s), 1, 'MR', 'gre_field_mapping');
    input(s).FM_dicom_1 = stormdb_get_files(dbhandle, project, subjects(s), 1, 'MR', serieno(1));
    input(s).FM_dicom_2 = stormdb_get_files(dbhandle, project, subjects(s), 1, 'MR', serieno(2));

    % Create subj ID 
    if subjects(s) < 10
        subj_id_scratch = char(strcat('00', string(subjects(s))));
    else
        subj_id_scratch = char(strcat('0', string(subjects(s))));
    end
     
    % scra
    subj_dir_1 = char(strjoin({scratch_dir, subj_id_scratch}, '/'));
    subj_dir_2 = char(strjoin({scratch_dir, subj_id_scratch}, '/'));
    
    % Create the directories if they do not exist
    input(s).scratch_dir_1 = char(strjoin({subj_dir_1, 'FM_1'}, '/'));
    input(s).scratch_dir_2 = char(strjoin({subj_dir_2, 'FM_2'}, '/'));

    if 7 ~= exist(input(s).scratch_dir_1, 'dir')
        mkdir(subj_dir_1, 'FM_1')
    end

    if 7 ~= exist(input(s).scratch_dir_2, 'dir')
        mkdir(subj_dir_2, 'FM_2')
    end

    % Define jobfile and scripts directory
    % Scripts directory
    input(s).scripts_dir = '/projects/MINDLAB2016_MR-demonstratives/scripts/AnalysisFeb/FieldMaps';
    cd(scripts_dir);

    % Define the batch of interest
    input(s).jobfile = 'DICOM_convert.mat';
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
    jobid = job2cluster(@DICOM_convert_single, input);
end

