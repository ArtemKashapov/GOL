% it returns 0.5*(fwhmx+fwhmy) in mm
function [fwhmIm]=fwhm_schema(x)
global raysOutMin;
initSize=5;
N=300;
bigN=1000;
minNormFwhm=2;
factor=3;
% fwhm_allargs(z,raysOut,size,N)
fwhmIm=fwhm_allargs(x,raysOutMin,initSize,N);
%if(fwhmx<minNormFwhm || fwhmy<minNormFwhm)
% detector=flatQuad(initSize/factor,initSize/factor,[0 0 0],[0 0 x]);
%end
end