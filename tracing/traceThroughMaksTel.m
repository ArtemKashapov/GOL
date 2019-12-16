function [ rays_in, rays_out ] = traceThroughMaksTel( MaksTel, rays_in )
%TRACETHROUGHTLENS Summary of this function goes here
%   Detailed explanation goes here
 [rays_in,~,rays_a_m]=traceThroughtLens(MaksTel.menisc,rays_in);
 [rays_a_mm,rays_a_m]=reflectFormQuad(MaksTel.mmirror,rays_a_m); % rays_a_m stands for rays after menisc
 [rays_out,rays_a_mm]=reflectFormQuad(MaksTel.smirror,rays_a_mm); % rays_a_mm - rays after main mirror
end

%function [ rays_in, rays_middle, rays_out ] = traceThroughtLens( Lens, rays_in )
%function [ rays_out, rays_in  ] = reflectFormQuad( quad_, rays_in)





