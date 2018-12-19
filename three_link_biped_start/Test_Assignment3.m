close all;
clear all;
%% Please put in control hyper parameters the desired speed : We choosed a range 
%% (0.7, 0.9, 1.1 , 1.3 and 1.5)

sln=solve_eqns([0;0; 0],[0;0;0],200);
animate(sln);
analyze(sln);

