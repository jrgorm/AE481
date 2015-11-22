function [ dragP ] = dragPolar(parameters,tailParameters)
%UNTITLED10 Summary of this function goes here
%   Detailed explanation goes here

%% Drag Polar Calcuations

% Input: Cf    -- historical
%        e     -- cruise,climb,land
%        S_ref -- 
%        AR    -- 
%        W_cruise    --  from fuel fract 


Cf = parameters.Cf;
AR = parameters.AR;

%% Wetted Area

% From CAD model
SfuseCabin = parameters.SfuseCabin; %m^2 Calc using surface area of tube

SfuseCockpit = parameters.SfuseCockpit; %
SfuseTail = parameters.SfuseTail;

Shtail = tailParameters.Sht; %
Svtail = tailParameters.Svt; %
Sengine = parameters.Sengine; %

Swing = parameters.Swing; %%% (subract wetted area of wing inside fuselage from total wing wetted area)

S_wet = SfuseCabin + SfuseCockpit + SfuseTail + Shtail + Svtail + Swing + Sengine;

S_ref = parameters.Sref;

Wcruise = parameters.Wcruise;

%% Equivalent Parasite Area	
CD0_cruise = S_wet / S_ref * Cf;  %Parasite drag coefficient
dragP.CD0_cruise = CD0_cruise;

dragP.CD0_loiter = CD0_cruise; % "Same as cruise" -Tim

% Change in CD0 (Sizing 1: slide 17)
delCD0_takeoff_flaps = 0.015;
delCD0_landing_flaps = 0.065;
delCD0_landing_gear = 0.020;

% VariousCDO
dragP.CD0_climb_1 = CD0_cruise+ delCD0_takeoff_flaps + delCD0_landing_gear; %flaps and gear
dragP.CD0_climb_2 = CD0_cruise+ delCD0_takeoff_flaps; %takeoff flaps 
dragP.CD0_climb_3 = CD0_cruise;
dragP.CD0_land_1 = CD0_cruise + delCD0_landing_flaps; %landing flaps
dragP.CD0_land_2 = CD0_cruise + delCD0_landing_flaps + delCD0_landing_gear; %landing gear & flaps

%% Span Efficiency (Sizing 1: slide 17) Oswald efficiency factor (Roskam)
e_cruise = 0.85; 
e_climb = 0.80;
e_landing = 0.75;

%% Lift factor (redundant, never used)
dragP.K_cruise = (pi*AR*e_cruise)^-1; 
dragP.K_loiter = dragP.K_cruise;

dragP.K_climb = (pi*AR*e_climb)^-1;
dragP.K_landing = (pi*AR*e_landing)^-1;

% Dynamic Pressure
q_cruise =parameters.qCruise;

%% CLmax (Sizing 1: slide 20) %using high lifting desive vs sweep plot
dragP.CLmax_cruise = 1.4;
dragP.CLmax_landing = 2.6; %using high lifting desive vs sweep plot
dragP.CLmax_climb = .8 * dragP.CLmax_landing; 

%% CL

% K_s safety factor
K_s_land = 1.3;
K_s_climb = 1.2;

dragP.CL_cruise = 1/(q_cruise)*Wcruise/S_ref;
dragP.CL_climb = dragP.CLmax_climb / K_s_climb^2;  %CLmax/K_s^2
dragP.CL_landing = dragP.CLmax_landing / K_s_land^2;  %CLmax/K_s^2


end

