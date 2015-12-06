function [parameters] = loadParameters()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    parameters.W0 = 729714.655; %% lbs       330993*9.8; %[N] MTOW
    parameters.Wcruise = 551155.655; %% (lbs)      250000 (kg);
    parameters.T0 =   211002*0.85; %%%  (lbs)  938585*0.85; %[N] Two engines combined. %%% 85% thrust of GE9X for thrust "efficiency"
     
    parameters.Range = 8285; %%% (nmi)      15343820; %[m]
    
    parameters.wCrew =2940.967; %%%% (lbs)   1334; %[kg] 4 pilots plus 10 flight attendeds, 14 people total and their carry on
    parameters.wPayload = 12500; %% (lbs)      5670; %[kg] checked-in luggages for all passengers
    parameters.wPassengers = 25000; %%% 11340; %[kg] 125 passengers and their carry on
    
    parameters.Lfus = 144 ; %%% (ft)     43.8912; %[m]
    parameters.Dfus = 19; %%% (ft)     5.79; %[m] fuselage diameter
    parameters.Sref = 5508.86171; %%% (ft^2) 511.79; %[m^2]
    parameters.cWing = 40.288714; %% (ft)    12.28; %[m]
    parameters.bWing = 217.91339; %%% (ft)   66.42; %[m]
    parameters.sweep = 35; % [degrees] sweep angle
    parameters.taper =    0.2; %
    parameters.t_c = 0.1; %Boeing J airfoil
    
    Swing_all = 12744.47; %% (ft^2) 1184; %[m^2]
    Swing_fus = 2131.25; %% (ft^2) 198; % [m^2]
    parameters.Swing = Swing_all-Swing_fus;
    parameters.SfuseCockpit = 1321.9997968; %%% (ft)   122.8178; %[m^2]
    parameters.SfuseCabin = 2*pi*parameters.Dfus/2*parameters.Lfus; %[m^2]
    parameters.SfuseTail = 2486.46; %% (ft)   231.1428; % [m^2]
    parameters.Sengine= 9504.5329; %% (ft^2 )   883 * 2; %[m^2]
    parameters.Scsurf = 2122.6431; %%% (ft^2) 197.2; %[m^2]
    
    parameters.AR = 9; %Aspect Ratio
    
    parameters.mCruise = 0.83; % [--]
    parameters.aCruise = 973.09711; %% (ft/s)   296.6; % [m/s]
    
    parameters.rho_EWR = 0.07847194457137; %% (lbs/ft^3)    1.25699997; %[kg/m^3] Air Density @ Newark
    parameters.rho_SIN = 0.07033118306662; %% (lbs/ft^3)    1.12659748; %[kg/m^3] Air Density @ Singapore
    parameters.rhoCruise =0.023700272874935; %% (lbs/ft^3)    0.379641953; %[kg/m^3] Air density @ 35,000 ft
    
    parameters.vCruise = parameters.mCruise*parameters.aCruise; %  (ft/s)  [m/s]
    parameters.vStall =   127.59186; %% (ft/s)     38.89; %[m/s] Stall speed
    
    parameters.qCruise = 3845; %% (lbs/ft^2) used online toolbox for imperial units    %% 0.5*parameters.rhoCruise*parameters.vCruise^2; % 
    
    %-------------------T_W.m---------------------
    parameters.G_1 = 0.005; %Climb Gradients
    parameters.G_2 = 0.024; %Climb Gradients
    parameters.G_3 = 0.012; %Climb Gradients
        
    parameters.CL_climb_1 = 2.7;
    parameters.CL_climb_2 = 2.3;
    parameters.CL_climb_3 = 1.9;
    
    parameters.Neng = 2;
    
    parameters.tb = 2015;
    
    parameters.eClimb =     0.8; %
    parameters.eCruise =    0.85; %
    
       
    parameters.S_EWR = 11000; %% (ft)  3352.8; % [m]
    parameters.S_SIN = 13123.36; %% (ft)4000; % [m]
        
    parameters.C = 0.53/3600; %[1/s] TSFC of GE90-110B1L
    parameters.C_loiter = 0.5;
    parameters.C_alt = 0.5;
    
    parameters.Cf = 0.0035; %Estimate from Raymer
    
    parameters.E_loiter = 0.5; %Time in loiter
    parameters.R_alt =    7.0860475162; %% (nmi)       370400; %[m] Alternate range
    parameters.V_alt =    246.063; %% (ft/s)       75; %[m/s] Alternate cruise velocity
	parameters.C_alt =           16; % 
	parameters.L_D_alt =         10;
    
    parameters.hBase =           10.668;
    parameters.hCruise =         10668;
    
    parameters.Nattd = 10;
    
    %COC
    
end
