%%% Fuselage Sizing
% Updated 11/12/2015 Author: JRG

%125 PAX
seat = 125;
theta = 35;
c = 4;
r = seat/c;
l = 78; %length of seats

s_width = l*sind(theta);
n_aisle = 2;
a_width = 25;
t_wall = 4;
wall_clear = 8;


f_width = (c*s_width + n_aisle*a_width + 2*t_wall)*0.0254 
f_length  = r*78*cosd(theta)*0.0254
