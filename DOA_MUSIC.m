clc
clear all;

doa = (20)/180*pi; % Direction of arrival of Source
N = 200; % No. of Snapshots
w = (pi/2)'; % Frequency
M = 4; % Number of array elements
P = length(w); % Number of signal
lambda = 150; % Wavelength
d = lambda/2; % Array element spacing
snr = 0; % Signal to Noise Ratio

%% Constructing the Steering matrix
D = zeros(P,M); % To create a matrix with P row and M column
for k = 1:P
    D(k,:) = exp(-1j*2*pi*d*sin(doa(k))/lambda*(0:M-1)); % Generating the matrix
end

D = D'; % Inverting the matrix
xx = 2*exp(1j*(w*(1:N))); % Simulated signal
x = D*xx; % obtained final signal
x = x+awgn(x,snr); % Adding Gaussian white noise

%% Estimating the covariance matrix
R = x*x'; % Data covarivance matrix

%% Finding the noise subspace
[N,V] = eig(R); % Find the eigenvalues and eigenvectors of R
NoiseSub = N(:,1:M-P); % Estimate noise subspace

%% Estimating DOA

theta = -90:0.5:90; % Peak search
for ii = 1:length(theta)
a = zeros(1,length(M));
for jj = 0:M-1
    a(1+jj) = exp(-1j*2*jj*pi*d*sin(theta(ii)/180*pi)/lambda); 
end
PP = (a)*(NoiseSub)*(NoiseSub)'*(a)'; 
music(ii) = abs(1/ PP);
end

music = 10*log10(music/max(music)); % Spatial spectrum function

plot(theta,music,'b')
xlabel('angle \theta/degree')
ylabel('Spatial spectrum/dB')
title('DOA estimation using MUSIC algorithm ')
grid on