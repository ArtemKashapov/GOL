function isin=isInside(pos,q) % q is quad
isin=false;
if q.apertureType==1 % Then, we have rectangular aperture
 if length(q.apertureData)==3
  L2=q.apertureData(1)/2;
  H2=q.apertureData(2)/2;
  d=q.apertureData(3);
  if d==0 
   isin=(pos(1)<=L2 && pos(1)>=-L2 && pos(2) >=-H2 && pos(2)<=H2);
   return;
  else
   isin=(isInRect(pos,[-L2,-H2,-L2+d,H2]) || isInRect(pos,[-L2+d,H2-d,L2-d,H2]) || isInRect(pos,[L2-d,-H2,L2,H2]) || isInRect(pos,[-L2+d,-H2,L2-d,-H2+d]));
   return;
  end
 else
  printf('Gol error: in isInside, length(q.apertureData)=%d, should be 2 or 3\n',length(q.apertureData));
  return;
 end
elseif q.apertureType==2 % circular
 r=sqrt(pos(1)^2+pos(2)^2);
 if r>=q.apertureData(1) && r<=q.apertureData(2)
  isin=true;
 end
else % error
 printf('Gol error: in isInside, wrong aperture type=%d\n',q.apertureType);
end
end
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
function isornot=isInRect(pos,bounds)
    isornot=(pos(1)<=bounds(3)&&pos(1)>=bounds(1)&&...
             pos(2)<=bounds(4)&&pos(2)>=bounds(2) );
end
