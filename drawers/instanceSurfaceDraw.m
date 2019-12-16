function instanceSurfaceDraw(fig_handler, Lens, instance_position, instance_orientation)
%INSTANCESURFACEDRAW Summary of this function goes here
%   Detailed explanation goes here
%     anglesExpression = array [ 3 -Euller angles, 4 - Quaternion]/ Example : [ 3 4 4 3]
 
    for i=1:size(instance_position,1)
        
        Lens_=moveQuad(Lens,instance_position(i,:));
        Lens_=rotateQuad(Lens_,instance_orientation(i,:));  
%         
%         for j=2:length(anglesExpression(i,:))
%             Lens_=rotateQuad(Lens_,instance_orientation(i,...
%                             sum(anglesExpression(i,1:j-1))+(1:anglesExpression(i,j))));        
%         end
%         
        drawQuad(fig_handler,Lens_);
    end

end

