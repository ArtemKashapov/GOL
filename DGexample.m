%%Пример использования трейсера для толстой линзы
clear all; close all;clc;initEnvio();
%%чтобы перейти к определению функции,необходимо поставить курсор сразу после имени этой функции и нажать ctrl+D 
[ lens ] = getLens( 2.0, 1,  15, -15 );

[ detector] =  flatQuad( 0.25,0.25,[0 0 0],[0.25 0 17]);

[ lens ] = moveLens( lens,[0 0 0]);

[ DG_flat] =  flatQuad( 4,4,[0 0 1],[0 0 -2]);

DG_flat=convertQuad2DG(DG_flat,0.032, 1, 0, -100);

LED_source=paraxialSpot([0 0 -5],1);

% [ rays_out ,rays_difracted]= difractionFromQuadZemax(DG_flat,LED_source);

[ rays_out ,rays_difracted]= difractionFromQuadZemax(DG_flat,LED_source);

[ rays_in, rays_middle, rays_out_] = traceThroughtLens( lens, rays_difracted);
% [ rays_in, rays_middle, rays_out_] = traceThroughtLens( lens, LED_source);
[  rays_out_ ] = quadIntersect( detector, rays_out_);


fig_1=figure(1);
axis vis3d 
view([0 0])
drawLens(fig_1,lens);
drawQuad(fig_1,detector);
drawQuad(fig_1,DG_flat)
drawRays(fig_1,[rays_in;rays_difracted; rays_middle; rays_out;rays_out_]);
% drawRays(fig_1,[rays_in; rays_middle; rays_out_]);
grid on;

fig_2=figure(2);
[~,~,~,~]=drawSpotDiagram(fig_2,detector,rays_out_);

fig_3=figure(3);
[ intensity,x ,y ] = quadIntencity( detector,rays_out_,128,128);
imagesc(x,y,intensity);
axis equal;
