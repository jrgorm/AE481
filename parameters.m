%%% MOST RECENT PARAMETERS FOR PDR
% Updated 11/9/2015 Author: ---


%%% Weight Estimation Parameters %%%

% 125 PAX @ (180 lbs + 120 lbs luggage)
% 14 crew @ (180 lbs + 30 lbs luggage)

wPayload = 125*(180+100+20);
wCrew = 14*(180+30);
Range = 8285; % in nmi
mCruise = 0.83; % Cruise mach number
ftPerNm=6076.1; % conversion factor
secsPerHr=3600; % conversion factor
lOverDCruise=16; % Typical value for Commercial Jets (Roskam)
cjCruise=0.5; % 1/hr (Roskam)
aCruise=973.1; % ft/s at 35000 ft (std atm table)
A=1.6689; % (Roskam)
B=0.75291; % (Roskam)
R_L = 30; % Airframe Maintainance Rate

%%% Cost Estimation Parameters %%%
MTOW = 729715.187572647; %% Maximum take off weight (final)
wE = 324490.565305081;
Wfuel = 364784.622267566; %%% Weight of Fuel at takeoff
weightEstimation_initial;
WCruise = wE + Wfuel*ff1*ff2*ff3*ff4*ff5; % W at beginning of cruise: wE + Wfuel*ff1*ff2*ff3*ff4*ff5
T0 = 211002.4868/2; %% Engine max thrust (pounds)
Neng = 2; %% Number of engines
Ncrew = 4; %% number of flight crew

AF = 1.0; %Airline factor
K = 7.5; %%% Route Factor

Nattd = 10; %%% number of flight attendants
PricefuelPerGallon = 6.00 ; %%% price fuel per gallon (US dollars)
DensityFuel = 7.14; %%% fuel density (JET-A) (pounds per gallon)

tb = 20; %%% Block time (hours) 
MaintenanceLaborRate = 73; %%% maintenance labor rate for engines (USDollars/day) 
InsuranceRate = 0.02; %%% insurance rate 

%%% Sizing
AR = 9; %Aspect Ratio (PDR VALUE)
AR_hist = 7.5;%Aspect Ratio	- (OLD ITERATION)
b_hist = 200; %Historical wingspan [ft] (PDR VALUE)
e = 0.930; %Span Efficiency	
S_hist = (b_hist^2)/AR_hist;

k = 0.04; 
ks = 1.2; %stall factor

rho_cruise = 0.000736627;           %Air density @ 35,000 ft [slugs/ft^3]
rho_EWR = 	0.0024389826;           %Air Density [slugs/ft^3]
rho_SL = 0.0023768924;              %Air Density @ PDAS Standard Atmosphere Sea Level [slugs/ft^3]
rho_SIN = 0.00218596;               %Air Density @ PDAS Standard Atmosphere Sea Level [slugs/ft^3] 

%Runway lengths
S_SIN = 13123; %% Singapore Runway Length
S_EWR = 11000; %% Newark Runway Length
