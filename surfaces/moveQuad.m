function [ quad_ ] = moveQuad( quad_, position )
   for i=1:5
        quad_.XYZ(:,i)=moveToPoint(quad_.XYZ(:,i),-quad_.position);
        quad_.XYZ(:,i)=moveToPoint(quad_.XYZ(:,i),position);
   end
   quad_.position=position;
   quad_.ABCD   = [quad_.ABCD(1:3) quad_.ABCD(1:3)*quad_.position'];
end

