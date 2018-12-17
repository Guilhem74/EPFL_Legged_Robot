%%
% This function animates the solution of the equations of motion of the
% three link biped. 
% sln is the solution computed by solve_eqns.m
%%
function vitesse=animate(sln)

figure();
skip = 20;
tic();
vitesse=[];
num_steps = length(sln.T);
r0 = [0; 0];
for j = 1:num_steps
    Y = sln.Y{j};
    [N, ~] = size(Y);
    for i = 1:skip:N
        q = Y(i, 1:3);
        pause(0.002);
        visualize(q, r0, j);
        hold off
    end
    q = Y(end, 1:3);
    [x0, ~, ~, ~] = kin_swf(q);
    r0 = r0 + [x0; 0];
    if j>1
        x0/(sln.TE{j}-sln.TE{j-1})
        vitesse=[vitesse x0/(sln.TE{j}-sln.TE{j-1})];
    end;
    
end
t_anim = toc();
real_time_factor = sln.T{end}(end) / t_anim;
fprintf('Real time factor:');
disp(real_time_factor);
end