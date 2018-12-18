% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function [speed_target, tanh_c, Kp1_2] = control_hyper_parameters()
    speed_target=1.1;
    if speed_target==0.7
        tanh_c=40;
        Kp1_2=60;
    elseif speed_target==1.5
        tanh_c=70;
        Kp1_2=75;
    elseif speed_target==1.3
        tanh_c=70;
        Kp1_2=75;
    end;
end
