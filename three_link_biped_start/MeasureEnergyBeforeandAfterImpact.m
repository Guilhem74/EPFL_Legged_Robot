q_m = [pi/6 -pi/6 pi/10];
dq_m = [1 0.2 0];
[T_m, V_m] = eval_energy(q_m, dq_m)
[q_p, dq_p] = impact(q_m, dq_m);
[T_p, V_p] = eval_energy(q_p, dq_p)