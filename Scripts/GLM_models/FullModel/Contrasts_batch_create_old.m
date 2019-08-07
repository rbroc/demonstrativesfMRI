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
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i}.tcon.name = ['Bin_' sprintf('%02d',i) '_Dems>All'];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.weights = [zeros(1,i - 1) 3 zeros(1,19) 3 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i}.tcon.sessrep = 'none';
end
% 
c = 1;

% Dems > Prons
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Dems>Prons'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1.5 zeros(1,19) 1.5 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Dems > Hv-Words
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Dems>HvWords'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1.5 zeros(1,19) 1.5 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) -1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;


% Dems < Prons
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Dems<Prons'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) -1.5 zeros(1,19) -1.5 zeros(1,19) 1 zeros(1,19) 1 zeros(1,19) 1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Dems < Hv-Words
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Dems<HvWords'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) -1.5 zeros(1,19) -1.5 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 1 zeros(1,19) 1 zeros(1,19) 1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% All Spatial
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Spatial_Positive'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1 zeros(1,19) 1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% All Non-Spatial
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_NonSpatial_Positive'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 0 zeros(1,19) 0 zeros(1,19) 1 zeros(1,19) 1 zeros(1,19) 1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 1 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Demonstratives > Hvor
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Demonstratives>Hvor'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1 zeros(1,19) 1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) -2 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Demonstratives < Hvor
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Demonstratives<Hvor'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) -1 zeros(1,19) -1 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 2 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% Dyad > 3rd person
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Dyad>Other'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) 1 zeros(1,19) -1.5 zeros(1,19) 1 zeros(1,19) 1 zeros(1,19) -1.5 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end
c = c + 1;

% 3d person > Dyad
for i = 1:20
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.name = ['Bin_' sprintf('%02d',i) '_Dyad<Other'];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.weights = [zeros(1,i - 1) -1 zeros(1,19) 1.5 zeros(1,19) -1 zeros(1,19) -1 zeros(1,19) 1.5 zeros(1,19) 0 zeros(1,19) 0 zeros(1,19) 0 zeros(1,20 - i)];
matlabbatch{1}.spm.stats.con.consess{i + 20 * c}.tcon.sessrep = 'none';
end


%% Delete all
matlabbatch{1}.spm.stats.con.delete = 1;
