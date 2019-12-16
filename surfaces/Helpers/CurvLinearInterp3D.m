function arra3Dout = CurvLinearInterp3D(arra3Din,steps)
arra3Dout=zeros(3,(size(arra3Din,2)-1)*steps-1);
    t=linspace(0,1,steps);
    for i=1:size(arra3Din,2)-1;
            direction=arra3Din(:,i+1)-arra3Din(:,i);
            for j=1:length(t)
              arra3Dout(:,(i-1)*steps+j)=arra3Din(:,i)+direction*t(j);
            end
    end
end