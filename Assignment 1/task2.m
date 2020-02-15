 [x, fs] = audioread('3.wav');
 frame_overlap = 0; % ms
 frame_length  = 512;
 window        = 'hamming';

 nfft = round(frame_length  * fs / 1000); % convert ms to points
 noverlap = round(frame_overlap * fs / 1000); % convert ms to points
 window   = eval(sprintf('%s(nfft)', window)); % e.g., hamming(nfft)

 [S, F, T, P] = spectrogram(x, window, noverlap, nfft, fs);
 spectrogram(x, window, noverlap, nfft, fs, 'yaxis'); % plot
 colormap winter;