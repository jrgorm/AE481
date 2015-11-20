%%% OPTIMIZER:  Empty Weight III 

%%% INPUTS: Thrust, Maing Wing Ref Area, Htail Ref Area, Vtail Ref Area,
%%% Max Takeoff Weight, Aspect Ratio, Main wing sweep Angle, Main wing
%%% taper ratio, main wing max t/c at root chord, Exterior Wetted Area of
%%% fuselage center section, exterior wetted area of fuselage nose cone,
%%% exterior wetted area of fuselage tail cone

%%% OUTPUTS: The ratio of the Empty Weight calculated in this function over the Max
%%% Takeoff Weight that was inputted to this function

function [WeOverMTOW] = EmptyweightIII(parameters,thrustParameters,tailParameters)


T = thrustParameters.T0;
Sref = parameters.Sref;
Sht = tailParameters.Sht;
Svt = tailParameters.Svt;
MTOWinput = parameters.W0;
AR = parameters.AR;
sweepAngle = parameters.sweep;
taperRatio = parameters.taper;
tovercRoot = parameters.t_c;
SfuseCabin = parameters.SfuseCabin;
SfuseCockpit = parameters.SfuseTail;
Scsurf = parameters.Scsurf;


%  Calculate weight of engine based on Thrust Input
wEngdry = 0.521*(T)^0.9;
wEngoil = 0.082*(T)^0.65;
wEngrev = 0.034*T;
wEngctrl = 0.26*(T)^0.5;
wEngstrt = 9.33*(wEngdry/1000)^1.078;
%  Total weight of ALL engines
wEng = wEngdry+wEngoil+wEngrev+wEngctrl+wEngstrt; 

%  Weight of miscellaneous equipment 
wMisc = 0.17* MTOWinput;

%  Calcualte Fuselage and wing weights
wFuseCabin = 5*SfuseCabin;   %%% Center Fuselage Weight
wFuseCockpit = 5*SfuseCockpit; %%% Nose Cone Weight
wFuseTail = 5*SfuseTail; %%% Tail Cone Weight
wHtail = 5.5*Sht; %%% Horizontal Tail Weight
wVtail = 5.5*Svt; %%% Vertical Tail Weight

Nz = 1.5 ; %%% Load Factor
%  Wing weight based on load factor (Nz) , Main Wing Reference area (Sref)
%  , aspect ratio (AR) , (t/c) ratio at the root of the main wing, the
%  taper ratio of the main wing (lambda) , the sweep angle of the main wing
%  at the quarter chord point (sweepAngle) , and the total reference area of the
%  control surfaces on the wing (Scsurf)
wWing = 0.0051*(MTOWinput*Nz)^.557 * Sref^.649 * AR^.5 * (tovercRoot)^-.4 *(1+ taperRatio)^.1 * (cosd(sweepAngle))^-1 *Scsurf^.1; %%% Main Wing Weight
wGear = 0.043*MTOWinput; %Total weight of landing gear (taken as 4.3% of MTOW)

wFuselage = wFuseCabin+wFuseCockpit+wFuseTail; %Weight of fuselage not including landing gear, tail control surfaces, payload, crew, fuel

%Weight fractions (used to distribute miscellaneous weight among fuselage sections
wf_FuseCabin = wFuseCabin/wFuselage; 
wf_FuseCockpit = wFuseCockpit/wFuselage;
wf_FuseTail = wFuseTail/wFuselage;

%Adjust fuselage component weights with weighted distribution of extra weight
wFuseCabin=wFuseCabin+wf_FuseCabin*wMisc; 
wFuseCockpit=wFuseCockpit+wf_FuseCockpit*wMisc;
wFuseTail=wFuseTail+wf_FuseTail*wMisc;

%%%% Sum empty weight components together
Wemptynew = wEng + wFuseCabin + wFuseCockpit + wFuseTail + wHtail + wVtail + wWing + wGear ;

%%% Calculate ratio of Empty weight over Max Takeoff Weight for function output
WeOverMTOW = Wemptynew/MTOWinput;

%%% OPTIONAL TABLE TO TROUBLESHOOT EACH COMPONENT WEIGHT
% names = {'wEng';'wFuseCabin';'wFuseCockpit';'wFuseTail';'wHtail';'wVtail';'wWing';'wGear';'Wemptynew'};
% values = [wEng;wFuseCabin;wFuseCockpit;wFuseTail;wHtail;wVtail;wWing;wGear;Wemptynew];
% table(names,values)

end
