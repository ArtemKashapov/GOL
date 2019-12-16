clear all; close all;clc;initEnvio();
%%чтобы перейти к определению функции,необходимо поставить курсор сразу после имени этой функции и нажать ctrl+D 
[ detector] =  flatQuad( 0.7,0.7,[0 0 0],[0 0 6.5]);

Axicon=getAxicon( 2,2,2,2,0.5);

LED_source = paraxialSpot([0 0 -1],[0.5]);

% [  LED_source ] = quadIntersect( conus, LED_source);
[ LED_source, rays_middle, rays_out] = traceThroughtLens( Axicon, LED_source);
[  rays_out ] = quadIntersect( detector, rays_out);

fig_handler=figure(1);
axis vis3d 
view([0 0])
%TODO
% упаковать всё в общую функцию трейсинга
 drawLens(fig_handler,Axicon);
 drawQuad(fig_handler,detector);
 drawRays(fig_handler,[LED_source;rays_middle; rays_out]);
%  drawRays(fig_handler,LED_source);
 axis equal;
 grid on;
 
 fig_2=figure(2);
[~,~,~,~]=drawSpotDiagram(fig_2,detector,rays_out);

fig_3=figure(3);
[ intensity,x ,y ] = quadIntencity( detector,rays_out,64,64);
imagesc(x,y,intensity);
axis equal;

 