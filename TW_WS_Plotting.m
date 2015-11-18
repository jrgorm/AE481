%%% TW -WS Plotting Design Space (DP: 113,0.204)

set(0, 'DefaultAxesFontName','Times New Roman')
set(0, 'DefaultTextFontSize',11)

W_S = 1:1:1000;

parametersPDR;
dragpolarPDR;
climb;
cruise;
takeoff;
landing;
ceiling;
maneuver;

%Plotting Climb
figure
set(gcf,'name','Designed Aircraft Thrust Weight Ratio vs Wing Loading');

axis([ 0 200 0 0.5])
hold on

ylim([0 0.5]);

plot([0 200], [T_W_climb_minimum_1 T_W_climb_minimum_1],'r','LineWidth',2);
plot([0 200], [T_W_climb_minimum_2 T_W_climb_minimum_2],'m','LineWidth',2);
plot([0 200], [T_W_climb_minimum_3 T_W_climb_minimum_3],'k','LineWidth',2);

plot(W_S, T_W_cruise,'c-','LineWidth',2);
plot(W_S,T_W_takeoff,'g','LineWidth',2);
plot([W_S_land W_S_land],[0 0.5],'y','LineWidth',2);

x_ceiling = linspace(0,200);
y_ceiling = linspace(T_W_ceiling,T_W_ceiling);
plot(x_ceiling, y_ceiling,'k.','LineWidth',2);

plot(W_S,T_W_maneuver,'b','LineWidth',2);

legend('Climb 1','Climb 2','Climb 3','Cruise','Takeoff','land','ceiling','maneuver');
xlabel('Wing Loading W/S (lbf/ft^2)'); ylabel('Thrust Weight Ratio (T/W)');
