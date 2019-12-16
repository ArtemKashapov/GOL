schema=getMaksTel(45,-435,-150,-300,20,200,-200,10,-200);
% fprintf('Vynos teleskopa %.3f mm\n',b);

raysIn=paraxialSpotHom([0 0 -400],[10 45],30);
[ raysIn,raysMiddle,raysOut ] = traceThroughSystem(raysIn, schema);

raysOutMin=raysOut;
