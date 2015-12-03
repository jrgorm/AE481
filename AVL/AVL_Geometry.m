clear all
close all
clc

[ Sref,b,MAC, Coord_W, Coord_HT, Coord_VT ] = AVL_Geometry( 5504,9,35,.2);

AVL_Write_Geometry( Sref,b,MAC, Coord_W, Coord_HT, Coord_VT, .00363, 33.3769);
fID = fopen('481AVL.m','w+');



Vcruise = 969.16; %%% ft/s;

% Load the AVL definition of the aircraft
fprintf(fID,'load 481AVL.avl.txt\n');

% Disable Graphics
fprintf(fID, 'plop\ng\n\n'); 

% Open the OPER menu
fprintf(fID, 'oper\n');

% Define the run case
fprintf(fID, 'm\n');
fprintf(fID, 'MN %0.4f\n', 0.83);
fprintf(fID, 'v %0.4f\n\n', Vcruise);

% Options for trimming
fprintf(fID, 'd1 pm 0\n');
% fprintf(fID, 'd2 pm 0\n');
% fprintf(fID, 'd3 ym 0\n');

alpha = -2;
fprintf(fID, 'a a %0.0f\r\n', alpha);
fprintf(fID, '%s\r\n', 'x');
fprintf(fID, '%s\r\n', 'w');
fprintf(fID, 'AVLresults.txt\r\n');

alpha = 5;
fprintf(fID, 'a a %0.0f\r\n', alpha);
fprintf(fID, '%s\r\n', 'x');
fprintf(fID, '%s\r\n', 'w');
fprintf(fID, '\r\n');

alpha = 12;
fprintf(fID, 'a a %0.0f\r\n', alpha);
fprintf(fID, '%s\r\n', 'x');
fprintf(fID, '%s\r\n', 'w');
fprintf(fID, '\r\n');

% alpha = (start_a + 2):2:12;
% for n = 1:length(alpha)
%     fprintf(fID, 'a a %0.0f\r\n', alpha(n));
%     fprintf(fID, 'x\n');
%     fprintf(fID, 'w\n');
%     fprintf(fID, '\r\n');
% end

%Quit Program
fprintf(fID, '\n');
fprintf(fID, '\n');
fprintf(fID, 'Quit\n');

fclose(fID);

[a,b] = system('avl < 481AVL.m')

%% Read files and output
[ Alpha_data, CL_data, CD_data ] = Read_AVL_Rusults('AVLresults.txt')

% Need to add wave drag to total drag result
% Need to fit curve to results
