% SPM batch for all FIR contrasts
%-----------------------------------------------------------------------
% Job saved on 10-Mar-2018 09:15:14 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
% cfg_mindlab MindLab - Unknown
%-----------------------------------------------------------------------

%% Define variables for type of analysis to run
% Which analysis
analysis = 'SoundEnvelope_FIR';
cont_index = 4;
tot_bins = 20;

% Define some useful variables for contrast filenames
prefix = ['/projects/MINDLAB2016_MR-demonstratives/scratch/Oct18_Final/' analysis '/'];
affix = '.nii,1';

% Still to estimate interactions

% Define name for output folder
if cont_index == 1
    fold_name = 'Left'
elseif cont_index == 2
    fold_name = 'Right'
elseif cont_index == 3
    fold_name = 'Right>Left'
elseif cont_index == 4
    fold_name = 'Right<Left'
end

% Variables for output folder
main_folder = '/projects/MINDLAB2016_MR-demonstratives/scratch/Oct18_Final/SoundEnvelope_FIR_SecondLevel';
cd(main_folder);
out_folder = [main_folder '/' fold_name];

% Create output folder if it does not exist
if isdir(out_folder) == 1
    rmdir(out_folder,'s'); %remove old files
end
mkdir(out_folder);


% Start defining batch
matlabbatch{1}.spm.stats.factorial_design.dir = {out_folder};
%% 

for bin_nr = 1:20
    
    % Define right contrast number 
    cont_nr = bin_nr + (cont_index - 1) * tot_bins;
    
    % Create counter
    c = 0;
    
    % Initialize cell array for filenames
    filenames = cell(1,28);
    
    % Fill in with scans
    for subj_nr = [5:28 30:33]
        c = c + 1;
        filenames{c} =  [prefix sprintf('%03d', subj_nr) '/con_0' sprintf('%03d', cont_nr) affix];  
    end
    
     matlabbatch{1}.spm.stats.factorial_design.des.anova.icell(bin_nr).scans = filenames';
     
end

matlabbatch{1}.spm.stats.factorial_design.des.anova.dept = 1;
matlabbatch{1}.spm.stats.factorial_design.des.anova.variance = 1;
matlabbatch{1}.spm.stats.factorial_design.des.anova.gmsca = 0;
matlabbatch{1}.spm.stats.factorial_design.des.anova.ancova = 0;
matlabbatch{1}.spm.stats.factorial_design.cov = struct('c', {}, 'cname', {}, 'iCFI', {}, 'iCC', {});
matlabbatch{1}.spm.stats.factorial_design.multi_cov.files = {'/projects/MINDLAB2016_MR-demonstratives/scripts/Oct18_Final/FIR_analysis/Demonstratives/SecondLevel/RandEff.mat'};
matlabbatch{1}.spm.stats.factorial_design.multi_cov.iCFI = 1;
matlabbatch{1}.spm.stats.factorial_design.multi_cov.iCC = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.tm.tm_none = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.im = 1;
matlabbatch{1}.spm.stats.factorial_design.masking.em = {''};
matlabbatch{1}.spm.stats.factorial_design.globalc.g_omit = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.gmsca.gmsca_no = 1;
matlabbatch{1}.spm.stats.factorial_design.globalm.glonorm = 1;