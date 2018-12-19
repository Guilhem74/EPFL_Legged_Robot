%% Read the README_ASSIGN4.pdf to see what results you need to analyze here.
function sln = analyse(sln)
Y = sln.Y{1};
T = sln.T{1};
[N, ~] = size(Y);

speed_array=0;
dh_x_array=0;
u1_array=0;
u2_array=0;
displacement_array=0;
Step_Axis_Time_array=0;
time_sample_array=0;
time_step_array=0;
step_counter_array=0;
W1_array=0;
W2_array=0;
Energie_Array=0;
q1_array=0;
q2_array=0;
q3_array=0;
dq1_array=0;
dq2_array=0;
dq3_array=0;
%%To analyse a specific step
u1_specific_step=0;
u2_specific_step=0;
step_specific=41;%SETUP HERE
time_sample_specific_step=0;
%%

for i=1:size(sln.Y,2)
    %%Number of step
    Y =sln.Y{i};
    T =sln.T{i};
    
    q_begin = Y(1, 1:3);
    dq_begin = Y(1, 4:6);
    [x_h_begin, ~, ~, ~] = kin_hip(q_begin, dq_begin);
    q_end = Y(end, 1:3);
    dq_end = Y(end, 4:6);
    [x_h_end, ~, ~,~] = kin_hip(q_end, dq_end);
    
    x_move=x_h_end-x_h_begin;
    
    skip=1;
    [N, ~] = size(Y);
    W1=0;
    W2=0;
    for j = 1:skip:N
        %%Number of point
        q_j = Y(j, 1:3);
        dq_j = Y(j, 4:6);
        q1_array=[q1_array q_j(1)];
        q2_array=[q2_array q_j(2)];
        q3_array=[q3_array q_j(3)];
        dq1_array=[dq1_array dq_j(1)];
        dq2_array=[dq2_array dq_j(2)];
        dq3_array=[dq3_array dq_j(3)];
        [~, ~, dx_h,~] = kin_hip(q_j, dq_j);
        
        dh_x_array=[dh_x_array dx_h];%%Instantaneous speed
        time_sample_array=[time_sample_array T(j)];
        step_counter_array=[step_counter_array i-1];
        u = control(0, q_j', dq_j', 0, 0, 0);%Only q and dq are used in the control function
        if i==step_specific
            u1_specific_step=[u1_specific_step u(1)];
            u2_specific_step=[u2_specific_step u(2)];
            time_sample_specific_step=[time_sample_specific_step T(j)];
        end
        del_th1 = dq_j(1) - dq_j(3);
        del_th2 = dq_j(2) - dq_j(3);
        del_W1 = u(1)*del_th1; % virtual work done by u1
        del_W1= max(0,del_W1);
        del_W2 = u(2)*del_th2; % virtual work done by u2
        del_W2= max(0,del_W2);
        W1= W1+ del_W1;
        W2= W2+ del_W2; % total virtual work
        u1_array=[u1_array u(1)];
        u2_array=[u2_array u(2)];
    end
    time_step_array=[time_step_array T(j)];
    if i>1
        speed_array=[speed_array x_move/(sln.TE{i}-sln.TE{i-1})];
    else
        speed_array=[speed_array 0];
    end;
    displacement_array=[displacement_array x_move];
    Step_Axis_Time_array=[Step_Axis_Time_array i];
    W1_array=[W1_array W1];
    W2_array=[W2_array W2];
    if (W1+W2)/x_move>0
        Energie_Array=[Energie_Array (W1+W2)/x_move];
    else
        Energie_Array=[Energie_Array 0];
    end
    
end
%% plotting Speed
figure(3);
hold on;
yyaxis left
plot(time_sample_array,dh_x_array,time_step_array,speed_array,'b-*');
yyaxis right;
plot(time_sample_array,step_counter_array);
legend(' Instantaneous speed','Speed of the robot at every step','Step Counter');
title('Speed and intstantaneous speed');
%% Plotting u1 and u2 the two controller versus time
figure(4);
subplot(1,2,1)
hold on;
yyaxis left
plot(time_sample_array,u1_array);
for i=1:size(time_step_array,2)
    line([time_step_array(i) time_step_array(i)], [-30 30],'Color','red','LineStyle','--'); %Showing the steps
end;
axis([0 max(time_sample_array) -40 40 ]);
plot(time_sample_array,step_counter_array);
legend(' U1','Steps Vertical Line');
title('Torque of u1' );
subplot(1,2,2)
hold on;
yyaxis left
plot(time_sample_array,u2_array);
for i=1:size(time_step_array,2)
    line([time_step_array(i) time_step_array(i)], [-30 30],'Color','red','LineStyle','--'); %Showing the steps
end;

axis([0 max(time_sample_array) -40 40 ]);
plot(time_sample_array,step_counter_array);
legend(' U2','Steps Vertical Line');
title('Torque of u2');
%%�Plot torque at the specific step
figure(5);
subplot(1,2,1)
hold on;
plot( time_sample_specific_step,u1_specific_step);
legend(' U1');
title(['Torque of u1 at the specific step ',num2str(step_specific)]);
subplot(1,2,2)
hold on;
plot( time_sample_specific_step,u2_specific_step);
legend('U2');
title(['Torque of u2 at the specific step ' num2str(step_specific)]);
%%Plot Displacement at each step
figure(6);
subplot(1,2,1);
hold on;
plot( Step_Axis_Time_array,displacement_array);
legend(' Displacement for every step');
title(['Displacement of the hip at each step ']);
subplot(1,2,2);
hold on;
plot( time_step_array,displacement_array);
legend(' Displacement for every step against time');
title(['Displacement of the hip against time']);
%%Plot q and dq
figure(7);
subplot(1,3,1);
hold on;
plot( dq1_array,q1_array);
legend(' dq1 against q1');
title(['dq1 against q1 ']);
subplot(1,3,2);
hold on;
plot( dq2_array,q2_array);
legend(' dq2 against q2');
title(['dq2 against q2']);
subplot(1,3,3);
hold on;
plot( dq3_array,q3_array);
legend(' dq3 against q3');
title(['dq3 against q3']);
%% Plot Work W
figure(8);
subplot(1,2,1)
hold on;
plot( Step_Axis_Time_array,W1_array);
plot( Step_Axis_Time_array,W2_array);
plot( Step_Axis_Time_array,W1_array+W2_array);
legend('W1','W2','W3');
title(['Work at each step ']);
subplot(1,2,2)
hold on;
plot( time_step_array,W1_array);
plot( time_step_array,W2_array);
plot( time_step_array,W1_array+W2_array);
legend('W1','W2','W3');
title(['Work against time ']);
%% Plot Energie provided by the system at each step
figure(9);
hold on;
plot( Step_Axis_Time_array,Energie_Array);
legend('Energie consume by the robot at each step');
title(['Energie consume by the robot against step ']);

figure(10);
hold on;
plot( time_sample_array,q1_array);

end