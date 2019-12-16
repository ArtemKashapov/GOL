function [x,obj,nlb,nub]=netMin(objfun,lb,ub,addargs,varargin)
% netMin(objfun,lb,ub,N,conFun)
% N - number of point along given dimension. If length(N)==1, then N is number of point along all dimensions  
l=length(lb);
defN=4;
xmin(1:l)=0;
valmin=100000;
if nargin==4 || nargin==5 % then we don't have constraint function
 if nargin==4 
  np(1:l)=defN;
  prodnp=defN^l;
 else
  if length(varargin{1})!=l
   printf('Wrong lenngth of 5th srgument to netMin. It must be the same length as lb and ub\n');
   np(1:l)=defN;
   prodnp=defN^l;     
  else
   np=varargin{1};
   prodnp=1;
   for i=1:l
    prodnp*=np(i);
   end
  end 
 end 
 for i=1:prodnp
  curi=i;
  for j=1:l
   n(j)=mod(curi,np(j));
   xc(j)=lb(j)+(ub(j)-lb(j))*(0.5+n(j))/np(j);
   curi/=np(j);
   curi=floor(curi); 
  end
  vc=objfun(xc,addargs);
  if(vc<valmin)
   valmin=vc;
   xmin=xc;
  end
 end
elseif nargin==6
 constfun=varargin{2};
 if length(varargin{1})!=l
  if length(varargin{1})!=1 
   printf('Wrong lenngth of 4th argument to netMin. It must be the same length as lb and ub\n');
  end 
  np(1:l)=defN;
  prodnp=defN^l;     
 else
  np=varargin{1};
  prodnp=1;
  for i=1:l
   prodnp*=np(i);
  end
 end 
 for i=0:(prodnp-1)
  curi=i;
  for j=1:l
   n(j)=mod(curi,np(j));
   xc(j)=lb(j)+(ub(j)-lb(j))*(0.5+n(j))/np(j);
   curi/=np(j);
   curi=floor(curi); 
  end
  if(constfun(xc,addargs)>0)
   vc=objfun(xc,addargs);
   if(vc<valmin)
    valmin=vc;
    xmin=xc;
   end
  end
 end
else
 printf('In netMin, wrong number of arguments=%d. netMin expects 3-5 arguments',nargin);
 xmin=0;
 valmin=1e5;
end
x=xmin;
obj=valmin;
if obj!=1e5 
 for j=1:l
  nlb(j)=max(lb(j),x(j)-(ub(j)-lb(j))/np(j));
  nub(j)=min(ub(j),x(j)+(ub(j)-lb(j))/np(j));
% new upper and lower boundaries  
 end
else
 nlb=ulb=0;
end  
end
# [x679,obj679,nlb,nub]=netMin(@widthMinInd,lb679,ub679,0,[15,15,15],@ineqMinInd);
