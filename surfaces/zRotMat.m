function  rotZ = zRotMat(angle)
rotZ =[[cos(angle) -sin(angle) 0 0];...
           [sin(angle)   cos(angle) 0 0];
           [0                0             1 0];...
           [0                0             0 1]];
end