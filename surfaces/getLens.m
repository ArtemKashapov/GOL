%% Возврашает структуру описывающую линзу

%% aperture - значение диаметра входной апертуры

%% tickness - толщина линзы 

%% r_1 и r_2 определяют первую и вторую поверхности линзы. 

%% что бы опредилить сферическую поверхность, небходимо передать только радиус, т.е.:
%% length(r_1) или length(r_2) = 1

%% что бы опредилить параболическую поверхность, небходимо передать два параметра, определяющих параболу, т.е.:
%% length(r_1) или length(r_2) = 2

%% что бы опредилить сферическую поверхность, небходимо передать три длины полуосей, т.е.:
%% length(r_1) или length(r_2) = 3

%% Поверхности можно комбинировать. 


function [ lens ] = getLens(varargin)
% aperture,tickness,r_1,r_2 
%GETLENS Summary of this function goes here
%   Detailed explanation goes here

if isempty(varargin)
     lens = initDefaultLens(25, 5,100,-100,2);
end

if length(varargin)==1
     lens = initDefaultLens(varargin{1}, 5,100,-100);
end

if length(varargin)==2
     lens = initDefaultLens(varargin{1}, varargin{2},100,-100,2);
end


if length(varargin)==3
     lens = initDefaultLens(varargin{1}, varargin{2},varargin{3},varargin{3},2);
end


if length(varargin)==4
     lens = initDefaultLens(varargin{1}, varargin{2},varargin{3},varargin{4},2);
end

if length(varargin)==5
     lens = initDefaultLens(varargin{1}, varargin{2},varargin{3},varargin{4},2);
     
     if ischar(varargin{5})
             rI=Materials(varargin{5});
             lens.materialDispersion=@(lam)(dispersionLaw(lam, rI.refractionIndexData));
             lens.material=rI;
    % lens=struct('frontSurface',front_surf,'backSurface',back_surf,'tickness',tickness,'aperture',aperture,'material',...
    %                 rI,'materialDispersion',@(lam)(dispersionLaw(lam, rI.refractionIndexData)),'type','lens');
     else
        disp('Incorrect material definition. Default material will be applied')
     end
 

end

if length(varargin)==6
     lens = initDefaultLens(varargin{1}, varargin{2},varargin{3},varargin{4},varargin{6});
     
     if ischar(varargin{5})
             rI=Materials(varargin{5});
             lens.materialDispersion=@(lam)(dispersionLaw(lam, rI.refractionIndexData));
             lens.material=rI;
    % lens=struct('frontSurface',front_surf,'backSurface',back_surf,'tickness',tickness,'aperture',aperture,'material',...
    %                 rI,'materialDispersion',@(lam)(dispersionLaw(lam, rI.refractionIndexData)),'type','lens');
     else
        disp('Incorrect material definition. Default material will be applied')
     end
 

end



end

function lens = initDefaultLens(aperture, tickness,r_1,r_2, appType)

if length(aperture)==1
    front_surf = flatQuad( [0 aperture 0], appType,[0 0 0],[0 0 0]);
elseif length(aperture)==2
    front_surf = flatQuad( [aperture(1) aperture(2) 0], appType,[0 0 0],[0 0 0]);
elseif length(aperture)==3
    front_surf = flatQuad( [aperture(1) aperture(2) aperture(3)], appType,[0 0 0],[0 0 0]);
end

if length(r_1)==1
    front_surf = convertQuad2Sphere(front_surf,r_1);
end
if length(r_1)==2
    front_surf = convertQuad2Paraboloid(front_surf,r_1(1),r_1(2));
end
if length(r_1)==3
    front_surf = convertQuad2Ellipsoid( front_surf,r_1(1),r_1(2),r_1(3));
end


% back_surf  = flatQuad( [0 aperture 0], 2,[0 0 0],[0 0 tickness]);
if length(aperture)==1
    back_surf = flatQuad( [0 aperture 0], appType,[0 0 0],[0 0 0]);
elseif length(aperture)==2
    back_surf = flatQuad( [aperture(1) aperture(2) 0], appType,[0 0 0],[0 0 0]);
elseif length(aperture)==3
    back_surf = flatQuad( [aperture(1) aperture(2) aperture(3)], appType,[0 0 0],[0 0 0]);
end



if length(r_2)==1
   back_surf  = convertQuad2Sphere(back_surf,r_2);
end
if length(r_2)==2
   back_surf  = convertQuad2Paraboloid(back_surf,r_2(1),r_2(2));
end
if length(r_2)==3
   back_surf = convertQuad2Ellipsoid( back_surf,r_2(1),r_2(2),r_2(3));
end

rI=Materials('silica');
lens=struct('frontSurface',front_surf,'backSurface',back_surf,'tickness',tickness,'apertureData',aperture,'apertureType',appType,'material',...
                rI,'materialDispersion',@(lam)(dispersionLaw(lam, rI.refractionIndexData)),'type','lens');
end
function n = dispersionLaw(lam, Ndata)

n    =    sqrt(1  +    Ndata(1)*lam.^2./(lam.^2-Ndata(2)^2)...
                      +    Ndata(3)*lam.^2./(lam.^2-Ndata(4)^2)+...
                            Ndata(5)*lam.^2./(lam.^2-Ndata(6)^2));

end

