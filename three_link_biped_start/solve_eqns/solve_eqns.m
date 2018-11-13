%% Solve equations of motion 
% Note: eqns.m defines the equations of motion to be solved by this script
% This function returns the time vector T, the solution Y, the event time
% TE, solution at the event time YE.
% q0, dq0 are the initial angles and angular velocities, num_steps are the
% number of steps the robot is supposed to take
% As an example you can use q0 = [pi/6; -pi/3; 0] and dq0 = [0;0;0]. 

function sln = solve_eqns(q0, dq0, num_steps)

% options = ...
t0 = 0;
h = 0.001; % time step
tmax = 2; % max time that we allow for a single step
tspan = t0:h:tmax;% from 0 to tmax with time step h
y0 = [q0; dq0];

% we define the solution as a structure to simplify the post-analyses and
% animation, here we intialize it to null. 
sln.T = {};
sln.Y = {};
sln.TE = {};
sln.YE = {};

options = odeset('RelTol',1e-5,'events',@event_func);

for i = 1:num_steps
    [T, Y, TE, YE] = ode45(@eqns,tspan,y0,options);
    sln.T{i} = T;
    sln.Y{i} = Y;
    sln.TE{i} = TE;
    sln.YE{i} = YE;%Last Y, at the moment of the event
    if T(end) >= tmax
        break
    end
    
    % Impact map
    qm=[YE(1);YE(2);YE(3)];
    dqm =[YE(4);YE(5);YE(6)];
    [qp,dqp]=impact(qm,dqm);
    y0 = [qp;dqp];
    t0 = T(end);
 disp(2);   
end
end


