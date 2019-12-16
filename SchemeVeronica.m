clear all; close all;clc;initEnvio();

position=3.2589 + 6.007551 + 0.999975 + 2.952076 + 4.740409 ;
ofsett= 42.1577;
%forward
[ lens1 ] = getLens( 10, 3.2589,  22.01359, -435.760436,'SK16');
[ lens1 ] = moveLens( lens1,[0 0 0]);

[ lens2 ] = getLens( 10, 0.999975, -22.213277, 20.291924,'F2');
[ lens2 ] = moveLens( lens2,[0 0 3.2589+6.007551]);

[ lens3 ] = getLens( 6, 2.952076,  79.683603, -18.389841,'SK16');
[ lens3 ] = moveLens( lens3,[0 0 3.2589 + 6.007551 + 0.999975 + 4.740409]);

%reverce
[ lens_1 ] = getLens( 10, 3.2589, 435.760436,  -22.01359,'SK16');
[ lens_1 ] = moveLens( lens_1,[0 0 position+ofsett*2+2+2.952076+4.750409+0.999975+6.007551]);

[ lens_2 ] = getLens( 10, 0.999975, -20.291924, 22.213277,'F2');
[ lens_2 ] = moveLens( lens_2,[0 0 position+ofsett*2+2+2.952076+4.750409]);

[ lens_3 ] = getLens( 6, 2.952076, 18.389841, -79.683603,'SK16');
[ lens_3 ] = moveLens( lens_3,[0 0 position+ofsett*2+2]);

radialDG = flatQuad( [8 8 0],1,[0 0 0],[0 0 position+ofsett+1]);
radialDG = convertQuad2RadialDG(radialDG,0.032, -1, 0, 10^10);

[ axicon ] =getLens( 4, 1, 10^10, 10^10,'SK16');%; getAxicon( 4, 2,[4 4 1],'SK16');% getLens( 4, 2, 10^10, 10^10,'SK16');%; 

[ axicon ] = moveLens( axicon,[0 0 position+ofsett]);

[ detector] =  flatQuad( [15 15 0],1,[0 0 0],[0 0 position+ofsett*2 + 25]);

[ slit] =  flatQuad( [11 11 0],1,[0 0 0],[0 0 -ofsett]);
[ slit] =  convertQuad2Sphere(slit,10^10);
schema={};

sequensce=[ 1 2 3 10 5 6 7 8];
schema{1}=lens1;
schema{2}=lens2;
schema{3}=lens3;

schema{4}=axicon;

schema{5}=lens_3;
schema{6}=lens_2;
schema{7}=lens_1;


schema{8}=detector;
schema{9}=slit;
schema{10}=radialDG;

SceneSave('schemeVeronica.dat',schema);
% DG_flat =  flatQuad( 4,4,[0 0 1],[0 0 -1]);
% DG_flat=convertQuad2DG(DG_flat,0.032, 1, 0, 10^10);
% schema{5}=DG_flat;

LED_source=paraxialSpot([0 0 -50],[4.9 5]);

% as array
% [ raysIn, raysMiddle, raysOut ] = traceThroughSystem( LED_source, schema);
% as sequence
[ raysIn, raysMiddle, raysOut ] = traceThroughSystem(LED_source, schema,sequensce);

fig_1=figure();


DrawElements(schema);
drawRays(fig_1,[raysIn; ]);
drawRays(fig_1,[raysMiddle;]);
drawRays(fig_1,[ raysOut]);
% plot2svg('full_schema_.svg');
% drawRays(fig_1,[rays_in; rays_middle; rays_out_]);
% 
fig_2=figure(2);
[~,~,~,~]=drawSpotDiagram(fig_2,schema{8},raysOut);

fig_3=figure(3);
[ intensity,x ,y ] = quadIntencity( schema{8},raysOut,128,128);
imagesc(x,y,intensity);
axis equal;