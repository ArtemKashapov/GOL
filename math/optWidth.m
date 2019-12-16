function [width,frac] = optWidth(rays_arg,z,detsize)
LIMIT_FRAC=0.5;
%detector=flatQuad(detsize,detsize,[0 0 0],[0 0 z]);
detector=flatQuad([detsize,detsize,0],1,[0 0 0],[0 0 z]);
rays=quadIntersect(detector,rays_arg);
% flatQuad(detSize,detSize,[0 0 0],[0 0 detPos]);
[ x,y,colors,angleSize]=spotDiagram(detector,rays);
lx=length(x);
ly=length(y);
frac=lx/length(rays);
if frac>=LIMIT_FRAC
 xc=sum(x)/lx;
 yc=sum(y)/ly;
 d2=[];
 for i=1:lx
  d2=[d2;(x(i)-xc)^2+(y(i)-yc)^2];  
 end
 if frac>=1
  width=sqrt(median(d2));
 else
  width=(sqrt(median(d2))-detsize/2)*(frac-LIMIT_FRAC)/(1-LIMIT_FRAC)+detsize/2;
% This is linear interpolation between two points: frac=LIMIT_FRAC, width=detsize/2 and frac=1, width=sqrt(median(d2))
 end
else
 width=detsize/2;
end
end % function
