%%% Plotting COC contours on T-S Plot
% Updated 11/9/2015 Author: ---

set(0, 'DefaultAxesFontName','Times New Roman')
set(0, 'DefaultTextFontSize',11)

TW_Constraint;

S = [2000:100:12000];
T = linspace(0,2.5e05,length(S));

for i=1:length(S)
    for j=1:length(S)
[MTOW_new,Wfuel_new] = WeightEst(S(i),T(j));

Uannual = 1500*(3.4546*tb+2.994-sqrt(12.289*tb^2-5.6626*tb+8.964)); %% annual utilization 

%%%% Cost Escallation Factor (CEF)
%Crew fee, base year 1995 
%Navigation fee, base year 1989
%Airframe, aircraft, engine cost, base year 1989

%Airframe maintainance, base year 1989 
%Engine maintainance, base year 1995

%%% Cost of aircraft and engines and airframe
Caircraft = 10^(3.3191 + 0.8043 * log10(MTOW_new)) * CEF(1989, 2015);
Cengines = 10^(2.3044 + 0.8858 * log10(MTOW_new)) * CEF(1989, 2015);
Cairframe = Caircraft - Cengines;

%%% Airframe Maintenence costs
Cml_airframe = 1.03 * (3+0.067 * MTOW_new /1000)*R_L;
Cmm_airframe = 1.03 * (30 * CEF(1989, 2015)) +0.79 * 10^(-5) * Cairframe;

%%% Maintenence material cost per flight hour and per flight
materialCostPerFH = 3.3*(Cairframe/(10^6))+10.2+(58*(Cengines/(10^6))-19);
Cairframe_maintainance = materialCostPerFH * tb;

%%%% Engine Maintenance
Cml_engine = (0.645+(0.05*T0/(10^4)))*(0.566+0.434/tb)*MaintenanceLaborRate;
Cmm_engine = (25+(18*T0/(10^4)))*(0.62+0.38/tb)*(CEF(1995, 2015));

Cenginemaintenance = Neng*(Cml_engine + Cmm_engine)*tb;

%%%% cost of crew and attendants
Ccrew = AF * (K * MTOW_new^0.4 * tb) * CEF(1999, 2015);

Cattd = 60*Nattd*(CEF(1995, 2015))*(tb);


%%%% Cost of Fuel and Oil

Cfuel = 1.02*Wfuel_new*PricefuelPerGallon/DensityFuel;

%%% Airport Fees

Cairport = 1.5*((MTOW_new -Wfuel_new)/1000)*(CEF(1989, 2015));

%%% Navigation Fees

Cnavigation = 0.5*(CEF(1989, 2015))*(1.852*Range/tb)*sqrt(0.00045359237*MTOW_new/50);


 %%% Item costs
 Cost(i,j) = Cairframe_maintainance+Cenginemaintenance+Cairport+Cnavigation+Ccrew+Cattd+Cfuel;

    end
end

figure
contourf(S,T,Cost,30)
colorbar;
hold on
plot(S_sweep,Tclimb1,'r','linewidth',2)
plot(S_sweep,Tclimb2,'m','linewidth',2)
plot(S_sweep,Tclimb3,'k','linewidth',2)
plot(S_sweep,Tcruise,'c','linewidth',2)

plot(S_sweep,Ttakeoff,'g','linewidth',2)
plot([S_landing S_landing],[0 2.5e05],'y','linewidth',2)
plot(S_sweep,Tceiling,'w.','linewidth',2)

plot(S_sweep,Tmaneuver,'b','linewidth',2)
legend('COC','Climb 1','Climb 2','Climb 3','Cruise','Takeoff','Landing','Ceiling','Maneever');
xlabel('Wing Reference Area (ft^2)')
ylabel('Thrust (lbf])')
axis([3000 max(S) min(T) max(T)]);
hold off