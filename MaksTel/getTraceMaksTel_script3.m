% maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec
schema3=getMaksTel(45,-362.8,-100,-108.9,14.3,145,-200,11.6,-200);
%fprintf('Vynos teleskopa %.3f mm\n',b3);

raysIn=paraxialSpotHom([0 0 -400],[10 45],20);
[ raysIn,~,raysOut3 ] = traceThroughSystem(raysIn, schema3);

raysOutMin=raysOut3;
