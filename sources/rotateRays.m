function [ rays ] = rotateRays(rays, newDirection)
%ROTATERAYS Summary of this function goes here
%   Detailed explanation goes here
if length(newDirection)==3
    rays=eulerRotation(rays, newDirection);
elseif length(newDirection)==4
    rays=quaterionRotation(rays, newDirection);
end
end
function rays=eulerRotation(rays, newDirection)
        rot_m =xRotMat(newDirection(1)/180*pi)*yRotMat(newDirection(2)/180*pi)*zRotMat(newDirection(3)/180*pi);
        old_dir  = rays(:,4:6); 
        old_pos = rays(:,1:3);

        rays (:,4) = rot_m(1,1)*old_dir(:,1) + rot_m(1,2)*old_dir(:,2) + rot_m(1,3)*old_dir(:,3); 
        rays (:,5) = rot_m(2,1)*old_dir(:,1) + rot_m(2,2)*old_dir(:,2) + rot_m(2,3)*old_dir(:,3);
        rays (:,6) = rot_m(3,1)*old_dir(:,1) + rot_m(3,2)*old_dir(:,2) + rot_m(3,3)*old_dir(:,3);

        rays (:,1) = rot_m(1,1)*old_pos(:,1) + rot_m(1,2)*old_pos(:,2) + rot_m(1,3)*old_pos(:,3); 
        rays (:,2) = rot_m(2,1)*old_pos(:,1) + rot_m(2,2)*old_pos(:,2) + rot_m(2,3)*old_pos(:,3);
        rays (:,3) = rot_m(3,1)*old_pos(:,1) + rot_m(3,2)*old_pos(:,2) + rot_m(3,3)*old_pos(:,3);

end

function rays=quaterionRotation(rays, newDirection)
    [q,iq]=quaternion(newDirection(1:3),newDirection(4));
    for i=1:size(rays,1)
        rays(i,1:3) = vectorTransformByQuat( rays(i,1:3),q,iq);
        rays(i,4:6) = vectorTransformByQuat( rays(i,4:6),q,iq);
    end
end

