clear all;
close all;
 clc;
alpha_1=-pi/12;
alpha_2=-alpha_1;
 start  = [ 2 -1];
 finish = [ 4 0 ];
 
 p_1=[start     start/norm(start ) ];
 p_2=[finish  -finish/norm(finish)];
 

 figure(1)
 axis equal;
drawArrow(p_1,p_2,0.2);
hold on;
 plot(0,0,'k*');
 hold off;