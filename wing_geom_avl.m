%%  Design Parameters
clear all
close all
clc

% metric:
S = 511.79; %[m^2]  
AR =9; %
b = sqrt(AR*S); %[m]  %66
taper = 0.2; % = C_t/C_r
w_f = 5.79; %[m]
% sweep_c = ; %[deg]
sweep_LE = 35; %[deg]
dihedral = 5.7; %[deg]
incidence = 1; %[deg]

%solve for C_r
C_r = (S/2*(4/b)) / (1 + taper); %[m]

C_t = taper * C_r; %[m]

%MAC using plamorm trapazoid (no yehudi)
MAC = C_r - (2*(C_r - C_t)*(0.5*C_r+C_t)/(3*(C_r+C_t)));

% metric to english:
mft = 3.28084; %[ft/m]
squ_mft = 10.7639; %[ft^2/m^2]

S = S*squ_mft; %[ft^2]
b = b * mft; %[ft]
w_f = w_f * mft; %[ft]
C_r = C_r * mft; %[ft]
C_t = C_t * mft; %[ft]
MAC = MAC * mft; %[ft]


%%  goal: Define Leading edge in x,y,z componects, chord, agle of incidence
% x - sweep
% y - span
% z - dihedral
% chord - tapper
% angle of incidence - geom twist
% airfoil - aerodynamic twist

% SECTION 1 - Center (also called root)
y_s1 = 0

C_s1 = C_r + ((1/3)*((b/2)*tand(sweep_LE) + C_t - C_r))

x_s1 = 0

z_s1 = 0



% SECTION 2 - Edge of fuseloge
y_s2 = w_f/2

C_s2 = C_s1 - w_f/2*tand(sweep_LE)


x_s2 = y_s2 * tand(sweep_LE)

z_s2 = 0


% SECTION 3 - post Yehudi break in
% at 25% wing half span
db = 1/3;

y_s3 = b/2 * db

C_s3 = C_s1- y_s3 * tand(sweep_LE)

x_s3_ = y_s3 * tand(sweep_LE)

z_s3 = (y_s3 - y_s2) * tand(dihedral)


% Section 4 - tip
y_s4 = b/2

C_s4 = C_t

x_s4 = y_s4 * tand(sweep_LE)

z_s4 = (y_s4 - y_s2) * tand(dihedral)


