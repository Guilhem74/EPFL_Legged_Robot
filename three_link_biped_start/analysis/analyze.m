%% Read the README_ASSIGN4.pdf to see what results you need to analyze here. 
function sln = analyse(sln)
    Y = sln.Y{1};
    [N, ~] = size(Y);
      q = Y(:, 1:3);
      q1=q(:,1)
    q2=q(:,2)
    q2=q(:,3)
    figure(2);
    hold on
    plot(q2+atan(q1*1000)/(pi/2)*pi/4,'r')
     figure(3);
     plot((q1*1000)/(pi/2)*pi/4,'b')
end