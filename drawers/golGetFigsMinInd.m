function [schema,raysOut,width,zf]=golGetFigsMinInd(pMinInd,nrays,detSize,Npix,matlab,str) % it fills MaksTelMatrMin array
 [schema,raysOut]=getTraceMinInd(pMinInd,nrays);
% function [width,zf]=widthMaksTelPar(MaksTelPar,nrays,delta)
 [width,zf]=widthMaksTelPar(fillMinInd(pMinInd),nrays,10); % 10 is delta
 golGetFigs(raysOut,zf,detSize,Npix,matlab,str); 
% function golGetFigs(raysOut,detPos,detSize,Npix,matlab,str)
end

% fminbnd usage:
% [zmin,fval,info,output]=fminbnd(@optWidthGlobal,-40,-20)

% [sn679,rO679,wn679,zf679]=golGetFigsMinInd(xn679,30,2,300,false,'nbm')