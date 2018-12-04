close all;
clear all;
sln=solve_eqns([0;0; 0],[0.2;0;0],15);
animate(sln);
analyze(sln);