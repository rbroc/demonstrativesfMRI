 %-----------------------------------------------------------------------
% Job saved on 09-Mar-2018 11:52:20 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
% cfg_mindlab MindLab - Unknown
%-----------------------------------------------------------------------

% Define matrix
matlabbatch{1}.spm.stats.con.spmmat = '<UNDEFINED>';

% Demonstratives > all
% Create contrasts per each bin (Side)

% Her
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i}.tcon.name = ['Bin_' sprintf('%02d',i) '_Her_Negative'];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.weights = [zeros(1,i - 1) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
end
c = 1;

% Der
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Der_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Hvad
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Hvad_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Hvor
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Hvor_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Hvem
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Hvem_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) -1 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Jeg
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Jeg_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 0 zeros(1,19) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Du
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Du_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Han
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Han_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Demonstratives negative
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Dems_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) -1 zeros(1,19) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Hv-words negative
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Hv_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;


% Pronouns negative
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Prons_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 0 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;


%% Delete all
matlabbatch{1}.spm.stats.con.delete = 0;