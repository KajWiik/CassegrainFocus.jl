%% mca-meas.m

%% datan luku
% folder: /home/pkirves/MCA/main_profile_meas

% p1 = dlmread('panel1');
% p2 = dlmread('panel2');
% p3 = dlmread('panel3');
% 
% p3Voffset = 143;
% p3Roffset = 31;
%...

load('meas-160517.mat')

%% adjust
% tilt panel 1 data:
% tilt error = 0 at rim
% tilt error = 44 mm at center

tilt1 = -44/(p1(end,1)-p1(1,1)) * (linspace(p1(1,1),p1(end,1),size(p1,1))' - p1(end,1));

% tilt panel 3 data:
% tilt error = 0 at rim
% tilt error = 15 mm at center

tilt3 = -15/(p3(end,1)-p3(1,1)) * (linspace(p3(1,1),p3(end,1),size(p3,1))' - p3(end,1));

%% Main reflector
figure(1) % profile
clf
mainDishDepth = 1100;
extraOffset = 36;

plot(p1(:,1)-p1Roffset, mainDishDepth + extraOffset - (p1(:,2)-p1Voffset+tilt1), ...
    p2(:,1)-p2Roffset,  mainDishDepth + extraOffset - (p2(:,2)-p2Voffset), ...
    p3(:,1)-p3Roffset,  mainDishDepth + extraOffset - (p3(:,2)-p3Voffset+tilt3))

% plot(p1(:,1)-p1Roffset, p1(:,2)-p1Voffset+tilt1, ...
%     p2(:,1)-p2Roffset,  p2(:,2)-p2Voffset, ...
%     p3(:,1)-p3Roffset,  p3(:,2)-p3Voffset+tilt3)

figure(2) % 3D
clf
[X,Y,Z] = cylinder(p1(:,1), 12);

surf(X,Y,127-ones(size(Z)).*p1(:,2)/10) % to centimeters..
hold on

%% Subreflector

subrefl = dlmread('subrefl-profile-meas.txt');
sub_apex = 152; % Subreflector apex height

figure(1)
hold on
plot(subrefl(:,1)/10, subrefl(:,2)+1520)
hold off

[U,V,W] = cylinder(subrefl(:,1)/10,12); % to centimeters
figure(2)
surf(U,V,sub_apex-subrefl(1,2)/10+ones(size(W)).*subrefl(:,2)/10) % to centimeters

hold off

% equation
% x^2/a^2 + y^2/b^2 - z^2/c^2 = -1
% curve fitting with cftool:
% z = c/a*sqrt(x^2+a^2)
% a = 41.14
% b = a
% c = sqrt(41.14^2 + 20.72^2) = 46.06

