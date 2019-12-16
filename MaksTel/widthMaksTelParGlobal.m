function width=widthMaksTelParGlobal(mtp)
global MaksTelMatrMin;
% we store in in this the structure in order not to generate it every time
% MaksTelMatrMin{1} - schema, MaksTelMatrMin{2} - matrix of that scheme. MaksTelMatrMin{3} - what is used to be called raysOutMin
%  widthMaksTelPar(MaksTelPar,nrays,delta)
 width=widthMaksTelPar(mtp,30,10);
end