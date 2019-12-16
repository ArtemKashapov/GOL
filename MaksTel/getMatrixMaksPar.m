function [matr,newdir,firstvertex,lastvertex,zf,mt]=getMatrixMaksPar(MaksTelPar)
% mtp - Maksutov Telescope Parameters  
mt=getMaksTel(MaksTelPar(1),MaksTelPar(2),MaksTelPar(3),MaksTelPar(4),MaksTelPar(5),MaksTelPar(6),MaksTelPar(7),MaksTelPar(8),MaksTelPar(9)); 
deflam=0.55;
[matr,newdir,firstvertex,lastvertex,zf]=getMatrix(mt,deflam,1);
%printf('zfmatr=%.3f\n',zf);  
end