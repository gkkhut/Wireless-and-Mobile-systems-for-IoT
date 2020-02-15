clear all;
close all;
clc;

%% Load the audio file
[xt, fst] = audioread('transmitSignal.wav');
[xr, fsr] = audioread('3.wav');
%% Play the sound
% wave contains the samples of the audio signal and fs is the sampling frequency.
%soundsc(xt,fst); %play to check the correct fs
%soundsc(xr,fsr); %play to check the correct fs

%% Plotting the amplitude vs time plot

figure(1);
t=0:1/fst:(length(xt)-1)/fst;
subplot (2,1,1);
plot(t, xt); title('Transmitted Signal');axis tight;
xlabel('Time in Seconds'); ylabel('Amplitude');
% axis([0 1.8545 -1 1])

t=0:1/fsr:(length(xr)-1)/fsr;
subplot (2,1,2);
plot(t, xr); title('Received Signal');axis tight;
xlabel('Time in Seconds'); ylabel('Amplitude');
% axis([0 9.27764 -1 1])

%% Cross correlation:
% Where tx is one data set and rx is the other. 
% The xcorr function will return the correlation and the index for each
% correlation as lag.
% With that you can find the index of the max value for the correlation and
% then use that index to look up the lag. 
% This will be the delay in samples, within the precision of your sample rate:
 
[corr,lag] = xcorr(xr, xt);
figure(2);
plot(lag/fsr,corr);axis tight;
xlabel('Time in Seconds'); ylabel('Amplitude')
title('Cross-correlation between Transmitted signal & Received Signal')

%% Distance Calculation
[~,I] = max(abs(corr));
sample_difference = lag(I);
time_difference = sample_difference/fsr;
distance = time_difference*340;
fprintf ('distance in meters = %d',distance);
