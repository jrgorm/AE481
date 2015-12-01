%%% Equivalent Gust Velocities
% Updated 11/30/15 JRG

close all;

UB = 66; %[ft/s] Rough air gust
UC = 50; %[ft/s] Gust @ maximum design speed
UD = 25; %[ft/s] Gust @ maximum dive speed

% Slopes
m_UB = (20-50)/(UB-38); %[1000*ft/ft/s] slope for VB, equivalent gust velocity
m_UC = (20-50)/(UC-25); %[1000*ft/ft/s] slope for VC, equivalent gust velocity
m_UD = (20-50)/(UD-12.5); %[1000*ft/ft/s] slope for VD, equivalent gust velocity

% y-intercepts
b_UB = 20-m_UB*UB; %[1000*ft]
b_UC = 20-m_UC*UC; %[1000*ft]
b_UD = 20-m_UD*UD; %[1000*ft]

% Equivalent gust velocities
gustUB = [38:66,66]; %[ft/s] truncated range
gustUC = [25:50,50]; %[ft/s] truncated range
gustUD = [12.5,13:25,25]; %[ft/s] truncated range

% Calculate altitude-gust velocity lines
alt_VB = m_UB.*gustUB+b_UB;
alt_VB(end) = 0;
alt_VC = m_UC.*gustUC+b_UC;
alt_VC(end) = 0;
alt_VD = m_UD.*gustUD+b_UD;
alt_VD(end) = 0;

% Plots
figure
plot(gustUB,alt_VB)
hold on
plot(gustUC,alt_VC)
plot(gustUD,alt_VD)
xlabel('Equivalent Gust Velocity (ft/s)')
ylabel('Altitude (1000 ft)')
legend('Rough Air Speed, VB','Cruise Speed, VC','Dive Speed, VD')
