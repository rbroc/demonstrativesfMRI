% Extract sound envelope
% Load the signal
filename = '/aux/MINDLAB2016_MR-demonstratives/DataCollectionMay/DefStimuli/group_2b.wav';
output_filename = 'envelope_2b';
output_dir = '/projects/MINDLAB2016_MR-demonstratives/scripts/Oct18_Final/SoundEnvelope';
[y, Fs] = audioread(filename);

% Resample and extract first channel
left_resampled = resample(y(:,1), 1, 2);
left_envelope = envelope(left_resampled);

% Right
right_resampled = resample(y(:,2), 1, 2);
right_envelope = envelope(right_resampled);

%Duration in seconds
duration = size(y, 1) / Fs;
TR = 0.388;
TRs_per_sec = 1/TR;

% Compute some parameters for resampling
env_samples_per_sec = Fs/2;
env_rate = 1/env_samples_per_sec;
nr_samples = size(right_envelope, 1);

% Downsample the envelopes
left_envelope_resampled = interp1(0:env_rate:(env_rate * (nr_samples - 1)),... %signal time stamps
    left_envelope(:, 1), ... %signal to resample
    0:TR:(env_rate * (nr_samples - 1)));

right_envelope_resampled = interp1(env_rate:env_rate:duration,... %signal time stamps
    right_envelope(:, 1), ... %signal to resample
    TR:TR:duration); % new time stamps

% Plot resampled envelopes
%figure
%plot(1:size(left_envelope_resampled, 2), left_envelope_resampled(1,:), 'red',...
    %1:size(right_envelope_resampled, 2), right_envelope_resampled(1,:), 'blue')

% Names
names = {'left_envelope', 'right_envelope'};
R = [left_envelope_resampled(1, 1:3670); right_envelope_resampled(1,1:3670)]';
cd(output_dir);
save(output_filename, 'names', 'R');

clear R right_envelope_resampled left_envelope_resampled right_envelope left_envelope y Fs right_resampled left_resampled