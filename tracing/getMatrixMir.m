function [matr]=getMatrixMir(mirr,dir)
F2=2/mirr.extraData.R(1);
if ~dir
 F2=-F2;
end
matr=[1,0;F2,1];  
end
