clc;
clear all;
close all;

%% Defining the Parameters
ft = 2000; % Target frequency = 2 kHz
c = 340;   % Speed of sound = 340m/s
lambda = c/ft;  % Wavelength
no_of_elements = 10;
theta = -pi:pi/180:pi;

%% Inter-element distance is (2*lambda) between 1 & 5 and (lambda/2) for the rest.
d1=lambda/2;
d2=2*lambda;
n=10;
r1=zeros(1,length(theta));

for m = 1:n
  dx(m,:)=(m-1)*d1*sin(theta);
  dx(2,1:361) = 0;
  dx(3,1:361) = 0;
  dx(4,1:361) = 0;
  r1 = r1+exp(1i*2*pi*(dx(m,:)/lambda));
end

% Plot the directional gain of the ULAs
figure(1);
polar(theta,abs(r1))
title ('Gain of a ULA with faulty sensors')