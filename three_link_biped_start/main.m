close all;
clear all;

global desired_speed;
% Please put here the desired speed : We choosed a range 
% (0.7, 0.9, 1.1 , 1.3 and 1.5)
% If not one of the above value the speed is 1.5 by default.
% Perturbation is at the step 150 to be sure that the robot is in steady
% state
desired_speed = 0.7; 
setGlobalx(desired_speed);

sln=solve_eqns([0;0;0],[0;0;0],200);
animate(sln);
analyze(sln);

