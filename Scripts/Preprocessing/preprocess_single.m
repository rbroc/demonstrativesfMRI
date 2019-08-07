function out = preprocess_single(input)
%% Run SPM batch for preprocessing

out = [];

% Inherited fields
project = input.project;
subject = input.subject;
jobfile = input.jobfile;
scripts_dir=input.scripts_dir;
DICOM_struct = input.DICOM_struct;
scratch_dir_struct = {input.scratch_dir_struct};
EPI_img = input.EPI_img;
VDM = {input.VDM};


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
spm_jobman('serial', matlabbatch, '', DICOM_struct, scratch_dir_struct, EPI_img, VDM)

