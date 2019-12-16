function [ rays ] = paraxialSpotHom(r0, R, N)
% r0 - origin, R(1), R(2) - inner and outer radii of the beam
% N - number of rays on one side. 
% Total number of rays is N^2*pi/4 excluding those which are screened by central aperture
if N<3 || N>1000
 printf('N=%d is out of range, N=50 is used instead\n',N)
 N=10;
end 
RGB=[630 510 450]/1000;%wavelength in micrometers
RGB_colors=[[1 0 0];
             [0 1 0];
             [0 0 1]];
             
x=-R(2):2*R(2)/(N-1):R(2);
y=-R(2):2*R(2)/(N-1):R(2);
rays=[];
intensity=1;
for i=1:N
 for j=1:N
  h=x(i)^2+y(j)^2;
  if  h<=R(2)^2 && h>=R(1)^2
   for k=1:3
    rays=[rays; [r0+[x(i) y(j) 0],[0 0 1],0,1.0,RGB(k), intensity,RGB_colors(k,:)*intensity]];
   end
  end
 end
end
end