function out = DICOM_convert_single(input)
%% Run SPM batch for DICOM conversion

out = [];

% Inherit structure
project = input.project;
subject = input.subject;
jobfile = input.jobfile;
scripts_dir=input.scripts_dir;

% Give working directory input as cell
scratch_dir_1 = {input.scratch_dir_1};
FM_dicom_1 = input.FM_dicom_1;

% Map nr 2
scratch_dir_2 = {input.scratch_dir_2};
FM_dicom_2 = input.FM_dicom_2;

%% Sumbit the job
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

%Submit the single subject batch job including the needed cell variables to
%the spm jobmanager
inputs{1} = FM_dicom_1;
inputs{2} = scratch_dir_1;
spm_jobman('serial', matlabbatch,'', inputs{:})

% Submit second batch
inputs{1} = FM_dicom_2;
inputs{2} = scratch_dir_2;
spm_jobman('serial', matlabbatch, '', inputs{:})

