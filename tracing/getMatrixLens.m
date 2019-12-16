function [matr]=getMatrixLens(lens,lambda,dir)
% dir=1 from left to right
% dir=0 from right to left 
% We use matrix formalism with (y,n*alpha) - the formalism that is described in Russian wikipedia
% In English wikipedia, there is different formulae with (y,alpha)
n=lens.materialDispersion(lambda);

if length(lens.frontSurface.extraData.R)>1 || length(lens.backSurface.extraData.R)>1
 printf('We do not work with aspherical surfaces yet, front length=%d, back length=%d\n',length(lens.frontSurface.R),length(lens.backSurface.R)) 
 Rfront=lens.frontSurface.extraData.R(1);
 Rback=lens.backSurface.extraData.R(1);
else
 Rfront=lens.frontSurface.extraData.R;
 Rback=lens.backSurface.extraData.R;
end

lthick=norm(lens.frontSurface.position-lens.backSurface.position);
%printf('lthick=%f\n',lthick);

if dir 
 M1=[1,0;-(n-1)/Rfront,1];
 M3=[1,0;(n-1)/Rback,1];
else
 M1=[1,0;-(n-1)/Rback,1];
 M3=[1,0;(n-1)/Rfront,1];
end 
M2=[1,lthick/n;0,1];
matr=M3*M2*M1;   
end