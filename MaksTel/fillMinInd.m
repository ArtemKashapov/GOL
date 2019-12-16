function mtp=fillMinInd(pMinInd)
global minInd;
global mtpMinInd; 
global mtpsize;
indp=0;
if (l=length(pMinInd))!=length(minInd)
 mtp(1:9)=0; 
 printf('In fillMinInd, length(pMinInd)=%d!=length(minInd)=%d\n',length(pMinInd),length(minInd)); 
 return; 
end
for i=1:l
 ind=minInd(i);
 if ind-indp>1
%  for indj=indp+1:ind-1
   mtp(indp+1:ind-1)=mtpMinInd(indp+1:ind-1); 
%  end
 end
 mtp(ind)=pMinInd(i);
 indp=ind;
end
if indp<mtpsize
 mtp(indp+1:mtpsize)=mtpMinInd(indp+1:mtpsize);
end  
end