clear all;
close all;
clc;

parameters = loadParameters();

T0 =50;

while(abs(parameters.T0-T0)>0.1)
T0 = parameters.T0;
tailParameters = loadInitialParameters();

%-------------------T0 Iteration-----------------
tailParameters = tailSizing(parameters,tailParameters);

dragP = dragPolar(parameters,tailParameters);

parameters = fuelWeight(parameters,dragP);

tailParameters = tailSizing(parameters,tailParameters);

parameters.W0 = weightLoop(parameters,tailParameters);

parameters = T_W(parameters,dragP);

COC
Cost

end
