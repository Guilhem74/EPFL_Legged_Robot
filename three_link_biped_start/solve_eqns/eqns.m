function dy = eqns(t, y)
% n this is the dimension of the ODE, note that n is 2*DOF, why? 
% y1 = q1, y2 = q2, y3 = q3, y4 = dq1, y5 = dq2, y6 = dq3
%set_path();

u = control(y(1:3), y(4:6)); % for the moment we set the control outputs to zero

DOF = 3;
n = 2*DOF;   
dy = zeros(n, 1);

M = eval_M(y(1:3));
C = eval_C(y(1:3),y(4:6));
G = eval_G(y(1:3));
B = eval_B;

dy(1:3) = y(4:6);
dy(4:6) = M\(B*u - C*y(4:6) - G);

% write down the equations for dy:

end