function [ data ] = GlobalGet( dataKey)
global ElementsSet;
if ~ischar(dataKey)
 disp('Wrong key type')
 return;
end
if ElementsSet.isKey(dataKey)
    data=ElementsSet(dataKey);
else
    disp('No such key found')
    data=[];
    return;
end

end

