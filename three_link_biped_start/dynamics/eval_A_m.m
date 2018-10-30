function A_m = eval_A_m(q_m)


[m1, m2, m3, l1, l2, l3, g] = set_parameters();
m=m1;
q1_m=q_m(1);
q2_m=q_m(2);
q3_m=q_m(3);

t2 = l1.^2;
t3 = q1_m-q3_m;
t4 = cos(t3);
t5 = l3.^2;
A_m = reshape([m.*(-t2+l1.*l2.*cos(q1_m-q2_m).*8.0+l1.*l3.*t4.*2.0).*(-1.0./4.0),(m.*t2)./4.0,l1.*l3.*m.*t4.*(-1.0./2.0),(l2.^2.*m)./4.0,0.0,0.0,m.*(t5+l2.*l3.*cos(q2_m-q3_m).*2.0).*(-1.0./4.0),0.0,m.*t5.*(-1.0./4.0)],[3,3]);
end