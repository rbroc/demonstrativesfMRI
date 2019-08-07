 %-----------------------------------------------------------------------
% Job saved on 09-Mar-2018 11:52:20 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
% cfg_mindlab MindLab - Unknown
%-----------------------------------------------------------------------

% Define matrix
matlabbatch{1}.spm.stats.con.spmmat = '<UNDEFINED>';

for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i}.tcon.name = ['Bin_' sprintf('%02d',i) '_Right>Left'];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) -1 zeros(1,19) 1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
end

% Right < Left
c = 1
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Right<Left'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 1 zeros(1,19) -1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end


%% Delete all
matlabbatch{1}.spm.stats.con.delete = 0;
