function   dots2ticks()

XA=get(gca,'XTickLabel');%
% size(XA)
for i=1:size(XA,1)
    z=strfind(XA(i,:),'.');
    XA(i,z)=',';
    clear z;
end

% XA(size(XA,1),:)=char(0);

set(gca,'XTickLabel',XA);

YA=get(gca,'YTickLabel');%

for i=1:size(YA,1)
    z=strfind(YA(i,:),'.');
    YA(i,z)=',';
    clear z;
end

% YA(size(YA,1),:)=char(0);

set(gca,'YTickLabel',YA);
end

