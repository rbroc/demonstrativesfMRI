%% Create input structure for SPM batch for field map conversion to .nii

scripts_dir = '/projects/MINDLAB2016_MR-demonstratives/scripts/AnalysisFeb/FieldMaps';
cd(scripts_dir);

% Define the batch of interest
jobfile = 'createVDM.mat';

% Get dbhandle
dbhandle = stormdb_get_handle();
project = 'MINDLAB2016_MR-demonstratives';

% Define scratch directories
scratch_dir = '/scratch1/MINDLAB2016_MR-demonstratives/AnalysisFeb';

%Get subjects IDs
subjects  = stormdb_get_subjects(dbhandle, project); % 5 to 35

% Set up SPM
%set path for SPM
addpath /usr/local/common/matlab_toolbox/spm12_r6906_v2

%load the SPM defaults
spm('defaults','fmri');

%Initialize
spm_jobman('initcfg');
spm_get_defaults('cmdline',true);

%Go back to the original directory
cd(scripts_dir);

%Load the jobfile describing what to do
load(jobfile)
    
% For each subject
for s = 1:28
 %% Find all images needed in batch
    
    % Create subj ID 
    if subjects(s) < 10
        subj_id_scratch = char(strcat('00', string(subjects(s))));
    else
        subj_id_scratch = char(strcat('0', string(subjects(s))));
    end
    
    % Define the three directories
    scratch_subj = char(strjoin({scratch_dir, subj_id_scratch}, '/'));
    scratch_dir_FM1 = char(strjoin({scratch_dir, subj_id_scratch, 'FM_1'}, '/'));
    scratch_dir_FM2 = char(strjoin({scratch_dir, subj_id_scratch, 'FM_2'}, '/'));
    scratch_dir_EPI = char(strjoin({scratch_dir, subj_id_scratch, 'FuncImg'}, '/'));
    
    % Short TE magnitude image
    short_te_find = strcat(scratch_dir_FM1, '/sSubject*01.nii');
    short_te_files = dir(short_te_find);
    short_te = char(strjoin({short_te_files(1).folder,short_te_files(1).name},'/'));
    
    % Phase map
    phase_map_find = strcat(scratch_dir_FM2, '/sSubject*02.nii');
    phase_map_files = dir(phase_map_find);
    phase_map = char(strjoin({phase_map_files(1).folder,phase_map_files(1).name},'/'));
    
    % First EPI image
    EPI_img_find = strcat(scratch_dir_EPI, '/fSubject*01-01.nii');
    EPI_img_files = dir(EPI_img_find);
    EPI_img = char(strjoin({EPI_img_files(1).folder,EPI_img_files(1).name},'/'));
    
    % Move to the root folder where the images are saved
    cd(scratch_subj);
    
    % Run it
    spm_jobman('serial', matlabbatch,'', {phase_map}, {short_te}, {EPI_img})
    
end    