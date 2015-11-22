%%% Drag Polar Calcuations and Plotting

parameters2;

%%% Design Wetted Area & Ref Area
%%% From CAD model
r_fus = 9.5; %%% ft
h_fus = 144; %%% ft
SfuseCabin = 2*pi*r_fus*h_fus; %ft^2 Calc using surface area of tube

SfuseCockpit = 1322; %%% ft^2 (wetted)
SfuseTail = 2488; %%% ft^2 (wetted)

Shtail = 2243; %%% ft^2 (wetted)
Svtail = 1184; %%% ft^2 (wetted)
Sengine = 883 * 2; %%% ft^2 (2 engines wetted exterior area)

Swing_all = 12744.5; %%% ft^2 ** (wetted main wing area)
Swing_fus = 2 * 1065.63; %%% ft^2 (wetted area of wing residing inside fuselage)
Swing = Swing_all - (Swing_fus); %%% (subract wetted area of wing inside fuselage from total wing wetted area)

S_wet_CAD = SfuseCabin + SfuseCockpit + SfuseTail + Shtail + Svtail + Swing + Sengine;

S_ref_CAD = 5508.86171; %%% design point reference area of wing (ft^2)

%% Raymer Estimated Wetted Area	

% Constants (Roskam)

S_ref_hist = S_hist;  

Swet_Sref_hist = 6.25; %%% Estimate (Raymer)

Swet_hist = Swet_Sref_hist * S_ref_hist; %%% check resulting wetted area
		
% Swet/Sref:
Swet_Sref_hist = 6.25; %%% Estimate from historical trends (Raymer) 

%% Choose Calc vs. Hist case
S_wet = S_wet_CAD;

S_ref = S_ref_CAD;

Swet_Sref_CAD = S_wet/S_ref;

%% Equivalent Parasite Area	

Cf = 0.0035; %Estimate from Raymer

f = 85;

CD0_cruise_hist = Cf*Swet_Sref_hist;

CD0_cruise = S_wet/S_ref*Cf  %Parasite drag coefficient

%%% Change in CD0 (Sizing 1: slide 17)
delCD0_takeoff_flaps = 0.015;
delCD0_landing_flaps = 0.065;
delCD0_landing_gear = 0.020;

%%% VariousCDO
CD0_climb_1 = CD0_cruise+ delCD0_takeoff_flaps + delCD0_landing_gear %flaps and gear
CD0_climb_2 = CD0_cruise+ delCD0_takeoff_flaps %takeoff flaps 
CD0_climb_3 = CD0_cruise
CD0_land_1 = CD0_cruise + delCD0_landing_flaps %landing flaps
CD0_land_2 = CD0_cruise + delCD0_landing_flaps + delCD0_landing_gear %landing gear & flaps

%%% Span Efficiency (Sizing 1: slide 17) Oswald efficiency factor (Roskam)
e_cruise = 0.85; 
e_climb = 0.80;
e_landing = 0.75;

%%% Lift factor
K_cruise = (pi*AR*e_cruise)^-1; 
K_climb = (pi*AR*e_climb)^-1;
K_landing = (pi*AR*e_landing)^-1;

%%% Velocity at cruise
v_cruise = mCruise*aCruise;

%%% Dynamic Pressure
q_cruise = .5*rho_cruise*v_cruise^2;

%%% CLmax (Sizing 1: slide 20) %using high lifting desive vs sweep plot
CLmax_cruise = 1.4;
CLmax_landing = 2.6; %using high lifting desive vs sweep plot
CLmax_climb = .8 * CLmax_landing; 

%%% CL: Here we impliment the saftey factors
CL_cruise_pt = 1/(q_cruise)*WCruise/S_ref;
CLmax_climb = CLmax_climb / 1.2^2;  %CLmax/K_s^2
CLmax_landing = CLmax_landing / 1.3^2;  %CLmax/K_s^2

%%%  Create Drag Polar Plot
CL_cruise = -1:.01:CLmax_cruise;
CL_climb = -1:.01:CLmax_climb;
CL_landing = -1:.01:CLmax_landing;

CD_cruise = CD0_cruise+K_cruise.*CL_cruise.^2; 
CD_climb_1 = CD0_climb_1+K_climb.*CL_climb.^2;
CD_climb_2 = CD0_climb_2+K_climb.*CL_climb.^2;
CD_landing_1 = CD0_land_1+K_landing.*CL_landing.^2;
CD_landing_2 = CD0_land_2+K_landing.*CL_landing.^2;

CD_cruise_pt = CD0_cruise+K_cruise.*CL_cruise_pt.^2;
LD_cruise = CL_cruise_pt/(CD0_cruise+K_cruise.*CL_cruise_pt.^2)

x = 0:.001:.1;
LDmax = 1/(2*K_cruise*sqrt(CD0_cruise/K_cruise))*x;


