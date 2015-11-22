% Calculate COC
% Input: T, W0, Wf

set(0, 'DefaultAxesFontName','Times New Roman')
set(0, 'DefaultTextFontSize',11)

%% import functions and paramters
% basic parameters

% get MTOW, Wf, T0
MTOW = parameters.W0;
Wf = parameters.Wfuel;
T0 = parameters.T0; %Do we need for COC directly? Looks like you need it for MTOW calc only :: YES, see Engine maintenance costs.

tb = parameters.tb;
R_L = 30;
MaintenanceLaborRate = 73;
InsuranceRate = 0.02;
Nattd = parameters.Nattd;
PricefuelPerGallon = 6.00 ; %%% price fuel per gallon (US dollars)
DensityFuel = 7.14; %%% fuel density (JET-A) (pounds per gallon)


AF = 1.0; %Airline Factor
K = 7.5; %Route Factor

Neng = parameters.Neng;

%% COC calculation

% Annual utilization
Uannual = 1500*(3.4546*tb+2.994-sqrt(12.289*tb^2-5.6626*tb+8.964)); 

%%% Cost Escallation Factor (CEF)
%Crew fee, base year 1995 
%Navigation fee, base year 1989
%Airframe, aircraft, engine cost, base year 1989

%Airframe maintainance, base year 1989 
%Engine maintainance, base year 1995

%%% Cost of aircraft and engines and airframe
Caircraft = 10^(3.3191 + 0.8043 * log10(MTOW)) * CEF(1989, 2015);
Cengines = 10^(2.3044 + 0.8858 * log10(MTOW)) * CEF(1989, 2015);
Cairframe = Caircraft - Cengines;

%%% Airframe Maintenence costs
Cml_airframe = 1.03 * (3+0.067 * MTOW /1000)*R_L;
Cmm_airframe = 1.03 * (30 * CEF(1989, 2015)) +0.79 * 10^(-5) * Cairframe;

%%% Maintenence material cost per flight hour and per flight
materialCostPerFH = 3.3*(Cairframe/(10^6))+10.2+(58*(Cengines/(10^6))-19);
Cairframe_maintainance = materialCostPerFH * tb;

%%% Engine Maintenance
Cml_engine = (0.645+(0.05*T0/(10^4)))*(0.566+0.434/tb)*MaintenanceLaborRate;
Cmm_engine = (25+(18*T0/(10^4)))*(0.62+0.38/tb)*(CEF(1995, 2015));

Cenginemaintenance = Neng*(Cml_engine + Cmm_engine)*tb;

%%% cost of crew and attendants

Ccrew = AF * (K * MTOW^0.4 * tb) * CEF(1999, 2015);

Cattd = 60*Nattd*(CEF(1995, 2015))*(tb);

%%% Cost of Fuel and Oil

Cfuel = 1.02*Wf*PricefuelPerGallon/DensityFuel;

%%% Airport Fees

Cairport = 1.5*((MTOW -Wf)/1000)*(CEF(1989, 2015));

%%% Navigation Fees

Cnavigation = 0.5*(CEF(1989, 2015))*(1.852*parameters.Range/tb)*sqrt(0.00045359237*MTOW/50);

%%% Item costs

Cost = Cairframe_maintainance+Cenginemaintenance+Cairport+Cnavigation+Ccrew+Cattd+Cfuel;
