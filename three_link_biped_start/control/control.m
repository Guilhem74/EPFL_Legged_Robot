function u = control(t, q, dq, q0, dq0, step_number)
%WARNING : Only q and dq are set in the analyse file, if you must use that
%function please change the call in the analyze.m file
u = zeros(2, 1);

[step_angle,Kp1,Kd1,Kp2,Kd2,tanh_c, Kp1_2,speed] = control_hyper_parameters();

q1=q(1);
q2=q(2);
q3=q(3);
dq1=dq(1);
dq2=dq(2);
dq3=dq(3);

M = eval_M(q);
C = eval_C(q, dq);
G = eval_G(q);
B = eval_B();
P = M\B;
Q = M\(C*dq - G);

[~, ~, dq_h, ~] = kin_hip(q,dq);

%u1_1 = Kp1*(q3 - head_angle*(q2+step_angle)/(2*step_angle)) + Kd1*(dq3-head_angle*dq2/(2*step_angle));
%u1_1 = Kp1*(q3) + Kd1*dq3;
%u1_1 = 1/(P(3)-P(1))*(-Kp1*(q3) - Kd1*(dq3-dq1) + (Q(3)-Q(1)));

u1_1 = 1/(P(3)-P(1))*(-Kp1*(q3-q1) - Kd1*(dq3-dq1) + (Q(3)-Q(1)));
u1_2 = Kp1_2*(dq_h-speed);
%u1_3 = Kp1_3*exp(-q2*1e1)/exp(step_angle*1e1);

u1 = u1_1 + u1_2;

if(u1>30)
    u1 = 30;
elseif(u1<-30)
    u1 = -30;
end
u(1) = u1;

u2_1 = -Kp2*(q2+step_angle*tanh(tanh_c*q1)) - Kd2*(dq2+tanh_c*dq1*step_angle*(1-tanh(tanh_c*q1)^2));
u2 = u2_1;

if(u2>30)
    u2 = 30;
elseif(u2<-30)
    u2 = -30;
end
u(2) = u2;

end