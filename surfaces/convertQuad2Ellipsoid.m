function [ quad_ ] = convertQuad2Ellipsoid( quad_,A,B,C)
%CONVERTQUAD2ELLIPSOID Summary of this function goes here
%   Detailed explanation goes here
quad_.extraDataType=ellipsoidType();

quad_.apertureData=getAperture(quad_.apertureType, quad_.apertureData,A,B);

apertureMesh = createMesh(quad_.apertureType, quad_.apertureData, A,B,C);



quad_.extraData=struct('surfaceMesh',apertureMesh,...
                        'A',A,'B',B,'C',C,'refractionIndex',1,...
                        'surfaceMatrix',[[1/A^2 0     0      0];...
                                              [0     1/B^2 0      0];...
                                              [0     0     1/C^2  0];...
                                              [0     0     0     -1]]);
end


