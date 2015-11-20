function [parameters] = loadParameters()
%UNTITLED4 Summary of this function goes here
%   Detailed explanation goes here
    parameters.W0 = 1; %WRONG
    parameters.Wcruise = 1; %WRONG  
    
    parameters.wCrew =1; %WRONG
    parameters.wPayload =1; %WRONG
    parameters.wPassengers =1; %WRONG
    
    parameters.Lfus = 1; %WRONG
    parameters.Dfus = 1; %WRONG
    parameters.Hfus = 1; %WRONG
    parameters.Sref = 511.79; %[m^2]
    parameters.cWing = 12.28; %[m]
    parameters.bWing = 66.42; %[m]
    parameters.sweep = 1; %WRONG
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
    
    parameters.AR = 1; %WRONG
    
    parameters.mCruise = 0.83; % [--]
    parameters.aCruise = 296.6; % [m/s]
    
    parameters.vCruise = parameters.mCruise*parameters.aCruise; % [m/s]
    
    parameters.qCruise = 0.5*paramaters.rhoCruise*parameters.vCruise^2; % 
    
    %-------------------T_W.m---------------------
    parameters.G_1 = 0.005; %Climb Gradients
    parameters.G_2 = 0.024; %Climb Gradients
    parameters.G_3 = 0.012; %Climb Gradients
        
    parameters.CL_climb_1 = 2.7;
    parameters.CL_climb_2 = 2.3;
    parameters.CL_climb_3 = 1.9;
    
    parameters.Neng = 2;
    
    parameters.eClimb =
    parameters.eCruise = 
    
    parameters.rho_EWR =
    parameters.rho_SIN =
    
    parameters.S_EWR =
    parameters.S_SIN =
    
    
    parameters.Cf = 0.0035; %Estimate from Raymer
    
    

end

