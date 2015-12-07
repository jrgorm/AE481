%%% V-n Diagram
% Updated 12/5/15 JRG
function [] = Vn(parameters)
close all;

g = 32.174; %[ft/s^2] Gravitational acceleration
CLmaxcruise = 1.7;
%CLmax = 2.6; % Landing configuration
CLalphapos = 1.7;
CLalphaneg = -1.2;
rhoSL = 0.0023768924; %[slugs/ft^3] Sea level air density
rhoCruise = 0.0007382; %[slugs/ft^3] Cruise altitude air density
sigma = rhoCruise/rhoSL;

W0 = parameters.W0;
W0 = W0*0.49;
Sref = parameters.Sref;
mCruise = parameters.mCruise;
aCruise = parameters.aCruise;
AR = parameters.AR;
sweep = parameters.sweep; %Half-chord sweep!
bWing = parameters.bWing;
cWing = Sref/bWing; %[ft] Mean geometric chord

kmhplot = 1; %Flag for plotting V-n in km/h

%% Equivalent airspeeds
Vcruise = 0.5924838012958963*aCruise*mCruise; %[knots] Cruise velocity TAS
Vcruise = Vcruise*sqrt(sigma); %[knots] Cruise EAS

%VS1 = sqrt((2/(rhoSL*CLmaxcruise))*(W0/Sref)); %[ft/s] Stall speed without flaps
%VS1 = VS1*sqrt(sigma); %[ft/s] Stall EAS
VS = sqrt((2*(W0/Sref))/(rhoSL*CLmaxcruise)); %[ft/s] Stall speed at n=1.0

VA = VS*sqrt(2.5); %[ft/s] [Martins]

beta = sqrt(1-mCruise^2); %Prandtl-Glauert factor
kappa = 0.97; %empirical correction factor [Kroo]
CLA = (2*pi*AR)/(2+sqrt(((beta/kappa)^2)*(AR^2)*(1+((tan(sweep)^2)/beta^2))+4));
mu = (2*(W0/Sref))/(rhoCruise*cWing*CLA*g);
Kg = (0.88*mu)/(5.3+mu);
UB = 52; %[ft/s] (From EqGust.m plot)
%VB = VS*sqrt(1+((Kg*UB*Vcruise*CLA)/(498*(W0/Sref)))); %[ft/s] [FAR 25.335(d)(1)]
%
UC = 37.5; %[ft/s] (From EqGust.m plot)
VC = (aCruise*mCruise*sqrt(sigma))+1.32*UC; %[ft/s] [FAR 25.335(a)(2)]
%
VMO = VC*1.06; %[ft/s]
VD = 1.07*VMO; %[ft/s] [Martins]

%% Maneuver envelope
VEAS = [0:600]; %[ft/s] Equivalent airspeed

%Calculate maneuver load factor
for i=1:length(VEAS)
    npos(i) = (rhoSL*CLalphapos*VEAS(i)^2)/(2*(W0/Sref)); %Positive load factors [Martins]
    nneg(i) = (rhoSL*CLalphaneg*VEAS(i)^2)/(2*(W0/Sref)); %Positive load factors [Martins]
end

%Find intersection of negative maneuver load factor with negative load factor limit
for i=1:length(VEAS)
    if nneg(i) > -1
        count(i) = 1;
    else count(i) = 0;
    end
end
countprod = [1:length(VEAS)];
count = countprod.*count;
[maxVal maxInd] = max(count);

%Plot maneuver load factors
figure
plot(VEAS,npos)
hold on
plot(VEAS,nneg)

%% Gust envelope
UD = 18.75; %[ft/s] (From EqGust.m plot)

%Calculate gust load factor
for i=1:length(VEAS)
    nVB_gustpos(i) = 1+((Kg*UB*0.5924838012958963*VEAS(i)*CLA)/(498*(W0/Sref)));
    nVB_gustneg(i) = 1-((Kg*UB*0.5924838012958963*VEAS(i)*CLA)/(498*(W0/Sref)));
    nVC_gustpos(i) = 1+((Kg*UC*0.5924838012958963*VEAS(i)*CLA)/(498*(W0/Sref)));
    nVC_gustneg(i) = 1-((Kg*UC*0.5924838012958963*VEAS(i)*CLA)/(498*(W0/Sref)));
    nVD_gustpos(i) = 1+((Kg*UD*0.5924838012958963*VEAS(i)*CLA)/(498*(W0/Sref)));
    nVD_gustneg(i) = 1-((Kg*UD*0.5924838012958963*VEAS(i)*CLA)/(498*(W0/Sref)));
