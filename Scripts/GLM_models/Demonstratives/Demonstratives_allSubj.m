function jobid = Demonstratives_allSubj(debug)
% Demonstratives words: fill in batch for first-level model for all subjects and estimate it
% Specific for FIR batch

% set path to pipeline
cd /usr/local/common/matlab_toolbox/mindlab/mindlab_r2017.02.1/pipeline
setup_pipeline_path

% Sefine needed variables
cd /projects/MINDLAB2016_MR-demonstratives/
load dbhandle_rob.mat;

project = 'MINDLAB2016_MR-demonstratives';
scriptdir=['/projects/' project '/scripts/Oct18_Final/FIR_analysis/Demonstratives'];
jobfile = 'Demonstratives_batch.mat';

% Assign participants to groups
group_1a=[005 008 013 017 021 025];
group_2a=[006 010 014 018 022 026 031]; 
group_1b=[007 011 015 019 023 027 032];
group_2b=[009 012 016 020 024 028 030];

%%
subjects = [005 006 007 008 009 010 011 012 013 014 015 016 017 018 019 020 021 022 023 024 025 026 027 028 030 031 032 033];

c=0;

for s=group_1b
            c=c+1;
            
            % Define directories for functional images and nuisance
            % regressors
            func_folder = [sprintf('/projects/MINDLAB2016_MR-demonstratives/scratch/AnalysisFeb/%03d/FuncImg',s)];
            physio_folder = [sprintf('/projects/MINDLAB2016_MR-demonstratives/scratch/AnalysisFeb/%03d/physio_data',s)];
            
            % First go to functional images folder
            cd(func_folder);
            
            % Only select smoothed images
            files=dir('wuf*.nii');
            
            %Paste path with filename for every image
            img_names={files.name}.';         
            img_path=files.folder;
            input(c).files=strcat(img_path, {'/'}, img_names);
            
            input(c).project = project;
            input(c).jobfile = jobfile;
            input(c).subject=s;
            input(c).scriptdir = scriptdir;
            
            % Go to physio folder
            cd(physio_folder);
            
            % Find movement and physio regressors file
            regressors=dir('*Log*.txt');
            reg_name={regressors.name};
            reg_path=regressors.folder;
            input(c).mov_reg=strcat(reg_path, {'/'}, reg_name);
            
            
            % Select right paradigm file based on group
           if s == 014
               input(c).parfile = {['/projects/' project '/scripts/Oct18_Final/ParFiles/demonstratives_subj14.mat']};
            elseif ismember(s, group_1a)
                input(c).parfile= {['/projects/' project '/scripts/Oct18_Final/ParFiles/demonstratives_1a.mat']};
            elseif ismember(s, group_1b)
                input(c).parfile= {['/projects/' project '/scripts/Oct18_Final/ParFiles/demonstratives_1b.mat']};
            elseif ismember(s, group_2a)
                input(c).parfile= {['/projects/' project '/scripts/Oct18_Final/ParFiles/demonstratives_2a.mat']};
            else
                input(c).parfile= {['/projects/' project '/scripts/Oct18_Final/ParFiles/demonstratives_2b.mat']};
           end
           
end

%%
cd(scriptdir);

%Check if debugging is on and otherwise submit the job to the cluster
clusterconfig('queue','all.q');

%Configurations for long running jobs
%clusterconfig('long_running',2)
clusterconfig('slot',2);

if nargin >0
    display('Debug status is active returning input structure instead of jobid')
    jobid = input;
else
    display('Submitting job to cluster. Use  joberrors jobstatus and jobinfo for more information')
    jobid = job2cluster(@Demonstratives_single, input)
end

%end