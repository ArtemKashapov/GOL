function EditElementGUI(  Element )
%EDITELEMENTGUI Summary of this function goes here
%   Detailed explanation goes here
%Сделать так, чо бы при выборе типа поверхности менялось GUI и поля 
%тоже самое для апертуры
s_size=GlobalGet('Screensize');

% L=300;
% 
% padding=10;


if strcmp(Element.type,'lens')
    
%     fig_handler=figure('Units', 'pixels', 'pos',[s_size(3)/2-300 s_size(4)/2-350 600 700],'MenuBar','None','NumberTitle','Off');

     fig_handler=GlobalGet('TableCellEditForm');


    set(fig_handler,'pos',[s_size(3)/2-300 s_size(4)/2-350 600 700]);
    
    
    set(fig_handler,'MenuBar','None');
    
    set(fig_handler,'NumberTitle','Off');
    
    GlobalSet('TableCellEditForm',fig_handler);

    surf_0_handler = uipanel(fig_handler,'Position',[0.0 0.95 1 0.095],'Title','Lens material');
 
    
%     get(surf_0_handler)
    pm = uicontrol('parent',surf_0_handler,'Style','popupmenu',...
                   'String',keys(GlobalGet('GlassLibKeys')),...
                   'Value',1,'Position',[0 18 595 10]);

    
    
    surf_1_handler = uipanel(fig_handler,'Position',[0.0 0.1 0.5 0.85]);
    
    surf_2_handler = uipanel(fig_handler,'Position',[0.50  0.1 0.5 0.85]);

    set(surf_1_handler,'Title','Front lens surface data');

    set(surf_2_handler,'Title','Back lens surface data');


    set(fig_handler,'Name',['Element ',num2str(GlobalGet('ActiveTableRow')),' properties edit']);    

    expandSurfData2GUI(surf_1_handler,Element.frontSurface);

    expandSurfData2GUI(surf_2_handler,Element.backSurface);


else
    
    fig_handler=GlobalGet('TableCellEditForm');
    
    set(fig_handler,'pos',[s_size(3)/2-150 s_size(4)/2-350 300 700])
   
    surf_1_handler = uipanel(fig_handler,'Position',[0 0 1 0.999]);

    set(surf_1_handler,'Title','Surface data');

    set(fig_handler,'Name',['Element ',num2str(GlobalGet('ActiveTableRow')),' properties edit']);    

    expandSurfData2GUI(surf_1_handler,Element);

end

end

function expandSurfData2GUI(handlerUI,surfData)

% hpos = get(handlerUI,'Position')
fieldHeight=0.08;
startHeight=1;
surfTypePannel = uipanel(handlerUI,'Position',[0.0  startHeight-fieldHeight 1 fieldHeight],'Title','Suface type');

surfType = uicontrol('parent',surfTypePannel,'Style','popupmenu',...
                    'String',keys(GlobalGet('GeometricSurfaceTypes')),...
                    'Value',1,'Units','Normalized','Position',[0 0 1 1]);
              
positionPannel = uipanel(handlerUI,'Position',[0.0  startHeight-2*fieldHeight 1 fieldHeight],'Title','Suface position');
[textFields,~] = initFields(surfData.position,{' X, [mm]',' Y, [mm]',' Z, [mm]'},positionPannel);
GlobalSet('ElementPositionX',textFields(1));
GlobalSet('ElementPositionY',textFields(2));
GlobalSet('ElementPositionZ',textFields(3));

orientationPannel = uipanel(handlerUI,'Position',[0.0  startHeight-3*fieldHeight 1 fieldHeight],'Title','Suface orientation');
[textFields,~] = initFields(surfData.angles,{'A, [grad]','B, [grad]','C, [grad]'},orientationPannel);
GlobalSet('ElementAngleX',textFields(1));
GlobalSet('ElementAngleY',textFields(2));
GlobalSet('ElementAngleZ',textFields(3));

