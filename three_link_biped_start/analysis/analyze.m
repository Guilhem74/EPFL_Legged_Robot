%% Read the README_ASSIGN4.pdf to see what results you need to analyze here. 
function sln = analyse(sln,vitesse)
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
  
    plot(q3)
    legend('q1','q2','q3');
    figure()
      plot(vitesse(5:end))
   
end