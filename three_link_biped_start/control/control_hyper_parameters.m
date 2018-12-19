% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function [step_angle,Kp1,Kd1,Kp2,Kd2,tanh_c, Kp1_2,speed] = control_hyper_parameters()
    desired_speed=getGlobalx;%%Set your speed here
   
    step_angle = pi/22;
    Kp2=1000;
    Kd2=6;
    switch desired_speed
        case(0.7)
            speed=0.8;
            Kp1=6000;
            Kd1=250;
            tanh_c=45;
            Kp1_2=62;
        case (0.9)
            speed=1.03;
            Kp1=6000;
            Kd1=250;
            tanh_c=65;
            Kp1_2=83;
        case (1.1)
            speed=1.11;
            Kp1=6300;
            Kd1=250;
            tanh_c=65;
            Kp1_2=84;
        case (1.3)
            speed=1.29;
            Kp1=6800;
            Kd1=240;
            tanh_c=65;
            Kp1_2=78;
            step_angle = pi/23;
        case (1.5)
            speed=1.58;
            Kp1=6500;
            Kd1=230;
            tanh_c=75;
            Kp1_2=78;
            step_angle = pi/23;
        otherwise 
            speed=1.58;
            Kp1=6500;
            Kd1=230;
            tanh_c=75;
            Kp1_2=78;
            step_angle = pi/23;
    end
end
