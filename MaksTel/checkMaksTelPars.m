function same=checkMaksTelPars(mtp,mts)
% This function returns true if the paratemets of Maksutov telescope are the same as supplied and false if they are not the same  
% mtp - Maksutov telescope parameters
% mts - Maksutov telescope Scheme
same=0;
if isempty(mts) || isempty(mtp) || length(mts)!=3
 same=0;
 return; 
end
eps=1e-5;
menisc=mts{1};
mm=mts{2};
sm=mts{3}; 
% maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec
if (menisc.frontSurface.apertureData(2)==mtp(1) && mm.extraData.R==mtp(2) && 
   menisc.frontSurface.extraData.R==mtp(3) && menisc.backSurface.extraData.R==mtp(4) &&
   abs(norm(menisc.frontSurface.position-menisc.backSurface.position)-mtp(5))<eps &&
   abs(menisc.backSurface.position(3)-mm.position(3)+mtp(6))<eps && 
   abs(sm.extraData.aperture-mtp(8))<0.1) 
% We don't care too much if thesecondary aperture radii are a little bit different
% That's why we check the secondary aperture radius difference by 0.1 mm
% Now we have to deal with argdistsec and argrsec
 if mtp(7)>0
  if mtp(7)==-sm.position(3) && mtp(9)==sm.extraData.R
   same=1;
   return; 
  else
   same=0;
   return;
  endif
 else
  if sm.position(3)==menisc.backSurface.position(3) && sm.extraData.R==menisc.backSurface.extraData.R
   same=1;
   return;
  else
   same=0;
   return;
  end
 end
end 
end
