function [matr,newdir,firstvertex,lastvertex]=getMatrixElement(elm,lambda,dir)
if strcmp(elm.type,'lens')
 matr=getMatrixLens(elm,lambda,dir);
 newdir=dir;
 if dir
  firstvertex=elm.frontSurface.position(3); % We support rays with principal axis along Z axis ONLY
  lastvertex=elm.backSurface.position(3); 
 else
  firstvertex=elm.backSurface.position(3); % We support rays with principal axis along Z axis ONLY
  lastvertex=elm.frontSurface.position(3);   
 end
 return; 
elseif strcmp(elm.type,'surface')
 firstvertex=lastvertex=elm.position(3);
 if isempty(elm.extraDataType)
  matr=[1,0;0,1];
  newdir=dir;
  return; 
 end
 if endWith(elm.extraDataType, 'DG')
  printf('Diffraction gratings cannot be processed in matrix formalism in geometrical optics. Ignoring DG\n'); 
  matr=[1,0;0,1];
  newdir=dir;
  return;
 end
 if endWith(elm.extraDataType,'mirror')
  matr=getMatrixMir(elm,dir);
  newdir=~dir;
  return;  
 else
  matr=[1,0;0,1];
  newdir=dir;
  return;  
 end
else
 matr=[1,0;0,1];
 newdir=dir;
 firstvertex=lastvertex=0; 
 printf('Ingnoring unknown element in getMatrixElement\n');
end  
end