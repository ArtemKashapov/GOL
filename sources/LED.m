function [ rays ] = LED(r_0, angle)
%LED Summary of this function goes here
%   Detailed explanation goes here
R=1;
N=16;
asStructOrArray=2;
% N=128*2;%for single only
aper=R*tan(angle);
% angle_sig=1/sqrt(angle*6);
if aper>R
aper=R;
end
  RGB=[630 510 450]*10^-6;
% RGB_colors=[[1 0 0];
%             [0 1 0];
%             [0 0 1]];
x=-aper:2*aper/(N-1):aper;
y=-aper:2*aper/(N-1):aper;
lightDir=[0 0 1];
rays=[];
if asStructOrArray==1
  
       for i=1:N
            for j=1:N
                h=((x(i)^2+y(j)^2));
                if h<aper^2
                   r0=[x(i) y(j) sqrt(R^2-h)];
                   % интенсивность будем считать исходя из гауссовой диаграммы
                   % направленности, где вся энергия сосредоточена между -80 град и
                   % 80 град.
                   angle_=acos(lightDir*r0'/norm(r0)/norm(lightDir))/angle*sqrt(6);
                   intensity=exp(- angle_* angle_);
                   rays=[rays struct('r0',r_0,'e',r0/norm(r0),'tStart',0,'tEnd',1.0,'lam',RGB(1),'wieght', intensity,'color',[1 1 1]*intensity,'internal',0)];
                end
            end
       end
else
        for i=1:N
            for j=1:N
                h=((x(i)^2+y(j)^2));
                if h<aper^2
                   r0=[x(i) y(j) sqrt(R^2-h)];
                   % интенсивность будем считать исходя из гауссовой диаграммы
                   % направленности, где вся энергия сосредоточена между -80 град и
                   % 80 град.
                   angle_=acos(lightDir*r0'/norm(r0))/angle*sqrt(6);
                   intensity=exp(-angle_^2);
                   rays=[rays; [r_0,r0/norm(r0),0,1.0,RGB(1), intensity,[0 0 1]*intensity]];
                end
            end
        end
 end



end

