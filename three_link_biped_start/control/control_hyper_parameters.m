% You can set any hyper parameters of the control function here; you may or
% may not want to use the step_number as the input of the function. 
function [kp_def,kd_def] = control_hyper_parameters()
kp=10:10:1000; 
kd=10:10:500;
contin=true;
for i=1:length(kd)
    if contin==false
        break;
    end
    for j=1:length(kp)
        [sln,boool]=solve_eqns([0;0; 0],[0.1;0;0],30,kp(j),kd(i));   
        y=sln.Y(end);
        y=table2array(y); 
        if boool==false
            kp_def=nan;
            kd_def=nan;
        else
            kp_def=kp(j);
            kd_def=kd(i);
            contin=false;
        end
        
    end
end

end