end

%Calculate VB (intersection of positive maneuver and positive VB gust load factors)
%Find intersection of positive maneuver and negative VB gust load factors
%Find intersection of positive maneuver and positive maneuver load factor limit
for i=1:length(VEAS)
    error1(i) = abs(npos(i)-nVB_gustpos(i));
    error2(i) = abs(npos(i)-nVB_gustneg(i));
    error3(i) = abs(npos(i)-2.5);
end
[minVal minInd] = min(error1);
VB = VEAS(minInd); %[ft/s]
[crossVal crossInd] = min(error2);
[limVal limInd] = min(error3);

%Plot gust lines over maneuver load factors
plot(VEAS,nVB_gustpos,'--')
plot(VEAS,nVB_gustneg,'--')
plot(VEAS,nVC_gustpos,'--')
plot(VEAS,nVC_gustneg,'--')
plot(VEAS,nVD_gustpos,'--')
plot(VEAS,nVD_gustneg,'--')

%% Plots
%Plot gust lines with boundaries
figure
% Gust lines
plot(VEAS(1:minInd),nVB_gustpos(1:minInd),'--')
hold on
plot(VEAS(1:minInd),nVB_gustneg(1:minInd),'--')
plot(VEAS(1:round(VC,0)),nVC_gustpos(1:round(VC,0)),'--')
plot(VEAS(1:round(VC,0)),nVC_gustneg(1:round(VC,0)),'--')
plot(VEAS(1:round(VD,0)),nVD_gustpos(1:round(VD,0)),'--')
plot(VEAS(1:round(VD,0)),nVD_gustneg(1:round(VD,0)),'--')
% Gust line boundaries
plot([VEAS(minInd) VC],[nVB_gustpos(round(VB,0)) nVC_gustpos(round(VC,0))])
plot([VC VD],[nVC_gustpos(round(VC,0)) nVD_gustpos(round(VD,0))])
plot([VEAS(minInd) VC],[nVB_gustneg(round(VB,0)) nVC_gustneg(round(VC,0))])
plot([VC VD],[nVC_gustneg(round(VC,0)) nVD_gustneg(round(VD,0))])

%Plot combined maneuver and gust load factors with boundaries
figure
% Manuever load factors
plot(VEAS(1:minInd),npos(1:minInd))
hold on
plot(VEAS(1:maxInd),nneg(1:maxInd))
% Maneuver envelope
plot([VS VS],[10 -10],'--') %VS line
plot([VA VA],[10 -10],'--') %VA line
plot([VB VB],[10 -10],'--') %VB line
plot([VC VC],[10 -10],'--') %VC line
plot([VD VD],[nVD_gustpos(round(VD,0)) nVD_gustneg(round(VD,0))]) %VD line
plot([VEAS(limInd) VD],[2.5 2.5],'k') %Positive load factor boundary
plot([VEAS(maxInd) VC],[-1,-1]) %Negative load factor boundary
plot([VC VD],[-1 0])
% Gust lines
plot(VEAS(1:minInd),nVB_gustpos(1:minInd),'--')
plot(VEAS(1:minInd),nVB_gustneg(1:minInd),'--')
plot(VEAS(1:round(VC,0)),nVC_gustpos(1:round(VC,0)),'--')
plot(VEAS(1:round(VC,0)),nVC_gustneg(1:round(VC,0)),'--')
plot(VEAS(1:round(VD,0)),nVD_gustpos(1:round(VD,0)),'--')
plot(VEAS(1:round(VD,0)),nVD_gustneg(1:round(VD,0)),'--')
% Gust line boundaries
plot([VEAS(minInd) VC],[nVB_gustpos(round(VB,0)) nVC_gustpos(round(VC,0))])
plot([VC VD],[nVC_gustpos(round(VC,0)) nVD_gustpos(round(VD,0))])
plot([VEAS(minInd) VC],[nVB_gustneg(round(VB,0)) nVC_gustneg(round(VC,0))])
plot([VC VD],[nVC_gustneg(round(VC,0)) nVD_gustneg(round(VD,0))])

