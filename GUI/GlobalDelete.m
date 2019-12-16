function  GlobalDelete( dataKey )
%GLOBALDELETE Summary of this function goes here
%   Detailed explanation goes here
    if ~ischar(dataKey)
     disp('Wrong key type')
     return;
    end
    global ElementsSet;
    if ElementsSet.isKey(dataKey)
        remove(ElementsSet,dataKey);
    else
     disp('No such key found');    
    end
end

