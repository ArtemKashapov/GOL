function [ rays_out, rays_in ] = refractThroughtQuad(quad_, rays_in,material_1,material_2 )
%REFRACTTHROUGHTQUAD Summary of this function goes here
% %   Detailed explanation goes here
% rays_out=zeros(size(rays));
rays_in=quadIntersect(quad_,rays_in);

    if  strcmp(quad_.extraDataType,'flat')
        normal=@(point)(quad_.ABCD(1:3));
        rays_out=Refract(rays_in,normal,material_1,material_2);
    end
    if strcmp(quad_.extraDataType,'sphere')
       ref_point=quad_.position-(quad_.TBN*[0 0 quad_.extraData.R]')';
        normal=@(point)(sphericalNormalArray(point,ref_point));
        rays_out=Refract(rays_in,normal,material_1,material_2);
    end
    if strcmp(quad_.extraDataType,'ellipsoid')
        normal=@(point)(ellipsoidalNormalArray(point,quad_.position,quad_.TBN',...
                                                                  quad_.extraData.A,quad_.extraData.B,...
                                                                  quad_.extraData.C));
        rays_out=Refract(rays_in,normal,material_1,material_2);
    end
    if strcmp(quad_.extraDataType,'paraboloid')
        ref_point=quad_.position-(quad_.TBN*[0 0 quad_.extraData.C]')';
        normal=@(point)(paraboloidalNormalArray(point,ref_point,quad_.extraData.A,quad_.extraData.B));
        rays_out=Refract(rays_in,normal,material_1,material_2);
    end
    
    if strcmp(quad_.extraDataType,'conus')
        ref_point=quad_.position-(quad_.TBN*[0 0 quad_.extraData.C]')';
        normal=@(point)(conusNormalArray(point,ref_point,quad_.extraData.A,quad_.extraData.B,quad_.extraData.C));
        rays_out=Refract(rays_in,normal,material_1,material_2);
    end
    
end


%%
function normal = paraboloidalNormalArray(point,ref_point,A,B)
     normal = zeros(size(point));
%      rho    = sqrt((point(:,1)-ref_point(:,1)).^2+ (point(:,2)-ref_point(:,2)).^2+( point(:,3)-ref_point(:,3)).^2);
     normal(:,1)=-2*(point(:,1)-ref_point(:,1))/A^2;
     normal(:,2)=-2*(point(:,2)-ref_point(:,2))/B^2;
     normal(:,3)=1;
     rho=sqrt(sum(normal(:,1:3).^2,2));
     normal(:,1)=normal(:,1)./rho;
     normal(:,2)=normal(:,2)./rho;
     normal(:,3)=normal(:,3)./rho;
end
function normal_ = ellipsoidalNormalArray(point,position,rotM, A,B,C)
     normal_ = zeros(size(point));
        p_=zeros(size(point));
     point(:,1)=point(:,1)-position(1);%+v(1);
     point(:,2)=point(:,2)-position(2);%+v(2);
     point(:,3)=point(:,3)-position(3);%+v(3);

     p_(:,1)=rotM(1,1)*point(:,1)+rotM(1,2)*point(:,2)+rotM(1,3)*point(:,3);
     p_(:,2)=rotM(2,1)*point(:,1)+rotM(2,2)*point(:,2)+rotM(2,3)*point(:,3);
     p_(:,3)=rotM(3,1)*point(:,1)+rotM(3,2)*point(:,2)+rotM(3,3)*point(:,3)+C;
     
     p_(:,1)=2*(p_(:,1))/A^2;
     p_(:,2)=2*(p_(:,2))/B^2;
     p_(:,3)=2*(p_(:,3))/C^2;
     rotM=rotM';
     normal_(:,1)=rotM(1,1)*p_(:,1)+rotM(1,2)*p_(:,2)+rotM(1,3)*p_(:,3);
     normal_(:,2)=rotM(2,1)*p_(:,1)+rotM(2,2)*p_(:,2)+rotM(2,3)*p_(:,3);
     normal_(:,3)=rotM(3,1)*p_(:,1)+rotM(3,2)*p_(:,2)+rotM(3,3)*p_(:,3);
     rho=sqrt(sum(normal_(:,1:3).^2,2));
     normal_(:,1)=normal_(:,1)./rho;
     normal_(:,2)=normal_(:,2)./rho;
     normal_(:,3)=normal_(:,3)./rho;
end

function normal = sphericalNormalArray(point,ref_point)
     normal = zeros(size(point));
     rho    = sqrt((point(:,1)-ref_point(:,1)).^2+ (point(:,2)-ref_point(:,2)).^2+( point(:,3)-ref_point(:,3)).^2);
     normal(:,1)=(point(:,1)-ref_point(:,1))./rho;
     normal(:,2)=(point(:,2)-ref_point(:,2))./rho;
     normal(:,3)=(point(:,3)-ref_point(:,3))./rho;
end

function normal = conusNormalArray(point,ref_point, A,B,C)
     normal = zeros(size(point));
  
     normal(:,1) =  point(:,1)-ref_point(1);
     normal(:,2) =  point(:,2)-ref_point(2);
     normal(:,3) =  point(:,3)-ref_point(3);
  
     
%      normal(:,:) = point-ref_point;
     normal(:,1) =  2*normal(:,1)/A^2;
     normal(:,2) =  2*normal(:,2)/B^2;
     normal(:,3) = -2*normal(:,3)/C^2;

         rho=sqrt(sum(normal.*normal,2));

     normal(:,1) =  normal(:,1)./rho;
     normal(:,2) =  normal(:,2)./rho;
     normal(:,3) =  normal(:,3)./rho;
%      normal=normal./rho;
       
end

function rays_out=Refract(rays_in,normal,material_1,material_2)
    if isstruct(rays_in)
        rays_out = refract_struct(rays_in,normal,material_1,material_2);
    else
        rays_out = refract_array(rays_in,normal,material_1,material_2);
    end
end

function rays_out = refract_array(rays_in,normal,material_1,material_2)
%     for i=1:length(rays_in)   
     %    1   2    3    4     5    6        7     8                         9              10  11 12 13
        % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY,  R,  G, B]
        rays_out=rays_in;
        rays_out(:,1)=rays_in(:,1)+rays_in(:,4).*rays_in(:,8);
        rays_out(:,2)=rays_in(:,2)+rays_in(:,5).*rays_in(:,8);
        rays_out(:,3)=rays_in(:,3)+rays_in(:,6).*rays_in(:,8);
        
        rays_out(:,8)=1;
        n_=normal(rays_out(:,1:3));
        
        mat_1 = material_1(rays_in(:,9));
        
        mat_2 = material_2(rays_in(:,9));
        
        dir_by_n_=rays_in(:,4).*n_(:,1)+rays_in(:,5).*n_(:,2)+rays_in(:,6).*n_(:,3);
        
        dir_by_n_=dir_by_n_.*mat_1;
        
        material_part=(sqrt( ( mat_2.^2-mat_1.^2 )./(dir_by_n_).^2 + 1  ) - 1 ).*(dir_by_n_);
                                     
        rays_out(:,4)=rays_in(:,4).*mat_1+material_part.*n_(:,1);
        rays_out(:,5)=rays_in(:,5).*mat_1+material_part.*n_(:,2);
        rays_out(:,6)=rays_in(:,6).*mat_1+material_part.*n_(:,3);
        
        normalaizer=sqrt(rays_out(:,4).^2+rays_out(:,5).^2+rays_out(:,6).^2);
        rays_out(:,4)=rays_out(:,4)./normalaizer;
        rays_out(:,5)=rays_out(:,5)./normalaizer;
        rays_out(:,6)=rays_out(:,6)./normalaizer;
%     end
end
function rays_out = refract_struct(rays_in,normal,material_1,material_2)
% rays_in  should be allready intersected with surface
rays_out=rays_in;
    for i=1:length(rays_in)
        rays_out(i).r0=rays_in(i).r0+rays_in(i).e*rays_in(i).tEnd;
        rays_out(i).tEnd=1;
        n_=normal(rays_out(i).r0);
        rays_out(i).e=rays_in(i).e+(sqrt((material_2(rays_in(i).lam)^2-material_1(rays_in(i).lam)^2)/(rays_in(i).e*n_)^2+1)-1)*...
                            (rays_in(i).e*n_)*n_;
    end
end