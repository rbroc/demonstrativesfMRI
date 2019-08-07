%% Open log_file with breaks
% Specify format of file (%f floating-point number, %s string, %q string
% with quotation marks)
startRow=2;
delimiter = ',';
formatSpec='%f%f%f%f%[^\r\n]';
cd '/projects/MINDLAB2016_MR-demonstratives/scripts/Oct18_Final/logs'
fileID=fopen('breaks_and_tones.txt', 'r','n','UTF-8');
dataArray=textscan(fileID, formatSpec, 'Delimiter', delimiter, 'HeaderLines', startRow-1,'ReturnOnError', false, 'EndOfLine', '\r\n');
fclose(fileID);

%% Create structure from breaks files %%

% Specify all variable names
logdata(1).logs=table(dataArray{1:end-1}, 'VariableNames', {'VarName1', 'Start_break', 'ToneOnset', 'ToneGroup'});
tones=logdata(1).logs.ToneOnset(logdata(1).logs.ToneGroup == 1);

% Define partial breaks
breaks_1 = [(tones - 0.500) repmat(0.5, size(tones, 1), 1)];
breaks_2 = [(tones + 0.500) repmat(4, size(tones, 1), 1)];
full_breaks = [(logdata(1).logs.Start_break(logdata(1).logs.ToneGroup == 2)) ...
    repmat(5, 15, 1)];

% Combine in one matrix
breaks = [breaks_1; breaks_2; full_breaks]; 
breaks = sortrows(breaks,1);

%% Onsets and durations 
names = {'tones'};
onsets={tones};
durations={0.5};

% Breaks
names_breaks = {'breaks'};
onsets_breaks = {breaks(:, 1)};
durations_breaks = {breaks(:,2)};

%% Save to paradigm file
cd '/projects/MINDLAB2016_MR-demonstratives/scripts/Oct18_Final/ParFiles/audio_regressors';
save('audio_group1', 'durations', 'onsets', 'names');
save('breaks_group1', 'durations_breaks', 'onsets_breaks', 'names_breaks');