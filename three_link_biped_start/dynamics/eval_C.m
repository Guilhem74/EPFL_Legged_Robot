function C = eval_C(q,dq)
%EVAL_C_TMP
%    C = EVAL_C_TMP(DQ1,DQ2,DQ3,L1,L2,L3,M1,M2,M3,Q1,Q2,Q3)

%    This function was generated by the Symbolic Math Toolbox version 8.2.
%    30-Oct-2018 13:40:39
q1=q(1);
q2=q(2);
q3=q(3);
dq1=dq(1);
dq2=dq(2);
dq3=dq(3);
[m1, m2, m3, l1, l2, l3, g] = set_parameters();

t2 = q1-q2;
t3 = sin(t2);
t4 = q1-q3;
t5 = sin(t4);
C = reshape([0.0,(dq1.*l1.*l2.*m2.*t3)./2.0,dq1.*l1.*l3.*m3.*t5.*(-1.0./2.0),dq2.*l1.*l2.*m2.*t3.*(-1.0./2.0),0.0,0.0,(dq3.*l1.*l3.*m3.*t5)./2.0,0.0,0.0],[3,3]);
end