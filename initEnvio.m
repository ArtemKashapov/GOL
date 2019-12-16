function initEnvio( varargin )
%INITENVIO Summary of this function goes here
%   Detailed explanation goes here
 %% ������� �1 (��� ������� � �������� �������� ���������� �������� ��� ������� ������ ��� ���� ������ clear all, � ��� �� ����� ������ ��������)
%clear all; close all;
% How to add folder and all its subfolders to the search path:
% addpath(genpath('matlab/myfiles'))
if nargin~=0
 if varargin{1}
  opengl hardware;
  matlab=true;
 else
  matlab=false;
 end
else
 opengl hardware;
 matlab=true;
end
% opengl info
% opengl software

if matlab % this is actually a question if we have windows or Linux. But we assume that if we do have matlab, we're on Windows, and if we don't, we are on Linux
 folder_separator='\';
else
 folder_separator='/';
end


addpath(genpath(pwd));

ElementsTypes={'<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> Surface </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> Mirror </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> TransparentDG </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> ReflectiveDG </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> Lens </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> Empty </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> SpotLight </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> PointLight </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> CustomLight </TD></TR> </table></HTML>',...
               '<HTML><table border=0 width=290 bgcolor=#CCECFE><TR><TD> TestRay </TD></TR> </table></HTML>'...
               };
vals= {'none','silica','SK16','F2','air'};       

Materials={   '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> none </TD></TR> </table></HTML>',...
              '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> silica </TD></TR> </table></HTML>',...
              '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> SK16 </TD></TR> </table></HTML>',...
              '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> F2 </TD></TR> </table></HTML>',...
              '<HTML><table border=0 width=595 bgcolor=#CCECFE><TR><TD> air </TD></TR> </table></HTML>'
          };
      
      
GeometricSurfaceTypesVals={'<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Spherical </TD></TR> </table></HTML>',...
                           '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Parabaloidal </TD></TR> </table></HTML>',...
                           '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Ellipsoidal </TD></TR> </table></HTML>',...
                           '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Flat </TD></TR> </table></HTML>',...
                           '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Conus </TD></TR> </table></HTML>',...
                           '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Hyperbolic </TD></TR> </table></HTML>'
                      };
GeometricSurfaceTypesKeys = {'Spherical','Parabaloidal','Ellipsoidal','Flat','Conus','Hyperbolic'};

GlobalSet('GeometricSurfaceTypes',containers.Map(GeometricSurfaceTypesVals,GeometricSurfaceTypesKeys));

% GeometricSurfaceTypesEditableFields={{'Radius'},{'A','B'},{'A','B','C'},{},{'Raduis','Height'},{'A','B','C'}};

GlobalSet('GlassLibKeys',containers.Map(Materials,vals));

GlobalSet('ElementsTypes',ElementsTypes);

apertures={'<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Circular </TD></TR> </table></HTML>',...
           '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> Square </TD></TR> </table></HTML>',...
           '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> CircularRing </TD></TR> </table></HTML>',...
           '<HTML><table border=0 width=300 bgcolor=#CCECFE><TR><TD> SquareRing </TD></TR> </table></HTML>'
           };
GlobalSet('ApertureTypes',containers.Map({1,2,3,4},apertures));
InitMaterials();

datatTableHeaders = {'Element type', ...
                    '<html><center>Position<br /></center></html>', ...
                    '<html><center>Rotation<br /></center></html>', ...
                    '<html><center>Material<br /></center></html>', ...
                    '<html><center>Edit<br /></center></html>'};

GlobalSet('datatTableHeaders',datatTableHeaders );



%if matlab
folder=sprintf('%ssurfaces%s',folder_separator,folder_separator);

GlobalSet('CircularApertureMesh',dlmread([pwd strcat(folder,'circAperture.app')])');
GlobalSet('RectangularApertureMesh',dlmread([pwd strcat(folder,'rectAperture.app')])');
%end
%addpath([pwd strcat(folder_separator,'sources')]);
%addpath([pwd strcat(folder_separator,'surfaces')]);
%addpath([pwd strcat(folder_separator,'tracing')]);
end

