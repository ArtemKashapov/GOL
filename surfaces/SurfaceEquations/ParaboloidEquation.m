function [ z ] = ParaboloidEquation( x,y,A,B )
%PARABOLOIDEQUATION Summary of this function goes here
%   Detailed explanation goes here
z=sign(A)*x.^2/A^2+sign(B)*y.^2/B^2;

end

