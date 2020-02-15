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

d1 = 2*lambda;
d2 = lambda/2;
% n = 10;
theta = -pi:pi/180:pi;
r1 = zeros(1,length(theta));

% Run a for loop 10 times for d = l/2
for m = 1:7
    if m == 1 %|| m == 2 %|| m == 4
        dx(m,:) = (m-1)*d1*sin(theta);
        r_a_1 = r1+exp(1i*2*pi*(dx(m,:)/lambda));
    else
        dx(m,:) = (m-1)*d2*sin(theta);
        r_a_5 = r1+exp(1i*2*pi*(dx(m,:)/lambda));      
    end
end
%
for jj = 1:181
    phi = deg2rad(jj-91);
for ii = 1:10
    S(ii,jj) = exp(-1j*(ii-1)*d_a*sin(phi)*2*pi/l);
    S(2,jj) = 0;
    S(3,jj) = 0;
    S(4,jj) = 0;
end
end
plot(phi, abs(S(ii,jj)), 'b');
% for j = 2:7
%   dx(j,:) = (j-1)*d_b*sin(theta);
%   r_a_5 = r_a+exp(1i*2*pi*(dx(j,:)/lambda));
% end
r1 = r_a_1 + r_a_5;
real_a = real(r1);
% for m = 1:n
%     dx(m,:)=(m-1)*d_a*sin(theta) + (m-1)*d_b*sin(theta);
%     r_a=r_a+exp(1i*2*pi*(dx(m,:)/l));
% end
%% plotting the directional gain of the ULAs
figure(1);
polar(theta,abs(r1),'b')
figure(2);
plot (theta,abs(real_a));
title ('Gain of a Uniform Linear Array')