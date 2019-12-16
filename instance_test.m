clear all; close all;clc;initEnvio();

% [ lens ] = getLens( 1.125,1,2,[1.25 1.25 -0.5] );
[ lens ] = getLens( 2.0, 4, 3, [2 2 -1.4] );
LED_source=paraxialSpot([0 0 0],0.5);
[ detector] =  flatQuad( 10,10,[0 0 0],[0 0 10]);

instance_position=[[1 1 0];[1 -1 0];[-1 1 0];[-1 -1 0];[0 1 1]]*2.5; 
instance_orientation=[[0 0 0];[0 45 0];[0 -45 0];[45 0 0];[-45 0 0]];
% instance_position=[[-1 -1 0]]*2; 
% instance_orientation=[[45 0 0]];
instance_position_=[];
for i=1:size(instance_orientation,1)
rotM=xRotMat(instance_orientation(i,1)/180*pi)*...
         yRotMat(instance_orientation(i,2)/180*pi)*...
         zRotMat(instance_orientation(i,3)/180*pi);
instance_position_=[instance_position_;instance_position(i,:)-1.5*(rotM(1:3,1:3)*[0;0;1])'];
end

 [ rays_in, rays_middle, rays_out] = instanceTrace( lens , LED_source,...
                                                                         instance_position,  instance_orientation,...
                                                                         instance_position_, instance_orientation);


fig_1=figure(1);
axis vis3d 
view([0 0])
% drawRays(fig_1,LED_source);
% drawRays(fig_1,LED_source);
% drawRays(fig_1,reflected);
% drawLens(fig_1,lens);
instanceLensDraw( fig_1, lens, instance_position, instance_orientation);
% instanceRaysDraw( fig_1, LED_source, instance_position_, instance_orientation  )
drawQuad(fig_1,detector);
r=[rays_in; rays_middle; rays_out];
drawRays(fig_1,r);

