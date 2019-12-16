function [ Lens ] = rotateLens( Lens,orientation)
%ROTATELENS Summary of this function goes here
%   Detailed explanation goes here
delta_pos =[0 0 Lens.tickness]';
odl_pos   = Lens.frontSurface.position;

frontSurface=moveQuad(Lens.frontSurface,[0 0 0]);
backSurface=moveQuad(Lens.backSurface,[0 0 0]);
% backSurface.TBN
frontSurface = rotateQuad(frontSurface,orientation);
backSurface  = rotateQuad(backSurface,orientation);
% backSurface.TBN
frontSurface= moveQuad(frontSurface, odl_pos );
    if length(orientation)==3
        backSurface= moveQuad(backSurface,  odl_pos+getRotation(delta_pos,1, orientation/180*pi)');
    elseif length(orientation)==4
        [q,iq]=quaternion(orientation(1:3),orientation(4));
        delta_pos = vectorTransformByQuat(delta_pos,q,iq);
        backSurface= moveQuad(backSurface,  odl_pos+delta_pos);
    end
Lens.frontSurface = frontSurface;
Lens.backSurface  = backSurface;

end

