 %-----------------------------------------------------------------------
% Job saved on 09-Mar-2018 11:52:20 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
% cfg_mindlab MindLab - Unknown
%-----------------------------------------------------------------------

% Define matrix
matlabbatch{1}.spm.stats.con.spmmat = '<UNDEFINED>';

% Side any speech
% Create contrasts per each bin (Side)
for i = 1:80
matlabbatch{1}.spm.stats.con.consess{i}.tcon.name = ['Bin_' sprintf('%02d',i) '_Speech'];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.weights = [zeros(1,160) zeros(1,i - 1) -1 zeros(1,80 - i)];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
end
% 


%% Delete all
matlabbatch{1}.spm.stats.con.delete = 0;