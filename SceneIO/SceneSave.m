function  SceneSave( path2file, varargin )
%SCENESAVE Summary of this function goes here
%   Detailed explanation goes here

fid = fopen(path2file, 'w');     % открытие файла на запись 

if isempty(varargin)
    
Elements = GlobalGet('ElementsList');

ElementsSequense = GlobalGet('ElementsSequence');
    
elseif length(varargin)==1

Elements = varargin{1};

ElementsSequense = 1:length(varargin{1});

elseif length(varargin)==2
    
Elements = varargin{1};

ElementsSequense = varargin{1};

end

str=num2str(ElementsSequense(1));

for i=2:length(ElementsSequense)
    str=[str,' ',num2str(ElementsSequense(i))];
end

fprintf(fid,'%s\n',['Sequense ',str]);

for k=1:length(Elements)
         writeStruct(Elements{k},'',fid);
end
fclose('all'); 
end

function writeStruct(data,parentName,fileID)

dataFields=fields(data);%верно

format='%10.5f';

    fprintf(fileID,'%s\n',['Struct ',parentName,'{']);
% if isfield(data,'type')
%     fprintf(fileID,'%s\n',[parentName,'Struct ',data.type,' {']);
% else
%     fprintf(fileID,'%s\n',[parentName,'Struct {']);
% end


for i=1:length(dataFields)

    fieldData=getfield(data,dataFields{i});
    if isstruct(fieldData)
        writeStruct(fieldData,[dataFields{i}, ' '],fileID)
    else
         str = perpareField(dataFields{i},fieldData,format);
         fprintf(fileID,'%s\n',str);
    end
end
fprintf(fileID,'%s\n','}');
end

function fieldAsString = perpareField(fieldName,fieldData,format)
    fieldAsString=[];
    if strcmp(class(fieldData),'char')
          fieldAsString=[fieldName,' ','char',' ',fieldData]; 
    elseif strcmp(class(fieldData),'double')
           fieldAsString=[fieldName,' ','double',' ',num2str(size(fieldData,1)),' ',num2str(size(fieldData,2))]; 
           for i=1:size(fieldData,1)
               for j=1:size(fieldData,2)
               fieldAsString=[fieldAsString,' ', num2str(fieldData(i,j),format)];
               end
           end
    end
%     fprintf(fid,'%s\n',stringa);
end




