%% Read the README_ASSIGN4.pdf to see what results you need to analyze here. 
function sln = analyse(sln)
    Y = sln.Y{1};
    T = sln.T{1};
    [N, ~] = size(Y);
    t=T(:,1);
      q = Y(:, 1:3);
      q1=q(:,1);
    q2=q(:,2);
    q3=q(:,3);
    dq = Y(:, 4:6);
    dq1=q(:,1);
    dq2=q(:,2);
    dq3=q(:,3);
    
    %figure(2);
    %hold on
    %plot(t,q1)
    % figure(3);
    % plot((q1*1000)/(pi/2)*pi/4,'b')
    %%figure()
    %%plot(q1) 
    %%hold on 
    %%plot(q2)
    %%hold on 
    %%Plotting the different speed vs time
    speed_plot=0;
    dh_x_plot=0;
    u1_plot=0;
    u2_plot=0;
    displacement_plot=0;
    Step_Axis_Time=0;
    time_sample=0;
    time_step=0;
    step_counter=0;
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
        for j = 1:skip:N
            q_j = Y(j, 1:3);
            dq_j = Y(j, 4:6);
            [~, ~, dx_h,~] = kin_hip(q_j, dq_j);
                
                dh_x_plot=[dh_x_plot dx_h];%%Instantaneous speed
                time_sample=[time_sample T(j)];
                step_counter=[step_counter i-1];
                u = control(0, q_j', dq_j', 0, 0, j);%Only q and dq are used in the control function
                if i==step_specific
                    
                    u1_specific_step=[u1_specific_step u(1)];
                    u2_specific_step=[u2_specific_step u(2)];
                    time_sample_specific_step=[time_sample_specific_step T(j)];
                end
                u1_plot=[u1_plot u(1)];
                u2_plot=[u2_plot u(2)];
        end
        time_step=[time_step T(j)];
        if i>1
                speed_plot=[speed_plot x_move/(sln.TE{i}-sln.TE{i-1})];
        else
                speed_plot=[speed_plot 0];
        end;
        displacement_plot=[displacement_plot x_move];
        Step_Axis_Time=[Step_Axis_Time i];
        
    end
        figure(3);
        hold on;
        yyaxis left
        plot(time_sample,dh_x_plot,time_step,speed_plot,'b-*');
        yyaxis right;
        plot(time_sample,step_counter);
        legend(' Instantaneous speed','Speed of the robot at every step','Step Counter'); 
        title('Speed and intstantaneous speed');
 %% Plotting u1 and u2 the two controller versus time
        figure(4);
        subplot(1,2,1)
        hold on;
        yyaxis left
        plot(time_sample,u1_plot);
        for i=1:size(time_step,2)
            line([time_step(i) time_step(i)], [-30 30],'Color','red','LineStyle','--'); %Showing the steps
        end;
        axis([0 max(time_sample) -40 40 ]);
        yyaxis right;
        plot(time_sample,step_counter);
        legend(' U1','Step Counter'); 
        title('Torque of u1' );
        subplot(1,2,2)
        hold on;
        yyaxis left
        plot(time_sample,u2_plot);
        for i=1:size(time_step,2)
            line([time_step(i) time_step(i)], [-30 30],'Color','red','LineStyle','--'); %Showing the steps
        end;
        
        axis([0 max(time_sample) -40 40 ]);
        yyaxis right;
        plot(time_sample,step_counter);
        legend(' U2','Step Counter'); 
        title('Torque of u2');
 %%¨Plot torque at the specific step
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
        plot( Step_Axis_Time,displacement_plot);
        legend(' Displacement for every step'); 
        title(['Displacement of the hip at each step ']);
        subplot(1,2,2);
        hold on;
        plot( time_step,displacement_plot);
        legend(' Displacement for every step over time'); 
        title(['Displacement of the hip over time']);
     
end