clear all; close all;clc;initEnvio();

[ lens1 ] = getLens( 2, 2,  [ 15],[  -15]);
[ lens1 ] = moveLens( lens1,[0 0 0]);
% 
[ lens2 ] = getLens( 2, 2, 2, -2 );
[ lens2 ] = moveLens( lens2,[0 0 4]);

[ lens3 ] = getLens( 2.0, 1,  -15, -15);
[ lens3 ] = moveLens( lens3,[0 0 4]);


[ lens4 ] = getLens( 2.0, 1,  -15, -15);
[ lens4 ] = moveLens( lens4,[0 0 6]);


[ lens5 ] = getLens( 2.0, 1,  -15, -15);
[ lens5 ] = moveLens( lens5,[0 0 8]);



[ lens6 ] = getLens( 2.0, 1,  -15, -15);
[ lens6 ] = moveLens( lens6,[0 0 10]);
% 

[ detector] =  flatQuad( [0.2,0.2 0],1,[0 0 0],[0.28 0 19.5]);


schema={};
% sequensce=[1 2 3 4 5 6 7];
schema{1}=lens1;
% schema{2}=lens2;
% schema{3}=detector;

SceneSave('schemeVeronica.dat',schema);

% schema{2}=lens2;
% schema{3}=lens3;
% 
% schema{4}=lens4;
% schema{5}=lens5;
% schema{6}=lens6;

% schema{7}=detector;

% DG_flat =  flatQuad( 4,4,[0 0 1],[0 0 -1]);
% DG_flat=convertQuad2DG(DG_flat,0.032, 1, 0, 10^10);
% schema{5}=DG_flat;

LED_source=paraxialSpot([0 0 -5],[1.9 2]);

% as array
% [ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema);
% as sequence
[ raysIn, raysMiddle, raysOut ] = traceThroughtLens( lens1,LED_source);

fig_1=figure();

axis vis3d 
view([0 0])
DrawElements(schema);
xlabel('x');ylabel('y');zlabel('z');
drawRays(fig_1,[raysIn; ]);
drawRays(fig_1,[raysMiddle; ]);
drawRays(fig_1,[ raysOut]);
% drawRays(fig_1,[rays_in; rays_middle; rays_out_]);
grid on;
% 
% fig_2=figure(2);
% [~,~,~,~]=drawSpotDiagram(fig_2,schema{7},raysOut);
% 
% fig_3=figure(3);
% [ intensity,x ,y ] = quadIntencity( schema{7},raysOut,128,128);
% imagesc(x,y,intensity);
% axis equal;