%%% Parameters %%%
% Updated 11/17/15 JRG
%
%% Mission parameters
cruise_h = 35000; %[ft] Cruise altitude
M_cruise = 0.83;
a_cruise= 973.1; %[ft/s] Speed of sound @ 35000 ft (std atm table)
V_cruise = M_cruise*a_cruise; %[ft/s] Cruise velocity

rho_EWR = 0.0024389826; %[slugs/ft^3] Air Density @ Newark
rho_SIN = 0.00218596; %[slugs/ft^3] Air Density @ Singapore
rho_cruise = 0.000736627; %[slugs/ft^3] Air density @ 35,000 ft
rho_SL = 0.0023768924; %[slugs/ft^3] Air Density @ PDAS Standard Atmosphere Sea Level

E_loiter = 0.5; %[hr] Duration of loiter phase
R_alt = 200; %[nmi] Alternate range
V_alt = 250; %[ft/s] Alternate cruise velocity
%
%% Aircraft geometry
Sref = 5500; %[ft^2] Wing area
Lfus = 
Dfus = 
%
%% Fuel Weight parameters
C = 0.53; %[lb/(lbf*h)] TSFC of GE90-110B1L
C_loiter = ???
C_alt = ???
T0 = 110000; %[lbf] Maximum thrust per engine
W0 = 729715; %[lb] MTOW
%
%% Drag Polar parameters 
cf = 
Swet_Sref = 
AR = 
e = 
CD0_climb =
K_climb = 
CD0_cruise = 
K_cruise = 
CD0_loiter =
K_loiter = 
L_D_max =
L_D_alt = 
%
%% Design Diagram parameters
sFL = 
Ks =

% Climb Gradients
G_1 = .005;
G_2 = .024;
G_3 = .012;
