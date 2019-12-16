%%Пример использования трейсера для толстой линзы
clear all; close all;clc;initEnvio();
%%чтобы перейти к определению функции,необходимо поставить курсор сразу после имени этой функции и нажать ctrl+D 
[ lens ] = getLens( 2, 1,  [ 15],[  -15]);
[ detector] =  flatQuad( [2 2 ],2,[0 0 0],[0 0 16]);
[ lens ] = moveLens( lens,[0 0 3.1415]);

[ lens ] = rotateLens( lens,[0 2 0]);

LED_source=paraxialSpot([0 0 0],1);
[ rays_in, rays_middle, rays_out ] = traceThroughtLens( lens, LED_source);
[  rays_out ] = quadIntersect( detector, rays_out);
% [ x,y,~,~] = spotDiagram( detector,rays_out);

fig_1=figure(1);
% subplot(1,3,1)
axis vis3d 
view([0 0])
DrawElements({lens, detector});
% drawQuad(detector);
drawRays(fig_1,[rays_in;rays_middle;rays_out]);
grid on;

% handler1=subplot(1,3,2);
% [~,~,~,~]=drawSpotDiagram(handler1,detector,rays_out);
% handler2=subplot(1,3,3);
% [ intensity,x ,y ] = quadIntencity( detector,rays_out,30,30);
% imagesc(x,y,intensity);
% axis equal;
