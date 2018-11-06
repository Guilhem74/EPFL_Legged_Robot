function A_m = eval_A_m(q_m)


[m1, m2, m3, l1, l2, l3, g] = set_parameters();
m=m1;
q1_m=q_m(1);
q2_m=q_m(2);
q3_m=q_m(3);

t2 = q1_m-q2_m;
t3 = cos(t2);
t4 = l1.^2;
t5 = (m.*t4)./4.0;
t6 = q1_m-q3_m;
t7 = cos(t6);
t8 = l3.^2;
A_m = reshape([t5-l1.*l2.*m.*t3-l1.*l2.*m3.*t3-(l1.*l3.*m3.*t7)./2.0,t5,l1.*l3.*m3.*t7.*(-1.0./2.0),(l2.^2.*m)./4.0,0.0,0.0,m3.*t8.*(-1.0./4.0)-(l2.*l3.*m3.*cos(q2_m-q3_m))./2.0,0.0,m3.*t8.*(-1.0./4.0)],[3,3]);
end