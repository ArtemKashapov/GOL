function [ rays ] = paraxialSpot( r0, R)
%LED Summary of this function goes here
%   Detailed explanation goes here
% R=1;
N=81;
RGB=[630 510 450]/1000;%wavelength in micrometers
RGB_colors=[[1 0 0];
             [0 1 0];
             [0 0 1]];
if length(R)==1
x=-R:2*R/(N-1):R;
y=-R:2*R/(N-1):R;
rays=[];
intensity=1;
for i=1:N
   for j=1:N
    rho=x(i)^2+y(j)^2;
    if  rho<=R^2
     for k=1:3
      rays=[rays; [r0+[x(i) y(j) 0],[0 0 1],0,1.0,RGB(k), intensity,RGB_colors(k,:)*intensity]];
     end
    end
   end
end
else
    phi=linspace(0,2*pi*(N-1)/N,N);
    rho=linspace(R(1),R(2),N);
    
    rays=[];
    for k=1:3
        for i=1:N
            for j=1:N
                   % ������������� ����� ������� ������ �� ��������� ���������
                   % ��������������, ��� ��� ������� ������������� ����� -80 ���� �
                   % 80 ����.
%                    rho=sqrt(x(i)^2+y(j)^2);
%                    if rho>=R(1)&&rho<=R(2)
                     rays=[rays; [r0+rho(i)*[cos(phi(j)) sin(phi(j)) 0],...
                                  [0 0 1],0,1.0,RGB(k), 1,RGB_colors(k,:)]];
%                   end
            end
        end
    end
end


end

