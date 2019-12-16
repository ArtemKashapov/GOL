function width=width5679(p5679)
global mtp5679;
% we store in in this the structure in order not to generate it every time
% MaksTelMatrMin{1} - schema, MaksTelMatrMin{2} - matrix of that scheme. MaksTelMatrMin{3} - what is used to be called raysOutMin
%  widthMaksTelPar(MaksTelPar,nrays,delta)
 mtp=[mtp5679(1),mtp5679(2),mtp5679(3),mtp5679(4),p5679(1),p5679(2),p5679(3),mtp5679(8),p5679(4)];
 width=widthMaksTelPar(mtp,30,10);
end