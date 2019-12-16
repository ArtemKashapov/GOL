function [ quat,invQuat ] = quaternion(e,a)
%QUATERNION Summary of this function goes here
%   Detailed explanation goes here
quat=struct('rotationAxis',[0 0 1],'rotationAngle', 0);
quat=create_quat(e, a,quat);
invQuat= invertQuat(quat);
end

function quat=create_quat(rotate_vector, rotate_angle,quat)
    rotate_vector = rotate_vector/norm(rotate_vector);
    quat.rotationAngle = cos(rotate_angle / 2);
    quat.rotationAxis = rotate_vector * sin(rotate_angle / 2);
end
function quat=scaleQuat(quat,scl)
    quat.rotationAngle = quat.rotationAngle*scl;
    quat.rotationAxis = quat.rotationAxis*scl;

end
function l = lenghtQuat(quat)
l=sqrt(sum(quat.rotationAngle.*quat.rotationAngle)+sum(quat.rotationAxis.*quat.rotationAxis));
end
function quat = normalizeQuat(quat)
l=lenghtQuat(quat);

quat=scaleQuat(quat,1/l);
end
function quat = invertQuat(quat)
    quat.rotationAngle = quat.rotationAngle;
    quat.rotationAxis = -quat.rotationAxis;
    quat = normalizeQuat(quat);
end

