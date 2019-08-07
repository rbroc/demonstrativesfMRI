function out = DICOM_convert_EPI_single(input)
%% Run SPM batch for DICOM conversion

out = [];

% Inherit structure
project = input.project;
subject = input.subject;
jobfile = input.jobfile;
scripts_dir=input.scripts_dir;

% Give working directory input as cell
scratch_dir = {input.scratch_dir};
EPI_img = input.EPI_img;


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
spm_jobman('serial', matlabbatch,'', EPI_img, scratch_dir)

