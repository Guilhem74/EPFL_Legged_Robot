%%
% This function animates the solution of the equations of motion of the
% three link biped. 
% sln is the solution computed by solve_eqns.m
%%
function animate(sln)

[~, ~, ~, l1, l2, ~, ~] = set_parameters();

figure(100);
skip = 5; 

num_steps = length(sln.TE);% total number of steps the robot has taken (find this from sln)
r0 = [0; 0];
tic();
for j = 1:num_steps
    Y = (sln.Y{j});
    [N, ~] = size(Y);
    for i = 1:skip:N % what does skip do? --> It divides the refreshing rate by 5
        q = Y(i,1:3);
        pause(0.002);  % pause for 2 mili-seconds
        visualize(q,r0);
        
        hold off
    end
    %update r0
    [r_swf , z_swf, ~, dz_swf] = kin_swf(Y(i,1:3), Y(i,4:6));
    r0 = r0 + [r_swf;0 ];
    
end
t_anim = toc();

% Real time factor is the actual duration of the simulations (get it from sln) to
% the time it takes for MATLAB to animate the simulations (get it from
% t_anim). How does 'skip' effect this value? what does a real time factor
% of 1 mean?
real_time_factor = sum(cell2mat( sln.TE))/t_anim;
fprintf('Real time factor: ');
disp(real_time_factor);
end