aperturePannel = uipanel(handlerUI,'Position',[0.0  startHeight-4*fieldHeight 1 fieldHeight],'Title','Suface aperture');
% [textFields,~] = initFields([surfData.L surfData.H],{'L, [mm]','W, [mm]',containers.Map({'Circular','Ring','Square','SquareRing'},....
%                                                                                         {'Circular','Ring','Square','SquareRing'})},aperturePannel);
% GlobalSet('ElementL',textFields(1));
% GlobalSet('ElementW',textFields(2));

ExtraDataPannel = uipanel(handlerUI,'Position',[0 0  startHeight-5*fieldHeight 1 startHeight-5*fieldHeight],'Title',[surfData.extraDataType,' extra data']);
% s = uicontrol(ExtraDataPannel,'Style','slider','Min',0,'Max',1,'Value',1,...
%                 'SliderStep',[0.05 0.2],'Position',[274 0 20 296]);

if isstruct(surfData.extraData)
dataFiels = fieldnames(surfData.extraData);            
else
dataFiels = '';            
end

% getfield(surfData.extraDataType,dataFiels(i));
 surfaceRepresentInGUI(ExtraDataPannel, surfData)
% EtraDataEditableFields=GlobalGet('ExtraDataEditableFields');
% vertShift=0.0;
% for i=1:length(dataFiels)
%     if EtraDataEditableFields.isKey(dataFiels{i})
%         p = uipanel(ExtraDataPannel,'Position',[0 0.9-vertShift 1 0.1]);
%         [textFields,labelFields] = initFields(getfield(surfData.extraData,dataFiels{i}),...
%                                               EtraDataEditableFields(dataFiels{i}),...
%                                               p,0.5,290,10);
%         vertShift=vertShift+0.1;
%     end
% end
            
%             get(s)

%  mirror=struct('XYZ',xyz,'ABCD',[normal' normal'*r'],'angles',e,'position',r,...
%                   'L',L,'H',H,'TextureHeight',@()(0),'invTBN',TBN^-1,...
%                   'TBN',TBN,'TextureNormal',@()(normal'),...
%                   'extraDataType','','extraData',[],'rotationMatrix',...
%                   xRotMat(e(1)/180*pi)*yRotMat(e(2)/180*pi)*zRotMat(e(3)/180*pi)...
%                   ,'type','surface');

end


function surfaceRepresentInGUI(UIparent, surfData)
  

end


function [textFields,labelFields] = initApertureTypesGUI(Data,parentUI,postion)
end
function [textFields,labelFields] = initSurfaceTypesGUI(Data,FieldsNames,parentUI,postion)
end



function [textFields,labelFields] = initFields(Data,FieldsNames,parentUI)

if ~iscell(FieldsNames)
    text_plus_label=1;

    text_length  = 0.5*text_plus_label;

    label_length = 0.5*text_plus_label;
    
    
     labelFields =  uicontrol('parent', parentUI ,'Units','Normalized','pos',[0 0.1 label_length 0.80],'String', FieldsNames,'style','text');
     textFields  =  uicontrol('parent', parentUI ,'Units','Normalized','pos', [0+label_length 0.1 text_length 0.80],'style','edit','String',num2str(Data));
    return;
end
text_plus_label=1/length(FieldsNames);

text_length   = 0.5*text_plus_label;

label_length = 0.5*text_plus_label;

for i=1:length(FieldsNames)
    
    
    if ~strcmp(class(FieldsNames{i}),'containers.Map')
    labelFields(i) = uicontrol('parent', parentUI ,'Units','Normalized','pos',[( i-1)*(label_length + text_length) 0.1 label_length 0.8],'String', FieldsNames{i},'style','text');
    textFields(i)=  uicontrol('parent', parentUI ,'Units','Normalized','pos', [i*label_length+( i-1)*(text_length) 0.1 text_length 0.8],'style','edit','String',num2str(Data(i)));
    else
    labelFields(i) =  uicontrol('parent', parentUI ,'Units','Normalized','pos',[( i-1)*(label_length + text_length) 0.1 label_length 0.8],'String','','style','text');
    textFields(i)=  uicontrol('parent', parentUI ,'Units','Normalized','pos', [i*label_length+( i-1)*(text_length) 0.1 2*text_length 0.8],'style','popupmenu',...
                                'String',keys(FieldsNames{i}));
      
    end
    
    

end

end