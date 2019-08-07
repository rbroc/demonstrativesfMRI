 %-----------------------------------------------------------------------
% Job saved on 09-Mar-2018 11:52:20 by cfg_util (rev $Rev: 6460 $)
% spm SPM - SPM12 (6906)
% cfg_basicio BasicIO - Unknown
% cfg_mindlab MindLab - Unknown
%-----------------------------------------------------------------------

% Define matrix
matlabbatch{1}.spm.stats.con.spmmat = '<UNDEFINED>';

% Side Left > Right
% Create contrasts per each bin (Side)
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i}.tcon.name = ['Bin_' sprintf('%02d',i) '_Left>Right'];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.weights = [zeros(1,i - 1) 1 zeros(1,19) 1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
end
% 
c = 1;

% Side Right > Left
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Right>Left'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) -1 zeros(1,19) -1 zeros(1,19) 1 zeros(1,19) 1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Dems Positive
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Demonstratives_Positive'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1 zeros(1,19) 1 zeros(1,19) 1 zeros(1,19) 1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Dems Neg
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Demonstratives_Negative'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end

c = c + 1;

% Her Positive
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Her_Positive'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1 zeros(1,19) 0 zeros(1,19) 1 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end

c = c + 1;

% Der Positive
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Der_Positive'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 1 zeros(1,19) 0 zeros(1,19) 1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end

c = c + 1;

% Dems Her > Der
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Her>Der'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1 zeros(1,19) -1 zeros(1,19) 1 zeros(1,19) -1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end

c = c + 1;

% Dems Der > Her
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Der>Her'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) -1 zeros(1,19) 1 zeros(1,19) -1 zeros(1,19) 1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end

c = c + 1;

% Interaction1
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Interaction1'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) 1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end

c = c + 1;

% Interaction2
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Interaction2'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) -1 zeros(1,19) 1 zeros(1,19) 1 zeros(1,19) -1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end


%% Delete all
matlabbatch{1}.spm.stats.con.delete = 1;
