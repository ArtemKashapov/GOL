function  GlobalSet(dataKey, data)
%GLOBALSET Summary of this function goes here
%   Detailed explanation goes here
if ~ischar(dataKey)
 disp('Wrong key type')
 return;
end
    global ElementsSet;
    
    if isempty(ElementsSet)
        ElementsSet = containers.Map('KeyType','char','ValueType','any');
    end
%     if ElementsSet.isKey(dataKey)
%          disp('The key you trying to insert is allready inserted');
%          return;
%     end
    ElementsSet(dataKey)=data;
%     disp(ElementsSet);
end

