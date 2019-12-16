schema=getMaksTel(45,-435,-150,-300,20,200,-200,10,-200);
% getMaksTel(maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec)
% fprintf('Vynos teleskopa %.3f mm\n',b);

raysIn=paraxialSpotHom([0 0 -400],[10 45],20);
[ raysIn,raysMiddle,raysOut ] = traceThroughSystem(raysIn, schema);

raysOutMin=raysOut;
