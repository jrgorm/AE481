%%% Parameters %%%
% Updated 11/19/15 JRG
%
%% Mission parameters
cruise_h = 10668; %[m] Cruise altitude
hbase = 10.668; %[m] Altitude at start of climb
M_cruise = 0.83;
a_cruise= 296.60088; %[m/s] Speed of sound @ 35000 ft (std atm table)
V_cruise = M_cruise*a_cruise; %[m/s] Cruise velocity
R = 15343820; %[m] Mission range (8285 nmi)
rho_EWR = 1.25699997; %[kg/m^3] Air Density @ Newark
rho_SIN = 1.12659748; %[kg/m^3] Air Density @ Singapore
rho_cruise = 0.379641953; %[kg/m^3] Air density @ 35,000 ft
rho_SL = 1.225; %[kg/m^3] Air Density @ PDAS Standard Atmosphere Sea Level

E_loiter = 30*60; %[sec] Duration of loiter phase
R_alt = 370400; %[m] Alternate range
V_alt = 75; %[m/s] Alternate cruise velocity
%
%% Aircraft geometry
Sref = 511.79; %[m^2] Wing area
% Lfus = 
% Dfus = 
%
%% Fuel Weight parameters
C = 0.53/3600; %[1/hr] TSFC of GE90-110B1L
C_loiter = .3/3600
C_alt = .5/3600
T0 = 469295; %[N] Maximum thrust per engine
W0 = 3243732.93149059; %[N] MTOW
V_stall = 62.3127; %[m/s] Stall speed
%
%% Drag Polar parameters 
% cf = 
% Swet_Sref = 
% AR = 
e = .9;
CD0_climb =.0529;
CD0_climb2 = .0329;
CD0_climb3 = .0179;
K_climb = 0.044209706414415;
CD0_cruise = .0179;
K_cruise = 0.041609135448862;
CD0_loiter =.0329;
K_loiter = 0.041609135448862;
L_D_TO = 7.3;
L_D_max = 16.4;
L_D_alt = 10;
%
%% Design Diagram parameters
% sFL = 
% Ks =

% Climb Gradients
G_1 = .005;
G_2 = .024;
G_3 = .012;
