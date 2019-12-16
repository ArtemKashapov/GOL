function [ apertureMesh ] = createMesh( ApertureType, ApertureData,varargin )
%CREATEMESH Summary of this function goes here
%   Detailed explanation goes here
    if 1 == ApertureType
        golmesh = GlobalGet('RectangularApertureMesh');
        multiplyer=[ApertureData(1) ApertureData(2)];
        golmesh =  CurvLinearInterp3D(golmesh,10);      
    elseif 2 == ApertureType
        golmesh = GlobalGet('CircularApertureMesh');
        multiplyer=[ApertureData(2) ApertureData(2)];
    end
    
        apertureMesh=zeros(size(golmesh));
        
        apertureMesh(1,:)=golmesh(1,:)*multiplyer(1);

        apertureMesh(2,:)=golmesh(2,:)*multiplyer(2);

if length(varargin)==1
       apertureMesh(3,:) =SphereEquation(apertureMesh(1,:),apertureMesh(2,:),varargin{1});
elseif length(varargin)==2
        apertureMesh(3,:) =ParaboloidEquation(apertureMesh(1,:),apertureMesh(2,:),varargin{1},varargin{2});
elseif length(varargin)==3
        apertureMesh(3,:) =EllipseEquation(apertureMesh(1,:),apertureMesh(2,:),varargin{1},varargin{2},varargin{3});
elseif length(varargin)==4
end


end

