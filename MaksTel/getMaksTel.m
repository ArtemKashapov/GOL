% returns Maksutov telescope
function schema_makstel = getMaksTel(maprad,rmm,r1m,r2m,mthick,dist,argdistsec,secaprad,argrsec)
% origin is at the center of main mirror
%getMaksTel - returns Maksutov telescope
%  maprad - menisc aperture radius, rmm - radius of main mirror
% r1m, r2m - radii of menisc (r1m - external), 
% dist - distance between main mirror and menisc
% distsec - distance between primary mirror and secondary mirror. 
%   If zero or negative, secondary mirror is assumed to be coated inner side of menisc
% secaprad - secondary aperture radius
% rsec - radius of curvature of secondary mirror. if distsec<=0, this value is ignored and r2m is used for this purpose
% n - index of refraction of menisc glass 

if argdistsec>0
 napyl=false;
 distsec=argdistsec;
 rsec=argrsec;
else
 napyl=true;
% that would mean that secondary mirror is at the top of menisc
 distsec=dist;
 rsec=r2m;
end

lam=550/1000; % wavelength in micrometers

rI=Materials('silica');
rI2=rI;
n=dispersionLaw(lam, rI2.refractionIndexData); % let's hope it works...

menisc=getLens(maprad,mthick,r1m,r2m);
menisc=moveLens(menisc,[0 0 -dist-mthick]);

mmaprad=1.2*maprad; % instead of calculation from optic principles

mm=getMirror(mmaprad,rmm,[0 0 0],[0 0 0]);
% getMirror(aperture,r,orient,pos)

% sm is a secondary mirror
sm=getMirror(secaprad,rsec,[0 0 0],[0 0 -distsec]);

schema_makstel{1}=menisc;
schema_makstel{2}=mm;
schema_makstel{3}=sm;

% telmaks=struct(maprad,rmm,r1m,r2m,mthick,dist,distsec,secaprad,rsec,n);
%telmaks=struct('menisc',menisc,'mmirror',mm,'smirror',sm,'b',b, ...
%    'napyl',napyl,'type','MaksTel');

end
