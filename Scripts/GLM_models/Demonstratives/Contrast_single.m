function out = Contrast_single(input)
%syntax: out = analyze_subject(input)

out = []; %The variable out could be included later for debugging if needed

% Short names
project = input.project;
subject = input.subject;
jobfile = input.jobfile;
scriptdir=input.scriptdir;
matrix = input.matrix;


%set path for SPM
addpath /usr/local/common/matlab_toolbox/spm12_r6906_v2

%load the SPM defaults
spm('defaults','fmri');

%Initialize
spm_jobman('initcfg');

%Set command line to true (we don't need a GUI from each node of the
%cluster!
spm_get_defaults('cmdline',true);
%spm_get_defaults('mat.format', '-v7.3');
%spm_get_defaults('stats.maxmem',2^32);

%Go back to the original directory
cd(scriptdir);

%Load the jobfile describing what to do
load(jobfile);

%Submit the single subject batch job including the needed cell variables to
%the spm jobmanager
spm_jobman('serial',matlabbatch,'',matrix);

cd(scriptdir);
end