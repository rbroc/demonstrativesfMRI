% Import data on dialogue
currentCharacterEncoding = slCharacterEncoding()
slCharacterEncoding('UTF-8')
delimiter='\t';
startRow=2;

%% Open log_file with word onsets
% Specify format of file (%f floating-point number, %s string, %q string
% with quotation marks)
formatSpec='%q%f%q%q%q%q%f%f%q%q%q%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%f%[^\r\n]';
cd '/Users/au571533/Documents/Projects/DemonstrativesfMRI/TextModel/dialogue'
fileID=fopen('log_full.txt', 'r','n','UTF-8');
dataArray=textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines', startRow-1,'ReturnOnError', false, 'EndOfLine', '\r\n');
dataArray(:, 1) = [];
dataArray(:, end) = [];

% Close file
fclose(fileID);

%% Create structure from logfile %%
% Convert to table
logdata(1).logs = table(dataArray{1:end}, 'VariableNames',{'Index', 'wd', 'word_filtered', 'lemma_dk', 'lemma_en',...
    'token_freq','lemma_freq',...
    'in_binder','side','voice',...
    'her','der','jeg','du',...
    'hvad','hvor','hvem','hvorfor','hvordan',...
    'pron', 'prep','func',...
    'is_start','is_end','sent_nr','sent_dur','pos_in_sent','pos_to_end_sent',...
    'turn_nr','turn_offset','turn_dur','pos_in_turn','pos_to_end_turn',...
    'onsets_plus_constant',...
    'Motion_PC','Scene_PC','Near_PC',...
    'Landmark','Path','Scene','Near','Toward','Away', 'det', 'han'});

% Clear useless variables
clearvars filename formatSpec fileID dataArray ans;
%% Select information of interest
% Create variable names for regressors (both groups)
names = {'her', 'der', 'jeg', 'du', 'han', 'hvor', 'hvem', 'hvad', 'breaks_1', 'breaks_2,', 'full_breaks', 'tones'};

% Load onsets to structure fields
hvor = logdata(1).logs.onsets_plus_constant(logdata(1).logs.hvor==1);
hvem = logdata(1).logs.onsets_plus_constant(logdata(1).logs.hvem==1);
hvad = logdata(1).logs.onsets_plus_constant(logdata(1).logs.hvad==1);
her = logdata(1).logs.onsets_plus_constant(logdata(1).logs.her==1);
der = logdata(1).logs.onsets_plus_constant(logdata(1).logs.der==1);
jeg = logdata(1).logs.onsets_plus_constant(logdata(1).logs.jeg==1);
du = logdata(1).logs.onsets_plus_constant(logdata(1).logs.du==1);
han = logdata(1).logs.onsets_plus_constant(logdata(1).logs.han==1);


%% Open log_file with breaks

% Specify format of file (%f floating-point number, %s string, %q string
% with quotation marks)
delimiter = ',';
formatSpec_2='%f%f%f%f%[^\r\n]';
cd '/Users/au571533/Documents/Projects/DemonstrativesfMRI/MayExp_Data&Results/Logs&Onsets/BreaksAndTones'
fileID_2=fopen('breaks_and_tones.txt', 'r','n','UTF-8');
dataArray_2=textscan(fileID_2, formatSpec_2, 'Delimiter', delimiter, 'HeaderLines', startRow-1,'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID_2);

%% Create structure from breaks files %%

% Specify all variable names
logdata_2(1).logs=table(dataArray_2{1:end-1}, 'VariableNames',{'VarName1', 'Start_break', 'ToneOnset', 'ToneGroup'});
% Load onsets to structure fields
tones=logdata_2(1).logs.ToneOnset(logdata_2(1).logs.ToneGroup==1);
breaks_1 = tones - 0.500;
breaks_2 = tones + 0.500;
full_breaks = logdata_2(1).logs.Start_break(logdata_2(1).logs.ToneGroup == 2);

%% Onsets and durations 
onsets={her, der, jeg, du, han, hvor, hvem, hvad, ...
    breaks_1, breaks_2, full_breaks, tones};
durations={0, 0, 0, 0, 0, 0, 0, 0, 0.5, 4, 5, 0.5};

%% Save to paradigm file
cd '/Users/au571533/Documents/Projects/DemonstrativesfMRI/TextModel/dialogue/extractParFiles';
save('full_model_1', 'durations', 'onsets', 'names');