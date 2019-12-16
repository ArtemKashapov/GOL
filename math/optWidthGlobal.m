function [width,frac] = optWidthGlobal(z)
global MaksTelMatrMin;
detSize=50;
%printf('Length of raysOutMin=%d\n',length(raysOutMin));
[width,frac]=optWidth(MaksTelMatrMin{3},z,detSize);
end