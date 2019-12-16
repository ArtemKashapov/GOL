function  instanceLensDraw( fig_handler, Lens, instance_position, instance_orientation)
%INSTANCELENSDRAW Summary of this function goes here
%   Detailed explanation goes here
    for i=1:size(instance_position,1)
        Lens_=rotateLens(Lens,instance_orientation(i,:));
        Lens_=moveLens(Lens_,instance_position(i,:));
        drawLens(fig_handler,Lens_);
    end
end

