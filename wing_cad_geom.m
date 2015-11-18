%%  Design Parameters
clear all
close all
clc

% metric:
S_new = 511.79 %[m^2]  
AR = 9; %
b = sqrt(AR*S_new) %[m]  %66
taper = 0.2; % = C_t/C_r
w_f = 5.79; %[m]
% sweep_c = ; %[deg]
sweep_LE = 35; %[deg]
dihedral = 5.7; %[deg]
incidence = 1; %[deg]

%% Solve for C_r and C_t
C_r = (S_new/2*(4/b)) / (1 + taper); %[m]

C_t = taper * C_r; %[m]

%% MAC using plamorm trapazoid (no yehudi)
MAC_new = C_r - (2*(C_r - C_t)*(0.5*C_r+C_t)/(3*(C_r+C_t)));

%% Geometry (including yehudi break in @ 1/3 span)

%Center (also called root) C_r + yehudi influence
y_s1 = 0

C_s1 = C_r + ((1/3)*((b/2)*tand(sweep_LE) + C_t - C_r))



%Edge of fuseloge
y_s2 = w_f/2

C_s2 = C_s1 - w_f/2*tand(sweep_LE)

area_fus=(C_s1+C_s2)*y_s2
% post Yehudi break-in at 33.33% wing half span
db = 1/3;

y_s3 = b/2 * db

C_s3 = C_s1 - y_s3 * tand(sweep_LE)


% Section 4 - tip
y_s4 = b/2

C_s4 = C_t

%% New propertied for Geometry

%Calc new area
S_new = 2*((C_s1+C_s3)/2*(y_s3-y_s1) + (C_s3+C_s4)/2*(y_s4-y_s3))

% Calc new MAC
fab = @(y) (C_s1+(C_s3-C_s1)./(y_s3-y_s1).*y).^2;
fbc = @(y) (C_s3+(C_s4-C_s3)./(y_s4-y_s3).*y).^2;

MAC_new = 2/S_new * (integral(fab, y_s1, y_s3) + integral(fbc, y_s3, y_s4))




