%% Drag Polar Calcuations

% Input: Cf    -- historical
%        e     -- cruise,climb,land
%        S_ref -- 
%        AR    -- 
%        W_cruise    --  from fuel fract 


%% Wetted Area

% From CAD model
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

S_wet = SfuseCabin + SfuseCockpit + SfuseTail + Shtail + Svtail + Swing + Sengine;


%% Equivalent Parasite Area	

Cf = 0.0035; %Estimate from Raymer

CD0_cruise = S_wet / airplane.S_ref * Cf  %Parasite drag coefficient

% Change in CD0 (Sizing 1: slide 17)
delCD0_takeoff_flaps = 0.015;
delCD0_landing_flaps = 0.065;
delCD0_landing_gear = 0.020;

% VariousCDO
CD0_climb_1 = CD0_cruise+ delCD0_takeoff_flaps + delCD0_landing_gear; %flaps and gear
CD0_climb_2 = CD0_cruise+ delCD0_takeoff_flaps; %takeoff flaps 
CD0_climb_3 = CD0_cruise;
CD0_land_1 = CD0_cruise + delCD0_landing_flaps; %landing flaps
CD0_land_2 = CD0_cruise + delCD0_landing_flaps + delCD0_landing_gear; %landing gear & flaps

%% Span Efficiency (Sizing 1: slide 17) Oswald efficiency factor (Roskam)
e_cruise = 0.85; 
e_climb = 0.80;
e_landing = 0.75;

%% Lift factor (redundant, never used)
K_cruise = (pi*AR*e_cruise)^-1; 
K_climb = (pi*AR*e_climb)^-1;
K_landing = (pi*AR*e_landing)^-1;

% Velocity at cruise
v_cruise = mCruise*aCruise;

% Dynamic Pressure
q_cruise = .5*rho_cruise*v_cruise^2;

%% CLmax (Sizing 1: slide 20) %using high lifting desive vs sweep plot
CLmax_cruise = 1.4;
CLmax_landing = 2.6; %using high lifting desive vs sweep plot
CLmax_climb = .8 * CLmax_landing; 

%% CL

% K_s safety factor
K_s_land = 1.3;
K_s_climb = 1.2;

CL_cruise = 1/(q_cruise)*WCruise/S_ref
CL_climb = CLmax_climb / K_s_climb^2  %CLmax/K_s^2
CL_landing = CLmax_landing / K_s_land^2  %CLmax/K_s^2

