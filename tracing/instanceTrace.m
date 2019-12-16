function [ rays_in, rays_middle, rays_out] = instanceTrace( opticalElement, rays,...
                                                            instance_element_position, instance_element_orientation,...
                                                            instance_source_position, instance_source_orientation)
%INSTANCETRACE Summary of this function goes here
%   Detailed explanation goes here
 rays_in=[]; rays_middle=[]; rays_out=[];
if size(instance_element_position)~=size(instance_element_orientation)|...
   size(instance_source_position)~=size(instance_source_orientation)|...
   size(instance_source_position)~=size(instance_element_orientation)
   error('non-consistent instance conditions');
end

if strcmp(opticalElement.type,'lens')
    
    rays_middle     = zeros(size(rays,1)*length(instance_element_position),size(rays,2));
    rays_out        = zeros(size(rays,1)*length(instance_element_position),size(rays,2));
    rays_in         = zeros(size(rays,1)*length(instance_element_position),size(rays,2));
  
    indx=1:size(rays,1);
    Len=size(rays,1);
%   size(rays_in)
    for i=1:size(instance_element_position,1)
        Lens_ = rotateLens(opticalElement,instance_element_orientation(i,:));
        Lens_ = moveLens(Lens_,instance_element_position(i,:));
        rays_ = rotateRays(rays,instance_source_orientation(i,:));
        rays_ = shiftRays(rays_,instance_source_position(i,:));
        [rays_,r_mid,r_out]=traceThroughtLens(Lens_,rays_);
%         a=(i-1)*Len+indx;
%         disp([a(1) a(length(a))]);
        rays_in     ((i-1)*Len+indx,:)       = rays_;
        rays_middle ((i-1)*Len+indx,:) = r_mid;
        rays_out    ((i-1)*Len+indx,:) = r_out;
    end
end

if strcmp(opticalElement.type,'surface')

    rays_out       = zeros(size(rays,1)*length(instance_element_position),size(rays,2));
    rays_in        = zeros(size(rays,1)*length(instance_element_position),size(rays,2));
  
    indx=1:size(rays,1);
    Len=size(rays,1);
%     r=rays;
    for i=1:size(instance_element_position,1)
        Lens_ = rotateQuad(opticalElement,instance_element_orientation(i,:));
        Lens_ = moveQuad(Lens_,instance_element_position(i,:));
       
        rays_ = rotateRays(rays, instance_source_orientation(i,:));
        rays_ = shiftRays (rays_, instance_source_position(i,:));
%      rays_in((i-1)*Len+indx,:)       = rays_;
      
        [r_out,rays_]=reflectFormQuad(Lens_,rays_);
      
 
        rays_in((i-1)*Len+indx,:)       = rays_;
        rays_out((i-1)*Len+indx,:)     = r_out;
        r=rays;
    end

end

end

