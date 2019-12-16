function  vec = getRotation(vec,dirOrPos, angle)
% angle should be in radians
    if dirOrPos==1
        vec_=xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3))*[vec; 1];
    else
        vec_=xRotMat(angle(1))*yRotMat(angle(2))*zRotMat(angle(3))*[vec; 0];
    end
    vec=vec_(1:3);
end