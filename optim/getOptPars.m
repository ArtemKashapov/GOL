function [fullpars]=getOptPars(schema)
l=length(schema);
fullpars=[];
for i=1:schema
 el=schema{i};
 if strcmp(el.type,'lens')
  addlength=2+length(el.frontSurface.extraData.R)+length(el.backSurface.extraData.R); % aperture, thickness and then curvature radii - first front, then back
%  fullpars(end+1)=el.aperture;
%  fullpars(end+1)
  fullpars(end+1:end+1+addlength)=[el.aperture,abs(el.frontSurface.position(3)-el.backSurface.position(3)),el.frontSurface.R,el.backSurface.R];
 elseif strcmp(el.type,'surface')
  if endWith(el.extraDataType,'mirror')
   addlength=1+length(el.extraData.R);
   fullpars(end+1:end+1+addlength)=[el.extraData.aperture,el.extraData.R];
  elseif ~isempty(el.extraDataType) && ~endWith(el.extraDataType,'DG') 
   printf('In getOprPars, unknown surface type\n');
  end
 else
  printf('In getOptPars: Unknown element number %d in input list of arguments',i)
 end
end
end