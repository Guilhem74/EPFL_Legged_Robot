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
    figure()
    plot(q1) 
    hold on 
    plot(q2)
    hold on 
    vitesse_plot=0;
    dh_x_plot=0;
    sample_indice=0;
    time_sample=0;
    time_step=0;
    step_counter=0;
        figure(3)
    for i=1:size(sln.Y,2)
        %%Number of step
        Y =sln.Y{i};
        T =sln.T{i};
        q_begin = Y(1, 1:3);
        dq_begin = Y(1, 4:6);
        [x_h_begin, ~, ~, ~] = kin_hip(q_begin, dq_begin);
        q_end = Y(end, 1:3);
        dq_end = Y(end, 4:6);
        [x0, ~, ~, ~] = kin_swf(q_end);
        [x_h_end, ~, ~,~] = kin_hip(q_end, dq_end);
        x_move=x_h_end-x_h_begin;
        skip=1;
        [N, ~] = size(Y);
        for j = 1:skip:N
            q_j = Y(j, 1:3);
            dq_j = Y(j, 4:6);
            [~, ~, dx_h,~] = kin_hip(q_j, dq_j);
                
                dh_x_plot=[dh_x_plot dx_h];
                sample_indice=[sample_indice i];
                time_sample=[time_sample T(j)];
                step_counter=[step_counter i-1];

            
        end
        time_step=[time_step T(j)]
        if i>1
                vitesse_plot=[vitesse_plot x_move/(sln.TE{i}-sln.TE{i-1})];
        else
                vitesse_plot=[vitesse_plot 0];
        end;
    end

        hold on;
        yyaxis left
        plot(time_sample,dh_x_plot,time_step,vitesse_plot,'b-*');

        yyaxis right;
        plot(time_sample,step_counter);
        legend(' Instantaneous speed','Speed of the robot at every step','Step Counter'); 
        title('Speed and intstantaneous speed');
    h=1;
    u=getGlobalx;
    figure(5);
%     for i=1:size(sln.Y,2)
%         %%Number of step
%         %% Size of the step
%         subplot(10,15,i);
%         hold on;
%         plot(u(1,h:h+size(sln.Y{i},1)));
%         plot(u(2,h:h+size(sln.Y{i},1)));
%         h=h+size(sln.Y{i},1);
%     end
     plot(u(1,:));
end