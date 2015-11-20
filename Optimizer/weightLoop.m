function [ W0 ] = weightLoop( parameters, thrustParameters,tailParameters)
%UNTITLED11 Summary of this function goes here
%   Detailed explanation goes here
%%%%% Optimizer: Weight Estimation Inner Loop 

MTOW = parameters.W0;%%% inital MTOW guess
wNew = 1.1*MTOW; %%% initialize a dummy weight variable so loop will run
W0 = wNew;  %%% initialize the new output weight variable

% T0 = thrustParameters.T0; %%% INPUT!!!! : total thrust : initial guess, will need to be updated with 2nd outer thrust loop

%%% Need to define these in parameters
wCrew = parameters.wCrew;
wPayload = parameters.wPayload;
wPassengers = parameters.wPassengers;

% Total = [ ]; % for troubleshooting table
% Fuel = [ ]; % for troubleshooting table
% Empty = [ ]; % for troubleshooting table

while abs(MTOW - W0) >= .1  
    
MTOW = wNew;
%%% function call to EmptyweightIII, need to define input to this function
%%% in a common parameters file somewhere (see EmptyweightIII for details
%%% on inputs/outputs to this function
[WeoverMTOW] = EmptyweightIII(parameters,tailParameters,thrustParameters);

%%% Compute Fuel and Empty Weights

%RUN FUEL WEIGHT CODExxxxxxxxxxxxxxxxxxxxxxxxxx
%xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx
WfoverMTOW = .52; %%%% INPUT!!!!: fuel weight over MTOW (from john's code) : will need to be found from John's fuel code

Wfuel = WfoverMTOW * MTOW;  %%%% Note, WfoverMTOW will be found from a function call (above this line) of John's fuel weight code
Wempty = WeoverMTOW * MTOW; %%% WeoverMTOW was found in the function call of EmptyweightIII (above)

wNew = Wfuel + Wempty + wCrew + wPayload + wPassengers; %%% Sum all weights to get MTOW

% Total = [Total;wNew]; % for troubleshooting table
% Fuel = [Fuel;Wfuel]; % for troubleshooting table
% Empty = [Empty;Wempty]; % for troubleshooting table

W0 = wNew;

end
% troubleshooting table
%T = table(Total,Fuel,Empty,'VariableNames',{'Total' 'Fuel' 'Empty' })


end