%Plot finished V-n diagram
figure
% Maneuver load factors
plot(VEAS(crossInd:minInd),npos(crossInd:minInd),'k')
hold on
% Maneuver envelope
plot([VD VD],[nVD_gustpos(round(VD,0)) nVD_gustneg(round(VD,0))],'k') %VD line
plot([VEAS(limInd) VD],[2.5 2.5],'k') %Positive load factor boundary
% Gust lines
plot(VEAS(1:minInd),nVB_gustpos(1:minInd),'k--')
plot(VEAS(1:crossInd),nVB_gustneg(1:crossInd),'k--')
plot(VEAS(1:round(VC,0)),nVC_gustpos(1:round(VC,0)),'k--')
plot(VEAS(1:round(VC,0)),nVC_gustneg(1:round(VC,0)),'k--')
plot(VEAS(1:round(VD,0)),nVD_gustpos(1:round(VD,0)),'k--')
plot(VEAS(1:round(VD,0)),nVD_gustneg(1:round(VD,0)),'k--')
plot(VEAS(crossInd:minInd),nVB_gustneg(crossInd:minInd),'k')
% Gust line boundaries
plot([VEAS(minInd) VC],[nVB_gustpos(round(VB,0)) nVC_gustpos(round(VC,0))],'k')
plot([VC VD],[nVC_gustpos(round(VC,0)) nVD_gustpos(round(VD,0))],'k')
plot([VEAS(minInd) VC],[nVB_gustneg(round(VB,0)) nVC_gustneg(round(VC,0))],'k')
plot([VC VD],[nVC_gustneg(round(VC,0)) nVD_gustneg(round(VD,0))],'k')
% Fix x-axis to display in knots
set(gca,'XLim',[0 VD+25])
set(gca,'XTick',[0:50:VD+25])
numbers = round(0.5924838012958963.*[0:50:VD+25],-1);
set(gca,'XTickLabel',numbers)
%
xlabel('Equivalent Air Speed (knots)')
ylabel('Load Factor')

if kmhplot==1
    figure
    % Maneuver load factors
    plot(VEAS(crossInd:minInd),npos(crossInd:minInd),'k')
    hold on
    % Maneuver envelope
    plot([VD VD],[nVD_gustpos(round(VD,0)) nVD_gustneg(round(VD,0))],'k') %VD line
    plot([VEAS(limInd) VD],[2.5 2.5],'k') %Positive load factor boundary
    % Gust lines
    plot(VEAS(1:minInd),nVB_gustpos(1:minInd),'k--')
    plot(VEAS(1:crossInd),nVB_gustneg(1:crossInd),'k--')
    plot(VEAS(1:round(VC,0)),nVC_gustpos(1:round(VC,0)),'k--')
    plot(VEAS(1:round(VC,0)),nVC_gustneg(1:round(VC,0)),'k--')
    plot(VEAS(1:round(VD,0)),nVD_gustpos(1:round(VD,0)),'k--')
    plot(VEAS(1:round(VD,0)),nVD_gustneg(1:round(VD,0)),'k--')
    plot(VEAS(crossInd:minInd),nVB_gustneg(crossInd:minInd),'k')
    % Gust line boundaries
    plot([VEAS(minInd) VC],[nVB_gustpos(round(VB,0)) nVC_gustpos(round(VC,0))],'k')
    plot([VC VD],[nVC_gustpos(round(VC,0)) nVD_gustpos(round(VD,0))],'k')
    plot([VEAS(minInd) VC],[nVB_gustneg(round(VB,0)) nVC_gustneg(round(VC,0))],'k')
    plot([VC VD],[nVC_gustneg(round(VC,0)) nVD_gustneg(round(VD,0))],'k')
    % Fix x-axis to display in knots
    set(gca,'XLim',[0 VD+25])
    set(gca,'XTick',[0:50:VD+25])
    numbers = round(1.09728.*[0:50:VD+25],-1);
    set(gca,'XTickLabel',numbers)
    %
    xlabel('Equivalent Air Speed (km/h)')
    ylabel('Load Factor')
end

end
