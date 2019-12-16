function [ intensity,x ,y ] = quadIntencity( quad_, Rays,M,N)    
%quad_INTENCITY Summary of this function goes here
%   Detailed explanation goes here
gaussCore=[ [ 0.0183    0.0821    0.1353    0.0821    0.0183];
                    [ 0.0821    0.3679    0.6065    0.3679    0.0821];
                    [ 0.1353    0.6065    1.0000    0.6065    0.1353];
                    [ 0.0821    0.3679    0.6065    0.3679    0.0821];
                    [ 0.0183    0.0821    0.1353    0.0821    0.0183]];
if quad_.apertureType==1
 L=quad_.apertureData(1);
 H=quad_.apertureData(2);
else
 printf('Gol error: quadIntencity for quads other than rectangular is not yet realized. Returning 0 \n');
 intensity=x=y=0;
 return;
end


dx=L/(M-1);dy=H/(N-1);
 x=[ -L/2-2*dx -L/2-dx....
       -L/2:dx:L/2 ...
        L/2+dy H/2+2*dx]+quad_.position(1);
 y=[-H/2-2*dy -H/2-dy....
       -H/2:dy:H/2 ...
        H/2+dy H/2+2*dy]+quad_.position(2);

%gaussCore=gaussCore/max(max(gaussCore)); % This is not necessary because explicit initialization formula is normalized
tileG=-2:2;
intensity=zeros(M+4,N+4);
bounds=[-L/2 -H/2 L/2 H/2];
   for i=1:length(Rays)
            rayEnd    = Rays(i,1:3)+Rays(i,4:6)*Rays(i,8);
            rayEnd(:,1)    = rayEnd(:,1)-quad_.position(1);
            rayEnd(:,2)    = rayEnd(:,2)-quad_.position(2);
            rayEnd(:,3)    = rayEnd(:,3)-quad_.position(3);
%             position  = moveFromPoint(rayEnd, quad_.ABCD(1:3)*quad_.ABCD(4));
%             position  = inverseRotation(rayEnd',1,quad_.angles/180*pi);
%             
            invRotMat=getInvRotMatrix(quad_.angles/180*pi);
            positions=zeros(size(rayEnd));
            positions(:,1)=invRotMat(1,1)*rayEnd(:,1)+invRotMat(1,2)*rayEnd(:,2)+invRotMat(1,3)*rayEnd(:,3);%+invRotMat(1,4)*1;
            positions(:,2)=invRotMat(2,1)*rayEnd(:,1)+invRotMat(2,2)*rayEnd(:,2)+invRotMat(2,3)*rayEnd(:,3);%+invRotMat(2,4)*1;
            positions(:,3)=invRotMat(3,1)*rayEnd(:,1)+invRotMat(3,2)*rayEnd(:,2)+invRotMat(3,3)*rayEnd(:,3);%+invRotMat(3,4)*1;

            
%         if isIn(positions(1:2),bounds)
         if isInside(positions(1:2),quad_) % ADV correction; this takes into account different quad types
             x_s=tileG+tile(1,M+4,3+(positions(1)+L/2)/L*M);
             y_s=tileG+tile(1,N+4,3+(positions(2)+H/2)/H*N);
             intensity(x_s,y_s)=intensity(x_s,y_s) +abs(sum(Rays(i,4:6).*quad_.ABCD(1:3)))*gaussCore;
         end
       
    end
  intensity=intensity';
end
function  mat = getInvRotMatrix(angle)
    mat= transpose(xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3)));
end
function coord=tile(minCoord, maxCoord,i)
    if i==0
        coord=maxCoord-1;
    else
        L=maxCoord-minCoord;
        tmp=i/L;
        coord=floor((abs(i-L*floor(tmp))));
    end
    if coord==0
        coord=1;
    end
end
function  rotX = xRotMat(angle)
rotX =[[1 0               0              0];...
       [0 cos(angle) -sin(angle)  0];...
       [0 sin(angle)   cos(angle) 0];...
       [0 0               0              1]];
end
function  rotY = yRotMat(angle)
rotY =[[  cos(angle)   0  sin(angle)  0];...
       [  0                1  0               0];...
       [ -sin(angle)    0  cos(angle) 0];...
       [  0                 0  0              1]];
end
function  rotZ = zRotMat(angle)
rotZ =[[cos(angle) -sin(angle) 0 0];...
       [sin(angle)   cos(angle) 0 0];
       [0                0             1 0];...
       [0                0             0 1]];
end

function  vec = inverseRotation(vec,dirOrPos, angle)
    if dirOrPos==1
        vec_= transpose(xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3)))*[vec  1]';
    else
        vec_= transpose(xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3)))*[vec  0]';
    end
    vec=vec_(1:3);
end
function vec = moveFromPoint(vec,Pos)
% size(vec)
    vec_=[[1 0 0 -Pos(1)];...
          [0 1 0 -Pos(2)];...
          [0 0 1 -Pos(3)];...
          [0 0 0 1]]*[vec 1]';
    vec=vec_(1:3);
end
