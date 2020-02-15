clear all;
close all;
clc;

%% Read the '3.csv' file

data = csvread('3.csv');
real_data = real(data); %read real data
imag_data = imag(data); %read imaginary data
t = linspace(0,100,100);

%% Plot the real and imaginary components of the array snapshot
figure(1);
subplot (2,1,1);
plot(t,real_data);  axis tight;
xlabel('Element Index'); ylabel('Amplitude');
set(gca,'YDir','normal')
title('Real components of the array snapshot');
subplot (2,1,2);
plot(t,imag_data), axis tight;
xlabel('Element Index'); ylabel('Amplitude');
set(gca,'YDir','normal')
title('Imaginary components of the array snapshot');

%% (b) Using FFT to find the direction of arrival (DoA) of the signal from the array snapshot.

f = 2000;
c = 340;
lambda = c/f;      % Incoming Signal Wavelength in (m).
M = data; % Number of Array Elements.
d = lambda/2;    % Element Spacing.
No_of_elements = 100;
n = (1:No_of_elements).'; %ULA
%change the phi as per the source angle
% phi = 46; %source angle
% 
% figure(2);
% K= 100;                          %fft length
% S1= abs(fftshift(fft(M,K))).^2;  %beamformed spectrum
% plot(S1/max(S1));                %plot normalized spectrum
% xlabel('Array index');
% title('Direction of Arrival');


fft_data=fft(data);
figure(8);
plot(abs(fft_data));
xlabel('Array index');
title('FFT plot of the Data')

o = ((46*lambda)/(100*d));
Phi_fft = asind(o);
% figure(10);
% plot(Phi_fft);                %plot normalized spectrum
% xlabel('Array index'); ylabel('Gain');
% title('Direction of Arrival');

% z = exp(1j*2*180*d*K*sin(Phi_fft)/lambda); %steering vector
% figure(11);
% plot(z);


%% Array Pattern
% Define the angle grid.
phi_search = -pi:1.01*pi/180:pi;  %DOAs to search
% phi_search = -pi/2:1*pi/180:pi/2;  %DOAs to search
S2 = zeros(1,length(phi_search)); %preallocate array pattern
for i = 1:length(phi_search)
    v = exp(1j*2*pi*d*n*sin(phi_search(i))/lambda); %steering vector
    S2(i) = abs(M*v);                %spectrum
end
figure(3);
plot(S2/max(S2)); axis tight;         %plot normalized spectrum
xlabel('Angle (0:2pi)')
ylabel('Gain')
set(gca,'YDir','normal')
title('FFT to find DOA for 100 elements');

%% Use the Delay-Sum method to find the direction of arrival (DoA) of the signal from the array snapshot.

phi_taskb = 65;
N_fft = 1024;
C1 = zeros(length(No_of_elements),N_fft);
% Define the angle grid.
angle = -90:180/N_fft:90-1/N_fft;  % Create N_fft angle samples between -90 to 90 deg.

for m=1:length(No_of_elements)
    u_s = (d/lambda)*sin(phi_taskb*pi/180);
    c_mf = exp(-1i*2*pi*u_s*(0:No_of_elements(m)-1).')/sqrt(No_of_elements(m));
    for k=1:N_fft
        u = (d/lambda)*sin(angle(k)*pi/180);
        v = exp(-1i*2*pi*u*(0:No_of_elements(m)-1)')/sqrt(No_of_elements(m)); % Azimuth Scanning Steering Vector.
        C1(m,k)= c_mf'*v;
    end
end

figure(4);
plot(angle,10*log10(abs(C1(1,:)).^2),'b');
title('Delay-Sum to find DOA for 100 elements');
xlabel('Angle (deg)'); ylabel('Power (dB)');
xlim([-90 90]); ylim([-40 5]);
grid on;