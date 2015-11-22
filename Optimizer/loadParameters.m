function [parameters] = loadParameters()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    parameters.W0 = 330993; %[kg] MTOW
    parameters.Wcruise = 1; %WRONG 
    parameters.T0 = 211002; %% (lbs)     938585; %[N] Two engines combined. note, its Newton, not kilo-Newton
    
    parameters.Range = 15343820; %[m]
    
    parameters.wCrew =1334; %[kg] 4 pilots plus 10 flight attendeds, 14 people total and their carry on
    parameters.wPayload =5670; %[kg] checked-in luggages for all passengers
    parameters.wPassengers =11340; %[kg] 125 passengers and their carry on
    
    parameters.Lfus = 1; %WRONG -> get from CAD
    parameters.Dfus = 5.79; %[m] fuselage diameter
    parameters.Hfus = 5.79; %[m] fuselage height? (cylinder -> same as diameter)
    parameters.Sref = 511.79; %[m^2]
    parameters.cWing = 12.28; %[m]
    parameters.bWing = 66.42; %[m]
    parameters.sweep = 35; % [degrees] sweep angle
    parameters.taper =  1; %WRONG
    parameters.t_c = 1; %WRONG
    
    Swing_all = 2; %WRONG
    Swing_fus = 1; %WRONG
    parameters.Swing = Swing_all-Swing_fus;
    parameters.SfuseCockpit = 1; %WRONG
    parameters.SfuseCabin = 1; %WRONG
    parameters.SfuseTail = 1; %WRONG
    parameters.Scsurf =1; %WRONG
    parameters.Sengine= 1; %WRONG
    
    parameters.AR = 9; %Aspect Ratio
    
    parameters.mCruise = 0.83; % [--]
    parameters.aCruise = 296.6; % [m/s]
    
    parameters.rho_EWR = 1.25699997; %[kg/m^3] Air Density @ Newark
    parameters.rho_SIN = 1.12659748; %[kg/m^3] Air Density @ Singapore
    parameters.rhoCruise = 0.379641953; %[kg/m^3] Air density @ 35,000 ft
    
    parameters.vCruise = parameters.mCruise*parameters.aCruise; % [m/s]
    parameters.vStall = 1; %WRONG
    
    parameters.qCruise = 0.5*parameters.rhoCruise*parameters.vCruise^2; % 
    
    %-------------------T_W.m---------------------
    parameters.G_1 = 0.005; %Climb Gradients
    parameters.G_2 = 0.024; %Climb Gradients
    parameters.G_3 = 0.012; %Climb Gradients
        
    parameters.CL_climb_1 = 2.7;
    parameters.CL_climb_2 = 2.3;
    parameters.CL_climb_3 = 1.9;
    
    parameters.Neng = 2;
    
    parameters.eClimb = 1; %WRONG
    parameters.eCruise = 1; %WRONG
       
    parameters.S_EWR =1; %WRONG
    parameters.S_SIN =1; %WRONG
        
    parameters.C = 0.53; %[1/hr] TSFC of GE90-110B1L
    parameters.C_loiter = 0.5;
    parameters.C_alt = 0.5;
    
    parameters.Cf = 0.0035; %Estimate from Raymer
    
    parameters.E_loiter = 0.5; %Time in loiter
    parameters.R_alt = 1; %Alternate Range
    parameters.V_alt = 1; % Alternate Cruise Velocity
	parameters.C_alt = 1; % 
	parameters.L_D_alt = 1;
    
    parameters.hBase = 1;
    parameters.hCruise = 1;
    

end
