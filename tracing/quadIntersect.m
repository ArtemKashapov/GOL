function [ rays  ] = quadIntersect( quad_,rays )
%QUADINTERSECT Summary of this function goes here
%   Detailed explanation goes here

  if startWith(quad_.extraDataType,'flat')||strcmp(quad_.extraDataType,'')
      rays=flatIntersection(quad_,rays);
  else
        rays=Intersection(quad_,rays);
  end
end

function rays=flatIntersection(quad_,rays)
    if isstruct(rays)
         for i=1:length(rays)
            rays(i).tEnd=-((quad_.ABCD(1:3)*rays(i).r0')-quad_.ABCD(4))/(quad_.ABCD(1:3)*rays(i).e');
         end
    else
            rays(:,8)=-((quad_.ABCD(1)*rays(:,1)+quad_.ABCD(2)*rays(:,2)+quad_.ABCD(3)*rays(:,3))...
                            -quad_.ABCD(4))./...
                            (quad_.ABCD(1)*rays(:,4)+quad_.ABCD(2)*rays(:,5)+quad_.ABCD(3)*rays(:,6));
    end
end




function rays=Intersection(quad_,rays)

          %    1   2    3    4     5    6        7     8                    9              10  11 12 13
          % [r_1,r_2,r_3,e_1,e_2,e_3,START,END,WAVE_LENGTH, INTENSITY,  R,  G, B]
            ray_dir      = zeros(size(rays(:,4:6)));
            ray_pos      = zeros(size(rays(:,1:3)));
            ray_dirA     = zeros(size(rays(:,4:6)));
            ray_posA     = zeros(size(rays(:,1:3)));
            ray_pos_tmp  = zeros(size(rays(:,1:3)));
           
            surfM=quad_.extraData.surfaceMatrix;
            
            A=surfM(1:3,1:3)*quad_.TBN';
            TBN=quad_.TBN';
            B=surfM(4,:)+surfM(:,4)';
            %направление луча в собственной системе координат поверхности
            ray_dirA(:,1) = (A(1,1)*rays(:,4) + A(1,2)*rays(:,5) + A(1,3)*rays(:,6)); 
            ray_dirA(:,2) = (A(2,1)*rays(:,4) + A(2,2)*rays(:,5) + A(2,3)*rays(:,6));
            ray_dirA(:,3) = (A(3,1)*rays(:,4) + A(3,2)*rays(:,5) + A(3,3)*rays(:,6));
            
            ray_dir(:,1) = (TBN(1,1)*rays(:,4) + TBN(1,2)*rays(:,5) + TBN(1,3)*rays(:,6)); 
            ray_dir(:,2) = (TBN(2,1)*rays(:,4) + TBN(2,2)*rays(:,5) + TBN(2,3)*rays(:,6));
            ray_dir(:,3) = (TBN(3,1)*rays(:,4) + TBN(3,2)*rays(:,5) + TBN(3,3)*rays(:,6));
            
            %положение луча в собственной системе координат поверхности
            V_r=TBN'*[0;0;quad_.extraData.C];
            ray_pos_tmp(:,1)=rays(:,1)-quad_.position(1)+V_r(1);
            ray_pos_tmp(:,2)=rays(:,2)-quad_.position(2)+V_r(2);
            ray_pos_tmp(:,3)=rays(:,3)-quad_.position(3)+V_r(3);

            ray_pos(:,1) =(TBN(1,1)*ray_pos_tmp(:,1) + TBN(1,2)*ray_pos_tmp(:,2) + TBN(1,3)*ray_pos_tmp(:,3)); 
            ray_pos(:,2) =(TBN(2,1)*ray_pos_tmp(:,1) + TBN(2,2)*ray_pos_tmp(:,2) + TBN(2,3)*ray_pos_tmp(:,3));
            ray_pos(:,3) =(TBN(3,1)*ray_pos_tmp(:,1) + TBN(3,2)*ray_pos_tmp(:,2) + TBN(3,3)*ray_pos_tmp(:,3));

            ray_posA(:,1) =(A(1,1)*ray_pos_tmp(:,1) + A(1,2)*ray_pos_tmp(:,2) + A(1,3)*ray_pos_tmp(:,3)); 
            ray_posA(:,2) =(A(2,1)*ray_pos_tmp(:,1) + A(2,2)*ray_pos_tmp(:,2) + A(2,3)*ray_pos_tmp(:,3));
            ray_posA(:,3) =(A(3,1)*ray_pos_tmp(:,1) + A(3,2)*ray_pos_tmp(:,2) + A(3,3)*ray_pos_tmp(:,3));

            
            A_coeff=sum(ray_dir(:,1:3).*ray_dirA(:,1:3),2);
            B_coeff=sum(ray_dir(:,1:3).*ray_posA(:,1:3),2)+sum(ray_pos(:,1:3).*ray_dirA(:,1:3),2)+...
                   B(1)*ray_dir(:,1)+B(2)*ray_dir(:,2)+B(3)*ray_dir(:,3);
            C_coeff=B(1)*ray_pos(:,1)+B(2)*ray_pos(:,2)+B(3)*ray_pos(:,3)+sum(ray_pos(:,1:3).*ray_posA(:,1:3),2)+surfM(4,4);
            
            
            
            D=B_coeff.^2-4*A_coeff.*C_coeff;
            
            
            
            
            
            
            
            
%             b=sum(ray_pos(:,1:3).*ray_dir(:,1:3),2);
%             dir=sum(ray_dir(:,1:3).*ray_dir(:,1:3),2);
%             D=(b).^2 - dir.*(sum(ray_pos(:,1:3).*ray_pos(:,1:3),2)-(quad_.extraData.A*quad_.extraData.B*quad_.extraData.C)^2);
%  
            t_1=(-B_coeff+sqrt(D))./A_coeff/2;
            t_2=(-B_coeff-sqrt(D))./A_coeff/2;
            
            distance_1 = sqrt((rays(:,1)+rays(:,4).*t_1-quad_.position(1)).^2+...
                                      (rays(:,2)+rays(:,5).*t_1-quad_.position(2)).^2+...
                                      (rays(:,3)+rays(:,6).*t_1-quad_.position(3)).^2);
            distance_2 = sqrt((rays(:,1)+rays(:,4).*t_2-quad_.position(1)).^2+...
                                      (rays(:,2)+rays(:,5).*t_2-quad_.position(2)).^2+...
                                      (rays(:,3)+rays(:,6).*t_2-quad_.position(3)).^2);
            
            rays(:,8) = (distance_1<distance_2).*t_1+(distance_1>distance_2).*t_2;                     
   
end


function vec = moveFromPoint(vec,Pos)
% size(vec)
    vec_=[[1 0 0 -Pos(1)];...
              [0 1 0 -Pos(2)];...
              [0 0 1 -Pos(3)];...
              [0 0 0 1]]*[vec 1]';
    vec=vec_(1:3);
end