function [ intensity, x ,y ] = quadIntencity( quad_, Rays,M,N)    
%quad_INTENCITY Summary of this function goes here
%   Detailed explanation goes here
gaussCore=[ [ 0.0183    0.0821    0.1353    0.0821    0.0183];
            [ 0.0821    0.3679    0.6065    0.3679    0.0821];
            [ 0.1353    0.6065    1.0000    0.6065    0.1353];
            [ 0.0821    0.3679    0.6065    0.3679    0.0821];
            [ 0.0183    0.0821    0.1353    0.0821    0.0183]];


dx=quad_.L/(M-1);dy=quad_.H/(N-1);
 x=[ -quad_.L/2-2*dx -quad_.L/2-dx....
       -quad_.L/2:dx:quad_.L/2 ...
        quad_.L/2+dy quad_.H/2+2*dx];
 y=[-quad_.H/2-2*dy -quad_.H/2-dy....
       -quad_.H/2:dy:quad_.H/2 ...
        quad_.H/2+dy quad_.H/2+2*dy];

gaussCore=gaussCore/max(max(gaussCore));
tileG=-2:2;
intensity=zeros(M+4,N+4);
bounds=[-quad_.L/2 -quad_.H/2 quad_.L/2 quad_.H/2];
if isstruct(Rays)
    for i=1:length(Rays)
            rayEnd    = Rays(i).r0+Rays(i).e*Rays(i).tEnd;
            position  = moveFromPoint(rayEnd, quad_.ABCD(1:3)*quad_.ABCD(4));
            position  = inverseRotation(position',1,quad_.angles/180*pi);
         if isIn(position(1:2),bounds)
             x_s=tileG+tile(1,M+4,3+(position(1)+quad_.L/2)/quad_.L*M);
             y_s=tileG+tile(1,N+4,3+(position(2)+quad_.H/2)/quad_.H*N);
             intensity(x_s,y_s)=intensity(x_s,y_s) +abs(sum(Rays(i).e.*quad_.ABCD(1:3)))*gaussCore;
         end
    end
else
     %    1   2   3   4   5   6     7   8           9         10  11 12 13
     % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY, R, G, B]
            rayEnd      = zeros(size(Rays(:,1:3)));
            rayEnd(:,1) = Rays(:,1)+Rays(:,4).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(1)*quad_.ABCD(4);
            rayEnd(:,2) = Rays(:,2)+Rays(:,5).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(2)*quad_.ABCD(4);
            rayEnd(:,3) = Rays(:,3)+Rays(:,6).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(3)*quad_.ABCD(4);
%             rayEnd    = Rays(i,1:3)+Rays(i,4:6)*Rays(i,8)-Rays(i,7);
%             position  = moveFromPoint(rayEnd, quad_.ABCD(1:3)*quad_.ABCD(4));
            invRotMat=getInvRotMatrix(quad_.angles/180*pi);
            positions=zeros(size(rayEnd));
            positions(:,1)=invRotMat(1,1)*rayEnd(:,1)+invRotMat(1,2)*rayEnd(:,2)+invRotMat(1,3)*rayEnd(:,3);%+invRotMat(1,4)*1;
            positions(:,2)=invRotMat(2,1)*rayEnd(:,1)+invRotMat(2,2)*rayEnd(:,2)+invRotMat(2,3)*rayEnd(:,3);%+invRotMat(2,4)*1;
            positions(:,3)=invRotMat(3,1)*rayEnd(:,1)+invRotMat(3,2)*rayEnd(:,2)+invRotMat(3,3)*rayEnd(:,3);%+invRotMat(3,4)*1;
% positions 
            isornot=isIn_array(positions,bounds);
            x_s=zeros(length(isornot),5);y_s=x_s;
            x_s(:,3)=tile_array(1,M+4,3+(positions(:,1)+quad_.L/2)/quad_.L*M);
            x_s(:,1)=x_s(:,3)-2;
            x_s(:,2)=x_s(:,3)-1;
            x_s(:,4)=x_s(:,3)+1;
            x_s(:,5)=x_s(:,3)+2;
            y_s(:,3)=tile_array(1,N+4,3+(positions(:,2)+quad_.H/2)/quad_.H*N);
            y_s(:,1)=y_s(:,3)-2;
            y_s(:,2)=y_s(:,3)-1;
            y_s(:,4)=y_s(:,3)+1;
            y_s(:,5)=y_s(:,3)+2;
%             x_s=tileG+tile_array(1,M+4,3+(positions(:,1)+quad_.L/2)/quad_.L*M);
%             y_s=tileG+tile_array(1,N+4,3+(positions(:,2)+quad_.H/2)/quad_.H*N);
           cosangle=abs(Rays(:,4)*quad_.ABCD(1)+Rays(:,5)*quad_.ABCD(2)+Rays(:,6)*quad_.ABCD(3));
%            [cosangle_x,cosangle_y] = meshgrid(cosangle,cosangle);
%            cosangle=(cosangle_x>cosangle_y).*cosangle_x+(cosangle_x<=cosangle_y).*cosangle_y;
isornot
% x_s
% y_s
           for i=1:length(x_s)
               intensity(x_s(i,:),y_s(i,:))=intensity(x_s(i,:),y_s(i,:))+ isornot(i)*cosangle(i)*gaussCore;
           end
          
 
           
  
end


end
function isornot=isIn_array(pos,bounds)
    isornot=(pos(:,1)<=bounds(3).*pos(:,1)>=bounds(1).*...
             pos(:,2)<=bounds(4).*pos(:,2)>=bounds(2) );
end

function isornot=isIn(pos,bounds)
    isornot=(pos(1)<=bounds(3)&&pos(1)>=bounds(1)&&...
                 pos(2)<=bounds(4)&&pos(2)>=bounds(2) );
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
function coord = tile_array(minCoord, maxCoord,i)
         coord = (i==0).*(maxCoord-1);
         coord = coord + (~i==0).*floor(abs(i-(maxCoord-minCoord)*floor(i/(maxCoord-minCoord))));
         coord = coord + (coord==0);
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
function mat=getInvRotMatrix(angle)
    mat=transpose(xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3)));
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
