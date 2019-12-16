clear all; close all;clc;initEnvio();
radialDG = flatQuad( 10,10,[0 0 0],[0 0 0]);
dtetector = flatQuad( 10,10,[0 0 0],[0 0 10]);
radialDG = convertQuad2RadialDG(radialDG,0.032, -1, 0, 10^10);
schema={};
schema{1}=radialDG;
schema{2}=dtetector;


LED_source=LED([0 0 -10], 0.1);%paraxialSpot([0 0 -10],[4.8 4.9]);

% as array
% [ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema);
% as sequence
[ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema);

fig_1=figure();


DrawElements(schema);
drawRays(fig_1,[raysIn; ]);
drawRays(fig_1,[raysMiddle;]);
drawRays(fig_1,[ raysOut]);
% plot2svg('full_schema_.svg');
% drawRays(fig_1,[rays_in; rays_middle; rays_out_]);
% 
fig_2=figure(2);
[~,~,~,~]=drawSpotDiagram(fig_2,schema{2},raysOut);

fig_3=figure(3);
[ intensity,x ,y ] = quadIntencity( schema{2},raysOut,128,128);
imagesc(x,y,intensity);
axis equal;