close all;
clear all;
sln=solve_eqns([0;0; 0],[0;0;0],40);
animate(sln);
analyze(sln);

