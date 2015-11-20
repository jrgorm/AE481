%%%%% Optimizer: Weight Estimation Inner Loop 

MTOW = 700000;%%% inital MTOW guess
wNew = 1.1*MTOW; %%% initialize a dummy weight variable so loop will run
W0 = wNew;  %%% initialize the new output weight variable

T0 = 200000; %%% INPUT!!!! : total thrust : initial guess, will need to be updated with 2nd outer thrust loop

%%% Need to define these in parameters
wCrew = 14*180 + 30*14;
wPayload = 100*125;
wPassengers = 180*125+125*20;

Total = [ ]; % for troubleshooting table
Fuel = [ ]; % for troubleshooting table
Empty = [ ]; % for troubleshooting table

while abs(MTOW - W0) >= .1  
    
MTOW = wNew;
%%% function call to EmptyweightIII, need to define input to this function
%%% in a common parameters file somewhere (see EmptyweightIII for details
%%% on inputs/outputs to this function
[WeoverMTOW] = EmptyweightIII(T0,5000,2000,1200,MTOW,9,35,.2,.10,6000,1200,2000,800);

%%% Compute Fuel and Empty Weights
WfoverMTOW = .52; %%%% INPUT!!!!: fuel weight over MTOW (from john's code) : will need to be found from John's fuel code

Wfuel = WfoverMTOW * MTOW;  %%%% Note, WfoverMTOW will be found from a function call (above this line) of John's fuel weight code
Wempty = WeoverMTOW * MTOW; %%% WeoverMTOW was found in the function call of EmptyweightIII (above)

wNew = Wfuel + Wempty + wCrew + wPayload + wPassengers; %%% Sum all weights to get MTOW

Total = [Total;wNew]; % for troubleshooting table
Fuel = [Fuel;Wfuel]; % for troubleshooting table
Empty = [Empty;Wempty]; % for troubleshooting table

W0 = wNew;

end
% troubleshooting table
T = table(Total,Fuel,Empty,'VariableNames',{'Total' 'Fuel' 'Empty' })

%%%%% INNER LOOP OUTPUT:
MTOW = W0; %% outputs final MTOW after loop completes

