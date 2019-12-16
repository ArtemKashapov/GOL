function [ quad_ ] = convertQuad2RadialDG(quad_,density, orders, transOrReflect, ABC)
%CONVERTQUAD2DG Summary of this function goes here
% quad_.extraDataType='flatDG';
if quad_.apertureType==1
    direction = [quad_.apertureData(1)*[0   0   0.75 0.75 1   0.75 0.75 0]-quad_.apertureData(1)/2;
                    quad_.apertureData(2)*[0.6 0.4 0.4  0.25 0.5 0.75 0.6  0.6]-quad_.apertureData(2)/2;
                              [0   0   0    0    0   0    0    0]];
elseif quad_.apertureType==2
    direction = [quad_.apertureData(2)*[0   0   0.75 0.75 1   0.75 0.75 0]-quad_.apertureData(2)/2;
                     quad_.apertureData(2)*[0.6 0.4 0.4  0.25 0.5 0.75 0.6  0.6]-quad_.apertureData(2)/2;
                                  [0   0   0    0    0   0    0    0]];
end
direction =  CurvLinearInterp3D(direction,10);      
        
if length(ABC)==1
     quad_ = convertQuad2Sphere(quad_,ABC);
     quad_.extraDataType='radialDG';
     direction = WrapDirectionUponSurface(direction,[ABC(1),0,0],1);
       direction(1,:)=direction(1,:);
       direction(2,:)=direction(2,:);
       direction(3,:)=direction(3,:)+ABC(1);
end
if length(ABC)==2
     quad_ = convertQuad2Paraboloid(quad_,ABC(1),ABC(2));
     quad_.extraDataType='radialDG';
     direction = WrapDirectionUponSurface(direction,[ABC(1),ABC(2),0],2);
end
if length(ABC)==3
     quad_ = convertQuad2Ellipsoid( quad_,ABC(1),ABC(2),ABC(3));
     quad_.extraDataType='radialDG';
     direction = WrapDirectionUponSurface(direction,[ABC(1),ABC(2),ABC(3)],3);
end

for i=1:size(direction,2)
             direction(:,i)=getRotation(direction(:,i),1,quad_.angles/180*pi);
             direction(:,i)=moveToPoint(direction(:,i),quad_.ABCD(1:3)'*quad_.ABCD(4));
end
% quad_.extraData=struct('direction',direction,'density',density,'orders',orders,'transOrReflect',transOrReflect);
quad_.extraData.direction=direction;%=struct('direction',direction,'density',density,'orders',orders,'transOrReflect',transOrReflect);
quad_.extraData.density =density;
quad_.extraData.orders  =orders;
quad_.extraData.transOrReflect=transOrReflect;
end

 
 
% type=1 -sphere;
% type=2- parabalod;
% type=3- ellipsoid;

function arra3Dout = WrapDirectionUponSurface(arra3Din,ABC,type)

wrapSurf=@(x,y,A,B,C)(0);

arra3Dout=arra3Din;

    if type==1
        wrapSurf=@(x,y,A,B,C)(-sign(A)*(sqrt(A^2- x.^2 - y.^2)));%DONE
    elseif type==2
        wrapSurf=@(x,y,A,B,C)(sign(A)*x.^2/A^2+sign(B)*y.^2/B^2);%DONE?
    elseif type==3
        wrapSurf=@(x,y,A,B,C)(sign(C)*C^2*(1- x.^2/A^2 - y.^2/B^2));%DONE?
    end
    
     arra3Dout(3,:)=wrapSurf(arra3Dout(1,:),arra3Dout(2,:),ABC(1),ABC(2),ABC(2));

end
