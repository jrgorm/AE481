%%% Refined Weight Estimation
% Updated 11/9/2015 Author: ---

function [W0,Wf] = WeightEst(S,T)

parameters;

wFOverWTO = 0.4999; %Constant from initial weight estimation

SfuseCabin = 8409; %ft^2
SfuseCockpit = 1100; %ft^2
SfuseTail = 2406; %ft^2
Shtail = 1122; %ft^2
Svtail = 616; %ft^2

wEst = MTOW;
wNew = 1.5*MTOW;
W0 = wNew;

while abs(wEst-W0)>=0.1
wEst = wNew;
wEngdry = 0.521*(T)^0.9;
wEngoil = 0.082*(T)^0.65;
wEngrev = 0.034*T;
wEngctrl = 0.26*(T)^0.5;
wEngstrt = 9.33*(wEngdry/1000)^1.078;
wEng = wEngdry+wEngoil+wEngrev+wEngctrl+wEngstrt; %Total weight of ALL engines

wMisc = 0.17*wEst; %Weight of miscellaneous equipment 

wFuseCabin = 5*SfuseCabin;
wFuseCockpit = 5*SfuseCockpit;
wFuseTail = 5*SfuseTail;
wHtail = 5.5*Shtail;
wVtail = 5.5*Svtail;
wWing = 10*S;
wGear = 0.043*wEst; %Total weight of landing gear

wFuselage = wFuseCabin+wFuseCockpit+wFuseTail; %Weight of fuselage not including landing gear, tail control surfaces, payload, crew, fuel
wf_FuseCabin = wFuseCabin/wFuselage; %Weight fractions
wf_FuseCockpit = wFuseCockpit/wFuselage;
wf_FuseTail = wFuseTail/wFuselage;
wFuseCabin=wFuseCabin+wf_FuseCabin*wMisc; %Adjust fuselage component weights with weighted distribution of extra weight
wFuseCockpit=wFuseCockpit+wf_FuseCockpit*wMisc;
wFuseTail=wFuseTail+wf_FuseTail*wMisc;

wNew =(wCrew+wPayload+wEng+wFuseCabin+wFuseCockpit+wFuseTail+wHtail+wVtail+wWing+wGear)/(1-wFOverWTO); %Calculate MTOW
W0 = wNew;
Wf = wFOverWTO*W0;

end
end