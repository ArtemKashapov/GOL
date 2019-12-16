function retval=ineqMinInd(pMinInd)
global minInd;
if length(minInd)!=length(pMinInd)
 printf('In ineqMinInd, length(pMinInd)=%d!=length(minInd)=%d\n',length(pMinInd),length(minInd));
 retval=-100; 
 return; 
end
mtp=fillMinInd(pMinInd);
retval=ineqMTP(mtp);
end