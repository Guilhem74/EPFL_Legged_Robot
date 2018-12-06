close all;
clear all;
sln=solve_eqns([0;0; 0],[0.1;0;0],50);
animate(sln);
analyze(sln);