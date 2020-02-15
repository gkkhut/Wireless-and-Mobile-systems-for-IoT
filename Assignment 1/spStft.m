% audio_stft = stft(audio_signal,window_function,step_length)
            % stft Short-time Fourier transform (STFT)
            %   audio_stft = z.stft(audio_signal,window_function,step_length);
            %   
            %   Arguments:
            %       audio_signal: audio signal [number_samples,1]
            %       window_function: window function [window_length,1]
            %       step_length: step length in samples
            %       audio_stft: audio STFT [window_length,number_frames]
            %   
            %   Example: Compute and display the spectrogram of an audio file
 %% Audio signal averaged over its channels and sample rate in Hz
  [audio_signal,sample_rate] = audioread('3.wav');
  audio_signal = mean(audio_signal,2);

  % Window duration in seconds (audio is stationary around 40 milliseconds)
  window_duration = 0.04;

  % Window length in samples (power of 2 for fast FFT and constant overlap-add (COLA))
  window_length = 2^nextpow2(window_duration*sample_rate);

  % Window function (periodic Hamming window for COLA)
  window_function = hamming(window_length,'periodic');

  % Step length in samples (half the window length for COLA)
  step_length = window_length/2;

  % Magnitude spectrogram (without the DC component and the mirrored frequencies)
  audio_stft = z.stft(audio_signal,window_function,step_length);
  audio_spectrogram = abs(audio_stft(2:window_length/2+1,:));

  % Spectrogram displayed in dB, s, and kHz
  figure
  imagesc(db(audio_spectrogram))
  axis xy
  colormap(jet)
  title('Spectrogram (dB)')
  xticks(round((1:floor(length(audio_signal)/sample_rate))*sample_rate/step_length))
  xticklabels(1:floor(length(audio_signal)/sample_rate))
  xlabel('Time (s)')
  yticks(round((1e3:1e3:sample_rate/2)/sample_rate*window_length))
  yticklabels(1:sample_rate/2*1e-3)
  ylabel('Frequency (kHz)')
  set(gca,'FontSize',30)
%%
