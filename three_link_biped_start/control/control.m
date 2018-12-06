function u = control(t, q, dq, q0, dq0, step_number)
u = zeros(2, 1);
Kp1=300;
Kd1=30;
q1=q(1);
q2=q(2);
q3=q(3)
dq1=dq(1);
dq2=dq(2);
dq3=dq(3);
M = eval_M(q);
C = eval_C(q, dq);
G = eval_G(q);
B = eval_B();

P = inv(M)*B;
Q = inv(M)*(C*dq - G);

%u1=1/P(3)*(-Kp1*(q3)-Kd1*dq3+Q(3))*3;

if step_number>1
    u1=Kp1*(q3-pi/6)+Kd1*dq3;
else
    u1=Kp1*(q3)+Kd1*dq3;
end;
if(u1>30)
    u1=30;
elseif(u1<-30)
    u1=-30;
end;
u(1)=u1;

 step_length=pi/8;
 Kp2=-500;
 Kd2=-5;
 x_atan=q1*10;
 u2=Kp2*(q2+atan((x_atan))/(pi/2)*step_length)+Kd2*(dq2+dq1*(1/(1+x_atan*x_atan))/(pi/2)*step_length);
if(u2>30)
    u2=30;
elseif(u2<-30)
    u2=-30;
end;
u(2)=u2;
end