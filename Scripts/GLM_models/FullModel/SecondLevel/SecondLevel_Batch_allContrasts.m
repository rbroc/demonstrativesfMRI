% SPM batch for all FIR contrasts
%-----------------------------------------------------------------------
% Job saved on 10-Mar-2018 09:15:14 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
% cfg_mindlab MindLab - Unknown
%-----------------------------------------------------------------------

%% Define variables for type of analysis to run
% % Which analysis
 spm('defaults', 'fmri');
 spm_jobman('initcfg');


analysis = 'FullModel';

for cont_index = 33
tot_bins = 20;

% Define some useful variables for contrast filenames
prefix = ['/projects/MINDLAB2016_MR-demonstratives/result/Oct18_Final/FIR_analysis/' analysis '/'];
affix = '.nii,1';

% Still to estimate interactions

% Define name for output folder
if cont_index == 1
    fold_name = 'Dems>All'
elseif cont_index == 2
    fold_name = 'Dems>Prons'
elseif cont_index == 3
    fold_name = 'Dems>HvWords'
elseif cont_index == 4
    fold_name = 'Dems<Prons'
elseif cont_index == 5
    fold_name = 'Dems<HvWords'
elseif cont_index == 6
    fold_name = 'Spatial_Positive'
elseif cont_index == 7
    fold_name = 'NonSpatial_Positive'
elseif cont_index == 8
    fold_name = 'Demonstratives>Hvor'
elseif cont_index == 9
    fold_name = 'Demonstratives<Hvor'
elseif cont_index == 10
    fold_name = 'Dyad>Other'
elseif cont_index == 11
    fold_name = 'Dyad<Other'  
elseif cont_index == 12
    fold_name = 'Her'
elseif cont_index == 13
    fold_name = 'Der'
elseif cont_index == 14
    fold_name = 'Jeg'
elseif cont_index == 15
    fold_name = 'Du'
elseif cont_index == 16
    fold_name = 'Han'
elseif cont_index == 17
    fold_name = 'Hvad'
elseif cont_index == 18
    fold_name = 'Hvor'
elseif cont_index == 19
    fold_name = 'Hvem'
elseif cont_index == 20
    fold_name = 'Her>Der'
    elseif cont_index == 21
    fold_name = 'Her_Negative'
elseif cont_index == 22
    fold_name = 'Der_Negative'
elseif cont_index == 23
    fold_name = 'Jeg_Negative'
elseif cont_index == 24
    fold_name = 'Du_Negative'
elseif cont_index == 25
    fold_name = 'Han_Negative'
elseif cont_index == 26
    fold_name = 'Hvad_Negative'
elseif cont_index == 27
    fold_name = 'Hvor_Negative'
elseif cont_index == 28
    fold_name = 'Hvem_Negative'
elseif cont_index == 29
    fold_name = 'Dems_Negative'
elseif cont_index == 30
    fold_name = 'Hv_Negative'
elseif cont_index == 31
    fold_name = 'Prons_Negative'
elseif cont_index == 32
    fold_name = 'Speech'
elseif cont_index == 33
    fold_name = 'SpeechAvg'
end % 620 to 700 is the wrong speech contrasts; 700 726 is wrong average contrast; 

% Variables for output folder
main_folder = ['/projects/MINDLAB2016_MR-demonstratives/result/Oct18_Final/FIR_analysis/' analysis '_SecondLevel'];
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

for bin_nr = 1:20 % Adjust to bins in the contrast
    
    % Define right contrast number 
    cont_nr = bin_nr + 726 %(cont_index - 1) * tot_bins;
    
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

matlabbatch{2}.spm.stats.fmri_est.spmmat(1) = cfg_dep('Factorial design specification: SPM.mat File', substruct('.','val', '{}',{1}, '.','val', '{}',{1}, '.','val', '{}',{1}), substruct('.','spmmat'));
matlabbatch{2}.spm.stats.fmri_est.write_residuals = 0;
matlabbatch{2}.spm.stats.fmri_est.method.Classical = 1;
% 
 spm_jobman('run', matlabbatch);

end
