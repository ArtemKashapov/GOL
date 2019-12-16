function [schema,raysOut]=getTraceMinInd(pMinInd,nrays)
%global minInd;
%global mtpMinInd;
%global raysOutMin;
global MaksTelMatrMin;

mtp=fillMinInd(pMinInd);

MaksTelMatrMin{1}=schema=getMaksTel(mtp(1),mtp(2),mtp(3),mtp(4),mtp(5),mtp(6),mtp(7),mtp(8),mtp(9));

raysIn=paraxialSpotHom([0 0 -400],[mtp(8) mtp(1)],nrays);
[ raysIn,raysMiddle,raysOut ] = traceThroughSystem(raysIn, schema);

% [matr,newdir,firstvertex,lastvertex,zf]=getMatrix(schema,lambda,dir)

deflam=0.55;
[matr,~,~,~,zfmatr]=getMatrix(schema,deflam,1);

MaksTelMatrMin{2}=matr;
MaksTelMatrMin{3}=raysOut;

%raysOutMin=raysOut;

end