function extract_phys_reg(s_min, s_max, type_align, scan_align, slice_align)

%% Performs PhysIO-Regressor generation from Siemens ECG 3T logfile
%type_align: 'nominal', 'scan_timing_log'
%scan_align: 'first', 'last', empty if type align = nominal
%slice_align: nr of slice to align the regressors to

% Load PhysIO package
addpath /users/roberta/matlab/spm_tbx/PhysIO

% Loop over subjects
for s = s_min:s_max

% Initialize structure
physio      = tapas_physio_new();
log_files   = physio.log_files; 
preproc     = physio.preproc;
sqpar       = physio.scan_timing.sqpar;
sync        = physio.scan_timing.sync;
model       = physio.model;        
verbose     = physio.verbose;
save_dir    = physio.save_dir;


%% 0. Load DICOM images

dbhandle = stormdb_get_handle();
project = 'MINDLAB2016_MR-demonstratives';

%Get subjects ID
subjects  = stormdb_get_subjects(dbhandle, project);

% Pick subject
%s = 5;
% Standard subjects 1 a 9, 11 to 28

% Extract files
serieno = stormdb_get_serie_numbers(dbhandle, project, subjects(s), 1, 'MR', 'Story1_mbep2d_bold_MB9_2.5iso_ANC_ON');
DICOM_files = stormdb_get_files(dbhandle, project, subjects(s), 1, 'MR', serieno);

% Work out output directories
scratch_dir = '/projects/MINDLAB2016_MR-demonstratives/scratch/AnalysisFeb';

if subjects(s) < 10
    subj_id_scratch = strcat('00', string(subjects(s)));
else
    subj_id_scratch = strcat('0', string(subjects(s)));
end

% Do some tricks to change directory
main_subj_dir = char(strcat(scratch_dir, '/', subj_id_scratch));
cd(main_subj_dir);

% Create output directory
save_dir = strcat(main_subj_dir, '/physio_data'); 
mkdir physio_data;

% List physiological files: from oldest to newest
phys_dir = '/projects/MINDLAB2016_MR-demonstratives/scratch/AnalysisFeb/physio_data';
phys_files = dir(fullfile(phys_dir, '*.resp'));

% Create some ID codes for output files
slice_ID = num2str(slice_align);

if strcmp(type_align,'nominal') == 1
    type_ID = 'LogAlign';
else
    type_ID = 'DcmAlign';  
end

% Select alignment scan
if strcmp(scan_align, 'first') == 1
    ref_scan = 1;
else
    ref_scan = 3670;
end 

%% 1. Define Input Files

log_files.vendor            = 'Siemens';
log_files.cardiac           = strcat(phys_dir, '/', string(phys_files(s).name(1:end-4)),'puls');
log_files.respiration       = strcat(phys_dir, '/', string(phys_files(s).name(1:end-4)),'resp');
log_files.scan_timing       = string(DICOM_files(ref_scan))
log_files.sampling_interval = []; % in seconds; or leave it empty to retrieve it from logs;
log_files.relative_start_acquisition = 0 ; 
log_files.align_scan = scan_align;

%% 2. Define Nominal Sequence Parameter (Scan Timing)

sqpar.Nslices           = 54;
%sqpar.NslicesPerBeat    = 54;   
sqpar.TR                = 0.388; % in seconds
sqpar.Ndummies          = 0;
sqpar.Nscans            = 3670;  
sqpar.onset_slice       = slice_align;

% Set to >=0 to count scans and dummy
% volumes from beginning of run, i.e. logfile,
% includes counting of preparation gradientssqpar.Nprep             = [];
sqpar.time_slice_to_slice  = sqpar.TR / sqpar.Nslices;

%% 3. Order of RETROICOR-expansions for cardiac, respiratory and
% interaction terms. Option to orthogonalise regressors

model.type = 'RETROICOR';
model.order = struct('c',3,'r',4,'cr',1, 'orthogonalise', 'none');
model.input_other_multiple_regressors = ''; % either .txt-file or .mat-file (saves variable R)
model.output_multiple_regressors = strcat('phys_mov_', subj_id_scratch, '_', type_ID, '_', scan_align, '_', slice_ID, '.txt');

% Include movement regressors
model.movement.include = true; %include = 1
model.movement.file_realignment_parameters = strcat(scratch_dir, '/', subj_id_scratch, '/FuncImg/rp_fSubjectNo0', subj_id_scratch, '-0006-00001-000001-01.txt');  
model.movement.order = 6;
model.movement.outlier_translation_mm = Inf;
model.movement.outlier_rotation_deg = Inf;

%% 4. Define Gradient Thresholds to Infer Gradient Timing (Philips only)
%
% method to determine slice onset times
% 'nominal' - to derive slice acquisition timing from sqpar directly
% 'gradient' or 'gradient_log' - derive from logged gradient time courses
%                                in SCANPHYSLOG-files (Philips only)
sync.method = 'nominal'; %'gradient_log'; 'nominal'


%% 5. Define which Cardiac Data Shall be Used

preproc.cardiac.modality = 'PPU';
preproc.cardiac.initial_cpulse_select.method = 'load_from_logfile'; % using
preproc.cardiac.initial_cpulse_select.method = 'auto_matched'; % auto detection using cross-correlation to a self-calibrated template
preproc.cardiac.posthoc_cpulse_select.method = 'off';

%% 6. Output Figures to be generated

verbose.level           = 1; % 0 = none; 1 = main plots (default);  2 = debugging plots, for setting up new study; 3 = all plots
verbose.fig_output_file = ['PhysIO' 'test_' type_ID '_' scan_align '_' slice_ID '.jpg']; % Physio.tiff, .ps, .fig possible


%% 7. Run the main script with defined parameters

physio.log_files = log_files; 
physio.preproc = preproc;
physio.scan_timing.sqpar = sqpar;
physio.scan_timing.sync = sync;
physio.model = model;        
physio.verbose = verbose;
physio.save_dir = save_dir;

%% 8. Modify default structure
physio = tapas_physio_new('empty', physio);

physio.log_files
%% 9. Create regressors
[physio_out, R, ons_secs] = tapas_physio_main_create_regressors(physio);

end

