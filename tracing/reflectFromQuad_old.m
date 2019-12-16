function [ rays_ ] = reflectFromQuad_old(quad_, rays)
%REFLECTFROMQUAD Summary of this function goes here
%   Detailed explanation goes here
    rays_=[];
    if isstruct(rays)
          for i=1:length(rays)
             rays_=[rays_ struct('r0',rays(i).r0+rays(i).e*(rays(i).tEnd+quad_.TextureHeight()),'e',...
                                                 reflect_struct(rays(i).e,quad_.TextureNormal()),'tStart',0,'tEnd',1.0,'lam',rays(i).lam,'wieght',...
                                                 rays(i).wieght,'color',rays(i).color*0.9,'internal',0)];
         end
    else
        rays_          = zeros(size(rays));
        ray_l          = (rays(:,8)-rays(:,7)+quad_.TextureHeight());
        rays_(:,1)     = rays(:,1)+rays(:,4).*ray_l;
        rays_(:,2)     = rays(:,2)+rays(:,5).*ray_l;
        rays_(:,3)     = rays(:,3)+rays(:,6).*ray_l;
        rays_(:,4:6)   = reflect_array(rays(:,4:6),quad_.TextureNormal());
        rays_(:,7)     = 0;
        rays_(:,8)     = 1;
        rays_(:,9)     = rays(:,9);
        rays_(:,10)    = rays(:,10);
        rays_(:,11:13) = rays(:,11:13);
%         
%         for i=1:length(rays)
%             %    1   2   3   4   5   6     7   8           9         10  11 12 13
%             % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY, R, G, B]
%              rays_=[rays_ ;[rays(i,1:3)+rays(i,4:6)*(rays(i,8)-rays(i,7)+quad_.TextureHeight()),...
%                             reflect(rays(i,4:6),quad_.TextureNormal()),0,1.0,rays(i,9),...
%                             rays(i,10),rays(i,11:13)*0.9]];
%          end
    end
      
end
function dir=reflect_array(dir, normal)
    dir_normal=(dir(:,1).*normal(1)+dir(:,2).*normal(2)+dir(:,3).*normal(3));
    dir(:,1)=dir(:,1)-2*dir_normal*normal(1);
    dir(:,2)=dir(:,2)-2*dir_normal*normal(2);
    dir(:,3)=dir(:,3)-2*dir_normal*normal(3);
end

function dir=reflect_struct(dir, normal)
   dir=dir-2*(dir*normal')*normal;
end