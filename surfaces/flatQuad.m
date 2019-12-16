function [ quad_] = flatQuad(aperture,apertureType,e,r)
% H - height
% L - length
% e - [ angle_x angle_y angle_z]
% r - [x_0 y_0 z_0];

% aperture=[L H delta] - Rectangular
% aperture=[Rmin Rmax delta] - Circular
% But for circular the aperture(3) is not used at all!
if apertureType==1
    [xyz,TBN,aperture] = initRectAperture(aperture,e,r);
elseif apertureType==2
    [xyz,TBN,aperture] = initCircAperture(aperture,e,r);
else
     disp('Gol error: in flatQuad, apertureType=%d should be 1 - rectangular or 2 - circular. Returning 0\n',apertureType);
     quad_=[];
     return; % Let's not allow wrong aperture types - it's going to make debugginbg much easier!
end

    quad_=struct('XYZ',xyz,'ABCD',[TBN(:,3)' TBN(:,3)'*r'],'angles',e,'position',r,...
                        'apertureType',apertureType,'apertureData',aperture,'TextureHeight',@()(0),'invTBN',TBN^-1,...
                        'TBN',TBN,'TextureNormal',@()(TBN(:,3)'),...
                        'extraDataType','','extraData',[],'rotationMatrix',...
                         xRotMat(e(1)/180*pi)*yRotMat(e(2)/180*pi)*zRotMat(e(3)/180*pi)...
                        ,'type','surface');
end

function [xyz,TBN,aperture] = initRectAperture(aperture,e,r)
L = aperture(1);
H = aperture(2);
xyz=[[-L/2 L/2   L/2 -L/2 -L/2];...
     [ H/2 H/2 -H/2 -H/2  H/2];...
     [ 0    0      0      0     0]];
if length(aperture)==2 || (length(aperture)==3 && aperture(3)==0)
 aperture=[L,H,0];
end
if length(aperture)==3 
 d = aperture(3);
 if d>L/2||d>H/2
     disp('Warning:aperture area selfintersection')
    %         d=(L+H)/4; % This d is still bigger than min(L/2,H/2), does not eliminate selfintersection
      d=min(L/2,H/2);
 end
 aperture = [L,H,d];
 xyz_=[[-L/2+d L/2-d   L/2-d -L/2+d -L/2+d];...
           [ H/2-d H/2-d -H/2+d -H/2+d  H/2-d];...   % ADV: the first value in this row used to be 'H/2-', corrected 
           [ 0    0      0      0     0]];
 xyz=[xyz_ xyz];
else
 if length(aperture)~=2
  disp('Gol error: in flatQuad>initRectAperture, length(aperture)=%d, should be 2 or 3\n',length(aperture));
  TBN=0;
  return;
 end
end
%     tangent=[1 0 0]';
%     bitangent=[0 1 0]';
%     normal=[0 0 1]';
TBN=[[1 0 0]' [0 1 0]' [0 0 1]'];
for i=1:3
 TBN(:,i)=getRotation(TBN(:,i),1,e/180*pi);
end
    
for i=1:size(xyz,2);
 xyz(:,i)=getRotation(xyz(:,i),1,e/180*pi);
 xyz(:,i)=moveToPoint(xyz(:,i),r);
end
end


function [xyz,TBN,aperture] = initCircAperture(aperture,e,r)
R_min = aperture(1);
R_max = aperture(2);
% d = aperture(3); 
     if R_min >R_max
         disp('Warning:aperture area selfintersection')
         tmp = R_max;
         R_min = tmp;
     end
t=linspace(0,1,64)*2*pi;
xyz=[sin(t)*R_max;cos(t)*R_max;t*0];
aperture = [R_min,R_max];
if R_min~=0
    xyz=[xyz [sin(t)*R_min;cos(t)*R_min;t*0]];
end   
   TBN=[[1 0 0]' [0 1 0]' [0 0 1]'];
    for i=1:3
      TBN(:,i)=getRotation(TBN(:,i),1,e/180*pi);
    end

    for i=1:size(xyz,2);
        xyz(:,i)=getRotation(xyz(:,i),1,e/180*pi);
        xyz(:,i)=moveToPoint(xyz(:,i),r);
    end
end
