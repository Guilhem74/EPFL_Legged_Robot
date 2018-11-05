%    q_m = [pi/6 -pi/6 pi/10];
%    dq_m = [1 0.2 0];
%    [T_m, V_m] = eval_energy(q_m, dq_m)
%    [q_p, dq_p] = impact(q_m, dq_m);
%    [T_p, V_p] = eval_energy(q_p, dq_p)
 
%Plot
i=1;
range = 0:0.00001:pi/4
for a=range
    q_m = [a -a 0];
    dq_m = [1 0.2 0];
    [T_m, V_m] = eval_energy(q_m, dq_m)
    [q_p, dq_p] = impact(q_m, dq_m);
    [T_p, V_p] = eval_energy(q_p, dq_p)
    Perc_Lost(i)=(T_m-T_p)/T_m*100;
    
    i=i+1;
end
for z=1:i-2
    Deriv(z)=Perc_Lost(z+1)-Perc_Lost(z);
end
hold on;
plot(range,Perc_Lost,'r');
plot(0:0.01:pi/4-0.01,Deriv,'b');
min(Deriv)