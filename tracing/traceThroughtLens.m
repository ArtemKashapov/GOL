function [ rays_in, rays_middle, rays_out ] = traceThroughtLens( Lens, rays_in )
%TRACETHROUGHTLENS Summary of this function goes here
%   Detailed explanation goes here
r_0=sum(rays_in(:,1:3))/size(rays_in,1);
    if norm(r_0-Lens.frontSurface.position)<norm(r_0-Lens.backSurface.position)
%         rays_in=quadIntersect(Lens.frontSurface,rays_in);
        [rays_middle,   rays_in] = refractThroughtQuad(Lens.frontSurface, rays_in,@(x)(1), Lens.materialDispersion);
        [rays_out, rays_middle] = refractThroughtQuad(Lens.backSurface, rays_middle,Lens.materialDispersion,@(x)(1));
%         disp('mode_one')
    else
        [rays_middle,    rays_in]    = refractThroughtQuad(Lens.backSurface,rays_in,@(x)(1),Lens.materialDispersion);
        [rays_out , rays_middle] = refractThroughtQuad(Lens.frontSurface,rays_middle,Lens.materialDispersion,@(x)(1));
%         disp('mode_two')
    end
end

