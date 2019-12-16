function width=widthMinInd(pMinInd)
global minInd;
%global mtpMinInd;
% we store in in this the structure in order not to generate it every time
% MaksTelMatrMin{1} - schema, MaksTelMatrMin{2} - matrix of that scheme. MaksTelMatrMin{3} - what is used to be called raysOutMin
%  widthMaksTelPar(MaksTelPar,nrays,delta)
 if (l=length(pMinInd))!=length(minInd)
  width=100; 
  printf('In widthMinInd, length(pMinInd)=%d!=length(minInd)=%d\n',length(pMinInd),length(minInd)); 
  return; 
 end
 width=widthMaksTelPar(fillMinInd(pMinInd),30,5);
end

# [x2,obj2,info2,iter2,nf2,lambda2]=sqp([148.00   134.33  -200.00],@widthMinInd,[],@ineqMinInd,lb679,ub679);
