function [ quad_ ] = rotateQuad( quad_, orientation )
%ROTATEQUAD Summary of this function goes here
%   Detailed explanation goes here
if length(orientation)==3
    [ quad_ ] =EulerRotation(quad_, orientation);
elseif length(orientation)==4
    [ quad_ ] =QuaternionRotation(quad_, orientation);
end

end
function [ quad_ ] =EulerRotation(quad_, orientation)
inv_rot_m =(xRotMat(quad_.angles(1)/180*pi)*yRotMat(quad_.angles(2)/180*pi)*zRotMat(quad_.angles(3)/180*pi))';
rot_m     =(xRotMat(orientation(1)/180*pi)*yRotMat(orientation(2)/180*pi)*zRotMat(orientation(3)/180*pi));
   for i=1:5
        quad_.XYZ(:,i)=moveToPoint(quad_.XYZ(:,i), -quad_.position);
        quad_.XYZ(:,i)=inv_rot_m(1:3,1:3)*quad_.XYZ(:,i);

        quad_.XYZ(:,i)=rot_m(1:3,1:3)*quad_.XYZ(:,i);
        quad_.XYZ(:,i)=moveToPoint(quad_.XYZ(:,i),quad_.position);
    end
    
    tangent      = quad_.XYZ(:,1)-quad_.XYZ(:,2);tangent=tangent/norm(tangent);
    bitangent    = quad_.XYZ(:,4)-quad_.XYZ(:,1);bitangent=bitangent/norm(bitangent);
    normal       = cross(bitangent,tangent);normal=normal/norm(normal);
    quad_.TBN = [tangent bitangent normal];
   
   quad_.ABCD   = [normal' normal'*quad_.position'];
   quad_.angles  = orientation;
   quad_.invTBN = quad_.TBN^-1;
   quad_.rotationMatrix=rot_m;
end
function [ quad_ ] =QuaternionRotation(quad_, orientation)
[q,iq]=quaternion(orientation(1:3),orientation(4));
    for i=1:5
        quad_.XYZ(:,i)=moveToPoint(quad_.XYZ(:,i), -quad_.position);
        quad_.XYZ(:,i)=vectorTransformByQuat(quad_.XYZ(:,i),q,iq);
        quad_.XYZ(:,i)=moveToPoint(quad_.XYZ(:,i),quad_.position);
    end
    tangent      = quad_.XYZ(:,1)-quad_.XYZ(:,2);tangent=tangent/norm(tangent);
    bitangent    = quad_.XYZ(:,4)-quad_.XYZ(:,1);bitangent=bitangent/norm(bitangent);
    normal       = cross(bitangent,tangent);normal=normal/norm(normal);
    quad_.TBN = [tangent bitangent normal];
   
   quad_.ABCD   = [normal' normal'*quad_.position'];
   quad_.angles  = [0 0 0];
   quad_.quaternions=[q iq];
   quad_.invTBN = quad_.TBN^-1;
   quad_.rotationMatrix=[[-quad_.TBN [0; 0; 0]];[0 0 0 1]]; 
end
