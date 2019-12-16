function [ z ] = EllipseEquation( x,y,A,B,C )
%ELLIPSEEQUATION Summary of this function goes here
%   Detailed explanation goes here
z = C-sign(C)*abs(C)*sqrt(1 - x.^2/A^2-y.^2/B^2);

end

