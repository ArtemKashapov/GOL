function [ rays_out ,rays_difracted] = difractionFromQuadZemax( quad_,rays )
%DIFRACTIONFROMQUAD Summary of this function goes here
%   Detailed explanation goes here
% предполагается, что нормаль к решёте всегда совпадает с осью Z в
% собственно пространстве решётки
% if strcmp(quad_.extraDataType,'faltDG')
%     error('this surface can not be represented as DG');
% end

 [ rays_out] = quadIntersect( quad_, rays);


 
    if  strcmp(quad_.extraDataType,'flatDG')
        normal=@(point)(quad_.ABCD(1:3));
        rays_difracted = Difract(rays_out, normal, quad_.extraData.orders, quad_.extraData.density);%
    end
    if strcmp(quad_.extraDataType,'sphereDG')
       ref_point=quad_.position-(quad_.TBN*[0 0 quad_.extraData.R]')';
        normal=@(point)(sphericalNormalArray(point,ref_point));
        rays_difracted = Difract(rays_out, normal, quad_.extraData.orders, quad_.extraData.density);%
    end
    if strcmp(quad_.extraDataType,'ellipsoidDG')
%         ref_point=quad_.position-(quad_.TBN*[0 0 0.5*quad_.extraData.C]')';
        normal=@(point)(ellipsoidalNormalArray(point,quad_.position,quad_.TBN',...
                                                                  quad_.extraData.A,quad_.extraData.B,...
                                                                  quad_.extraData.C));
        rays_difracted = Difract(rays_out, normal, quad_.extraData.orders, quad_.extraData.density);%
    end
    if strcmp(quad_.extraDataType,'paraboloidDG')
        ref_point=quad_.position-(quad_.TBN*[0 0 quad_.extraData.C]')';
        normal=@(point)(paraboloidalNormalArray(point,ref_point,quad_.extraData.A,quad_.extraData.B));
        rays_difracted = Difract(rays_out, normal, quad_.extraData.orders, quad_.extraData.density);%Refract(rays_in,normal,material_1,material_2);
    end
 

end


function raysOut = Difract(raysIn, normal, difOrder, ticksDencity)
      
%    1   2    3    4     5    6        7     8                         9              10  11 12 13
        % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY,  R,  G, B]
        raysOut=raysIn;
        raysOut(:,1)=raysIn(:,1)+raysIn(:,4).*raysIn(:,8);
        raysOut(:,2)=raysIn(:,2)+raysIn(:,5).*raysIn(:,8);
        raysOut(:,3)=raysIn(:,3)+raysIn(:,6).*raysIn(:,8);
%         [T,B,N] = getAllLocalTBN(raysOut(:,1:3),normal);
T=zeros(size(raysOut(:,1:3)));

B=zeros(size(raysOut(:,1:3)));

N=zeros(size(raysOut(:,1:3)));

T(:,1)=1;
B(:,2)=1;
N(:,3)=1;

      ray_dir_dg_space = ArrayOfMatrixMultByArrayOfVectors(T,B,N,raysIn(:,4:6));

     difraction_angle =  difOrder*10^-3*raysIn(:,9)/ticksDencity-sqrt(1 - ray_dir_dg_space(:,3).^2);
 
    
     rho=sqrt(raysIn(:,4).^2+raysIn(:,6).^2);

    %     1    2    3    4     5    6         7    8                    9             10  11 12 13
    % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY, R, G, B]

    raysOut(:,1)= raysIn(:,1)+raysIn(:,4).*(raysIn(:,8)-raysIn(:,7));%+quad_.TextureHeight());
    raysOut(:,2)= raysIn(:,2)+raysIn(:,5).*(raysIn(:,8)-raysIn(:,7));%+quad_.TextureHeight());
    raysOut(:,3)= raysIn(:,3)+raysIn(:,6).*(raysIn(:,8)-raysIn(:,7));%+quad_.TextureHeight());
    raysOut(:,4)=rho.*difraction_angle;
    raysOut(:,5)=raysIn(:,5);
    raysOut(:,6)=rho.*sqrt(1-difraction_angle.^2);
    raysOut(:,8)=1;
    raysOut(:,9:13)=raysIn(:,9:13);
        
end

function [T,B,N] = getAllLocalTBN(positions,normal)
%normal
N=normal(positions);
T=zeros(size(N));
B=zeros(size(N));
%Tagent
T(:,1)=1-N(:,1).*N(:,1);
T(:,2)= - N(:,2).*N(:,1);
T(:,3)= - N(:,3).*N(:,1);
%Bi-Tangent
B(:,1)=N(:,3).*T(:,2)-N(:,2).*T(:,3);
B(:,2)=N(:,1).*T(:,3)-N(:,3).*T(:,1);
B(:,3)=N(:,2).*T(:,1)-N(:,1).*T(:,2);

end

function vects = matrixMultByArrayOfVectors(mat,vectorsArray)
    vects=zeros(size(vectorsArray));
    vects(:,1) = mat(1,1)*vectorsArray(:,1)+mat(1,2)*vectorsArray(:,2)+mat(1,3)*vectorsArray(:,3);
    vects(:,2) = mat(2,1)*vectorsArray(:,1)+mat(2,2)*vectorsArray(:,2)+mat(2,3)*vectorsArray(:,3);
    vects(:,3) = mat(3,1)*vectorsArray(:,1)+mat(3,2)*vectorsArray(:,2)+mat(3,3)*vectorsArray(:,3);
end

function vects = ArrayOfMatrixMultByArrayOfVectors(T,B,N,vectorsArray)
    vects=zeros(size(vectorsArray));
    vects(:,1) = T(:,1).*vectorsArray(:,1)+B(:,1).*vectorsArray(:,2)+N(:,1).*vectorsArray(:,3);
    vects(:,2) = T(:,2).*vectorsArray(:,1)+B(:,2).*vectorsArray(:,2)+N(:,2).*vectorsArray(:,3);
    vects(:,3) = T(:,3).*vectorsArray(:,1)+B(:,3).*vectorsArray(:,2)+N(:,3).*vectorsArray(:,3);
end
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
     normal = zeros(size(point));
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
