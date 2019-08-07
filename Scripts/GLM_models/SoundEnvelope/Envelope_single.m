function out = Envelope_single(input)
%syntax: out = analyze_subject(input)

out = []; %The variable out could be included later for debugging if needed

% Short names
project = input.project;
subject = input.subject;
jobfile = input.jobfile;
scriptdir=input.scriptdir;

%Define names of directories and paradigm and nuisance file
files=input.files;
mov_reg=input.mov_reg;


%% Create relevant folders
results_dir=['/projects/' project '/scratch/Oct18_Final/SoundEnvelope_FIR/'];
matrix_dir=[results_dir sprintf('%03d',subject)]

if isdir(matrix_dir)==1
rmdir(matrix_dir,'s'); %remove old files
end

%Create directories
mkdir(matrix_dir);

% Put name in cells, so that it is accepted by spm_jobman
matrix_dir={matrix_dir}% 

%set path for SPM
addpath /usr/local/common/matlab_toolbox/spm12_r6906_v2

%load the SPM defaults
spm('defaults','fmri');

%Initialize
spm_jobman('initcfg');

%Set command line to true (we don't need a GUI from each node of the
%cluster!
spm_get_defaults('cmdline',true);
spm_get_defaults('mat.format', '-v7.3');
%spm_get_defaults('stats.maxmem',2^32);

%Go back to the original directory
cd(scriptdir);

%Load the jobfile describing what to do
load(jobfile);

%Submit the single subject batch job including the needed cell variables to
%the spm jobmanager
spm_jobman('serial',matlabbatch,'',matrix_dir, files, mov_reg);

cd(scriptdir);