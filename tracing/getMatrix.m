function [matr,newdir,firstvertex,lastvertex,zf]=getMatrix(schema,lambda,dir)
% We do matrix optics only in the order supplied
% dir=1 from left to right
% dir=0 from right to left 
% We use matrix formalism with (y,n*alpha) - the formalism that is described in Russian wikipedia
% In English wikipedia, there is different formulae with (y,alpha)
[curmatr,curdir,curf,curl]=getMatrixElement(schema{1},lambda,dir); 
% curf - current first vertex
% curl - current last vertex
matr=curmatr;
%newdir=curdir;
for i=2:length(schema)
 [nextmatr,nextdir,nextf,nextl]=getMatrixElement(schema{i},lambda,curdir);
 Tc=[1,abs(nextf-curl);0,1];
 matrint=nextmatr*Tc*matr; 
 matr=matrint;
 curdir=nextdir;
 curf=nextf;
 curl=nextl;
end
newdir=curdir;
firstvertex=curf;
lastvertex=curl;
if matr(2,1)==0
 printf('The system in getMatrix does not focus. Setting zf to zero\n'); 
 zf=0; 
end
if newdir
 zf=lastvertex-matr(1,1)/matr(2,1);
else
 zf=lastvertex+matr(1,1)/matr(2,1);
end  
end