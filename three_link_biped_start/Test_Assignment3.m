close all;
clear all;
sln=solve_eqns([0;0; 0],[0.1;0;0],160);
vitesse=animate(sln);
analyze(sln,vitesse);
u=getGlobalx ; 
