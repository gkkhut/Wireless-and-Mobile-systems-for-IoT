clc;
clear all;
close all;

%% Defining the Parameters
ft = 2000; % Target frequency = 2 kHz
c = 340;   % Speed of sound = 340m/s
lambda = c/ft;  % Wavelength
no_of_elements = 10;
theta = -pi:pi/180:pi;

%% Inter-element distance is half of the wavelength (lambda/2)

Inter_dist_a = lambda/2;
r1 = zeros(1,length(theta));

for m = 1:no_of_elements
  dx(m,:) = (m-1)*Inter_dist_a*sin(theta);
  r1 = r1+exp(1i*2*pi*(dx(m,:)/lambda));
end

% Plot the directional gain of the ULAs
figure(3);
polar(theta,abs(r1))
title ('Gain of a Uniform Linear Array for d = lambda/2')

%% Inter-element distance is Twice of the wavelength (2*lambda)

Inter_dist_b = 2*lambda;
r2 = zeros(1,length(theta));

for m = 1:no_of_elements
  dx_new(m,:) = (m-1)*Inter_dist_b*sin(theta);
  r2 = r2+exp(-1i*2*pi*(dx_new(m,:)/lambda));
end

% Plot the directional gain of the ULAs
figure(4)
polar(theta,abs(r2))
title ('Gain of a Uniform Linear Array for d = 2*lambda')