% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function [speed_target, tanh_c, Kp1_2] = control_hyper_parameters()
    speed_target=1.50;
    tanh_c=100;%
    Kp1_2=75;
end
