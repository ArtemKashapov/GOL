% maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec
schema=getMaksTel(45,-362.8,-100,-108.9,14.3,150,-200,11.6,-200);
% fprintf('Vynos teleskopa %.3f mm\n',b);

raysIn=paraxialSpotHom([0 0 -400],[10 45],20);
[ raysIn,~,raysOut ] = traceThroughSystem(raysIn, schema);

raysOutMin=raysOut;
