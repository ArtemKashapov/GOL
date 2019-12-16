function [ x,y,colors,angleSize] = spotDiagram( quad_,Rays)
%SPOTDIAGRAM Summary of this function goes here
%   Detailed explanation goes here

% bounds=[-quad_.L/2 -quad_.H/2 quad_.L/2 quad_.H/2];

% bounds=[[-quad_.L/2 0, 0]; [quad_.L/2,0 ,0 ];[0, -quad_.H/2, 0];[0, quad_.H/2,0]];

% x=1:length(Rays);
% x=x-x;
% y=x;
% colors=zeros(length(Rays),3);
% angleSize=zeros(length(Rays),3);

        %    1   2   3   4   5   6     7   8           9         10  11 12 13
        % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY, R, G, B]
            rayEnd      = zeros(length(Rays),3);
            rayEnd(:,1) = Rays(:,1)+Rays(:,4).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(1)*quad_.ABCD(4);
            rayEnd(:,2) = Rays(:,2)+Rays(:,5).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(2)*quad_.ABCD(4);
            rayEnd(:,3) = Rays(:,3)+Rays(:,6).*(Rays(:,8)-Rays(:,7))-quad_.ABCD(3)*quad_.ABCD(4);

            rayEnd(:,1) = rayEnd(:,1) -quad_.position(1);
            rayEnd(:,2) = rayEnd(:,2) -quad_.position(2);
            rayEnd(:,3) = rayEnd(:,3) -quad_.position(3);
            
            invRotMat=getInvRotMatrix(quad_.angles/180*pi);
            positions=zeros(size(rayEnd));
            positions(:,1)=invRotMat(1,1)*rayEnd(:,1)+invRotMat(1,2)*rayEnd(:,2)+invRotMat(1,3)*rayEnd(:,3);%+invRotMat(1,4)*1;
            positions(:,2)=invRotMat(2,1)*rayEnd(:,1)+invRotMat(2,2)*rayEnd(:,2)+invRotMat(2,3)*rayEnd(:,3);%+invRotMat(2,4)*1;
            positions(:,3)=invRotMat(3,1)*rayEnd(:,1)+invRotMat(3,2)*rayEnd(:,2)+invRotMat(3,3)*rayEnd(:,3);%+invRotMat(3,4)*1;

            isornot=logical(isInsideArray(positions,quad_));
            siso=sum(isornot);

            if siso==0 %
%             printf('In spot Diagram, no rays intersect the quad. Returning empty lists;\n');
	     x=y=angleSize=colors=[];
             return;  
            end
            x=(positions(isornot,1)+quad_.position(1));
            y=(positions(isornot,2)+quad_.position(2));
%            colors=zeros(size(Rays(:,11:13)));
            colors=zeros(siso,3);
            angleSize=zeros(siso,3);
            colors(:,1)=Rays(isornot,11);
            colors(:,2)=Rays(isornot,12);
            colors(:,3)=Rays(isornot,13);

            angleSize(:,1)=atan(positions(isornot,1)/quad_.ABCD(4)); 
            angleSize(:,2)=atan(positions(isornot,2)/quad_.ABCD(4));
            angleSize(:,3)=atan(sqrt(positions(isornot,1).^2+positions(isornot,2).^2)/quad_.ABCD(4));

%            x=(positions(:,1)+quad_.position(1)).*isornot;
%            y=(positions(:,2)+quad_.position(2)).*isornot;
%            colors=zeros(size(Rays(:,11:13)));
%            colors(:,1)=Rays(:,11).*isornot;
%            colors(:,2)=Rays(:,12).*isornot;
%            colors(:,3)=Rays(:,13).*isornot;

%            angleSize(:,1)=atan(positions(:,1)/quad_.ABCD(4)).*isornot; 
%            angleSize(:,2)=atan(positions(:,2)/quad_.ABCD(4)).*isornot ;
%            angleSize(:,3)=atan(sqrt(positions(:,1).^2+positions(:,2).^2)/quad_.ABCD(4)).*isornot;
end

function isornot=isInsideArray(pos,q)
 isornot=[];
 if(length(pos)>1)
  for i=1:length(pos)
   isornot(end+1)=isInside(pos(i,:),q);
  end
  isornot=isornot';
 else
  isornot=isInside(pos,q);
 end
 return;
end



%function isornot=isIn_array(pos,bounds)
%    isornot=((pos(:,1)<=bounds(3)).*(pos(:,1)>=bounds(1)).*...
%             (pos(:,2)<=bounds(4)).*(pos(:,2)>=bounds(2)) );
%end
%function isornot=isIn(pos,bounds)
%    isornot=(pos(1)<=bounds(3)&&pos(1)>=bounds(1)&&...
%             pos(2)<=bounds(4)&&pos(2)>=bounds(2) );
%end

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
function  mat = getInvRotMatrix(angle)
    mat= transpose(xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3)));
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