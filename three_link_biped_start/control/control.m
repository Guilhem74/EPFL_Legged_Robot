function u = control(q, dq)
u = zeros(2, 1);
Kp=500;
Kd=280;
q1=q(1);
q2=q(2);
q3=q(3)
dq1=dq(1);
dq2=dq(2);
dq3=dq(3);
u1=Kp*(q3-pi/2)+Kd*dq3;
if(u1>30)
    u1=30;
elseif(u1<-30)
    u1=-30;
end;
u(1)=u1;
 

end