clear all; close all;clc;initEnvio();
%работают : ориентация в пространстве + перемещения;
[ mirror]   =  flatQuad( 1,1,[0 0 0],[0 0 0]);
[ detector] =  flatQuad( 0.25,0.25,[0 0 0],[0 0 -1]);
A=30;
%%%
[ sphere ]  =  flatQuad( 2,2,[1 0 0],[0 0 0]);
[ sphere ]  =  convertQuad2Paraboloid(sphere,2,2);
[ lens ] = getLens( 2.0, 4,  [2 2 1.4],[2 2 -0.5] );
%[ lens ] = getLens( 2.25,1,20,-20 );
direction=[0 0.5 0.31 A/180*pi];
[ lens ] = rotateLens( lens,direction);
[ lens ] = moveLens( lens,[0 0 1]);


% подключение нужных функций
%  LED_source=LED([0 0 -1],30*pi/360);
LED_source=paraxialSpot([0 0 0],1);
LED_source_1=paraxialSpot([0 0 -2],1);

% LED_source_1(:,2)=0;
% rotM=xRotMat(0)*yRotMat(0)*zRotMat(A);
 pos=[0 0 1]+1.5*(lens.frontSurface.TBN*[0;0;1])';
 [ LED_source ] = rotateRays( LED_source,direction);

 [ LED_source ] = shiftRays( LED_source,pos);




% mirror=convertQuad2DG(mirror,0.005,-1,2);
tic
 [ rays_in, rays_middle, rays_out ] = traceThroughtLens( lens, LED_source);

% [  LED_source_1 ] = quadIntersect( sphere, LED_source_1);
% [ reflected, rays_out ] = reflectFormQuad( elipsoid, rays_out );
% [ reflected, LED_source_1 ] = reflectFormQuad( sphere, LED_source_1);
toc
fig_1=figure(1);
axis vis3d 
view([0 0])
drawRays(fig_1,rays_in);
drawRays(fig_1,rays_middle);
drawRays(fig_1,rays_out );
% drawRays(fig_1,LED_source);
% drawRays(fig_1,LED_source_1);
% drawRays(fig_1,reflected);
drawLens(fig_1,lens);
drawQuad(fig_1,detector);
% drawQuad(fig_1, sphere);
% drawQuad(fig_1,elipsoid);
grid on;


% fig_2=figure(2);
% set(fig_2,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
% set(fig_2,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman');
% % imagesc(x_*1000,y_*1000,intensity_');
% colormap jet;
% colorbar
% grid on;
% axis equal;
% xlabel('x, \mum');
% ylabel('y, \mum');
% saveas(fig,'10_mum_roughness.emf')
% saveas(fig,'10_mum_roughness.png')

% fig_3=figure(3);

% drawSpotDiagram(fig_3,detector,reflected);
