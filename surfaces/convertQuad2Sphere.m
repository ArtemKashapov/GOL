function [ quad_ ] = convertQuad2Sphere(quad_,R)
%CONVERTQUAD2SPHERE Summary of this function goes here
%   Detailed explanation goes here
quad_.extraDataType=sphereType();
% quality=64;

quad_.apertureData=getAperture(quad_.apertureType, quad_.apertureData,R,R);

apertureMesh = createMesh(quad_.apertureType, quad_.apertureData, R);

quad_.extraData=struct('surfaceMesh',apertureMesh,...
                                  'R',R,'A',R,'B',R,'C',R,'refractionIndex',1,...
                                   'surfaceMatrix',[[1/R^2 0     0      0];...
                                                         [0     1/R^2 0      0];...
                                                         [0     0     1/R^2  0];...
                                                         [0     0     0       -1];]);

end

