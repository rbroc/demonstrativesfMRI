function jobid = Contrast_AllSubj(debug)
% Full Model: run contrasts

% set path to pipeline
cd /usr/local/common/matlab_toolbox/mindlab/mindlab_r2017.02.1/pipeline
setup_pipeline_path

% Sefine needed variables
cd /projects/MINDLAB2016_MR-demonstratives/
load dbhandle_rob.mat;

project = 'MINDLAB2016_MR-demonstratives';
scriptdir=['/projects/' project '/scripts/Oct18_Final/FIR_analysis/FullModel'];
jobfile = 'speechavg_contrast.mat';
subjects = [005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 030 031 032 033];

c = 0

for s = subjects
    
    c = c + 1
    
    mat_folder = [sprintf('/projects/MINDLAB2016_MR-demonstratives/result/Oct18_Final/FIR_analysis/FullModel/%03d',s)];
    cd(mat_folder);
    input(c).matrix = {[mat_folder '/SPM.mat']};
    input(c).subject = s;
    input(c).jobfile = jobfile;
    input(c).project = project;
    input(c).scriptdir = scriptdir;

    
end

cd(scriptdir);

%Check if debugging is on and otherwise submit the job to the cluster
clusterconfig('queue','all.q');

%Configurations for long running jobs
%clusterconfig('long_running',2)
clusterconfig('slot',1);

if nargin >0
    display('Debug status is active returning input structure instead of jobid')
    jobid = input;
else
    display('Submitting job to cluster. Use  joberrors jobstatus and jobinfo for more information')
    jobid = job2cluster(@Contrast_single, input)
end

end