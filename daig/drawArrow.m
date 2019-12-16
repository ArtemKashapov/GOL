% function drawArrow(fig_handler,p_1,p_2 )
function drawArrow(p_1,p_2,scale)
%GETARROW Summary of this function goes here
%   Detailed explanation goes here
        if size(p_1)~=size(p_2)
            error('input vectors sizes missmatch');
        end
        if length(p_1)==2
            drawStraightArrow(p_1,p_2 ,scale)
        end
        if length(p_1)==4
             drawSmoothArrow(p_1,p_2 ,scale)
        end

end
function drawStraightArrow(p_1,p_2,scale )
     polygon=scale*[[0 1 0 0]-1;...
              [0.25 0 -0.25 0.25]];
       angl=getAngle(p_1,p_2);
       rot=rotate(angl);
       polygon=[rot*polygon(:,1) rot*polygon(:,2) rot*polygon(:,3) rot*polygon(:,4)];
        hold on
%         plot(p_1(1),p_1(2),'r*');
%         plot(p_2(1),p_2(2),'g*');
        plot([p_1(1) p_2(1)],[p_1(2) p_2(2)],'Color',[0.5 0.5 0.8],'LineWidth',0.25);
        fill(polygon(1,:)+p_2(1),polygon(2,:)+p_2(2),'r', 'FaceAlpha', 0.4);
        hold off;
end
function drawSmoothArrow(p_1,p_2,scale )
 polygon=scale*[[0 1 0 0]-1;...
          [0.25 0 -0.25 0.25]];
        [x,y]=bizieCurve(p_1,p_2);
        lastPoint = [x(length(x)) y(length(y))];
        prewLastPoint = [x(length(x)-1) y(length(y)-1)];
        angl=getAngle(prewLastPoint,lastPoint);
        rot=rotate(angl);
        polygon=[rot*polygon(:,1) rot*polygon(:,2) rot*polygon(:,3) rot*polygon(:,4)];
        hold on
%         plot(p_1(1),p_1(2),'r*');
%         plot(p_2(1),p_2(2),'g*');
        plot(x,y,'Color',[0.55 0.55 0.8],'LineWidth',0.25);
        fill(polygon(1,:)+p_2(1),polygon(2,:)+p_2(2),'r', 'FaceAlpha', 0.4);
        hold off;
end

function rot=rotate(angle)
rot=[[cos(angle) -sin(angle)];...
     [sin(angle)  cos(angle)]];
end
function angl=getAngle(p1,p2)
      angl = atan((p1(2)-p2(2))/(p1(1)-p2(1)))+pi*((p2(1)-p1(1))<=0);
end

function [x,y]=bizieCurve(p_1,p_2)
t=0:0.05:1;
p_1=[p_1(1) p_1(2)...
         p_1(1)+p_1(3) p_1(2)+p_1(4)];
  
p_2=[p_2(1) p_2(2)...
         p_2(1)+p_2(3) p_2(2)+p_2(4)];
x_s=[p_1(1) p_1(3) p_2(3) p_2(1) ];
y_s=[p_1(2) p_1(4) p_2(4) p_2(2)];
MB = [-1 3 -3 1; 3 -6 3 0; -3 3 0 0; 1 0 0 0];
for i=1:length(t)
    x(i) = [t(i)^3 t(i)^2 t(i) 1]*MB*x_s';%+p_1(1) 
    y(i) = [t(i)^3 t(i)^2 t(i) 1]*MB*y_s';%+p_1(2) 
end    
% hold on
% %     plot(x_s,y_s,'or');
%     hold off;
end