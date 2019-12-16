function [ v_ ] = vectorTransformByQuat( v,q,iq)
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

%поворот кватернионом
q_=quatMulVec(q, v);
q_=quatMulQuat(q_,iq);
v_=q_.rotationAxis;
end

function ab = quatMulQuat(a, b) 
    ab=struct('rotationAxis',[0 0 1],'rotationAngle', 0);

    ab.rotationAngle = a.rotationAngle * b.rotationAngle - a.rotationAxis(1) * b.rotationAxis(1) -...
           a.rotationAxis(2)* b.rotationAxis(2) - a.rotationAxis(3) * b.rotationAxis(3);
    ab.rotationAxis(1) = a.rotationAngle * b.rotationAxis(1) + a.rotationAxis(1) * b.rotationAngle +...
           a.rotationAxis(2) * b.rotationAxis(3) - a.rotationAxis(3) * b.rotationAxis(2);
    ab.rotationAxis(2) = a.rotationAngle * b.rotationAxis(2) - a.rotationAxis(1) * b.rotationAxis(3) +...
           a.rotationAxis(2) * b.rotationAngle + a.rotationAxis(3) * b.rotationAxis(1);
    ab.rotationAxis(3) = a.rotationAngle* b.rotationAxis(3) + a.rotationAxis(1) * b.rotationAxis(2) -...
           a.rotationAxis(2)* b.rotationAxis(1) + a.rotationAxis(3) * b.rotationAngle;
end 
function ab = quatMulVec(a, v) 
    v=struct('rotationAxis',v,'rotationAngle', 0);
    ab = quatMulQuat(a, v) ;
end