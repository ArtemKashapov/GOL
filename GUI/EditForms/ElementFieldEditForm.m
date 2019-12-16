function ElementFieldEditForm(type)

EL=GlobalGet('ElementsList');

EL=EL{GlobalGet('ActiveTableRow')};

if strcmp (EL,'Empty')&&type~=1
    return;
end

padding=10;



% if ~isempty(GlobalGet('TableCellEditForm'))
%     close(GlobalGet('TableCellEditForm'));
%     GlobalDelete('TableCellEditForm')
% end
aspect=0.6;

[textFields,labelFields] = initEditForm(EL,type,aspect,padding);

end

function acceptPositionButtonCallBack(s,e)
pos_X = (get(GlobalGet('ElementPositionX'),'String')); 
pos_Y = (get(GlobalGet('ElementPositionY'),'String')); 
pos_Z = (get(GlobalGet('ElementPositionZ'),'String')); 

row=GlobalGet('ActiveTableRow');
Scema = GlobalGet('ElementsList');
    
    data = get(GlobalGet('ElementsDataTable'),'Data');
    
%     if  strcmp(event.PreviousData,data{event.Indices(1),event.Indices(2)})
%         return;
%     end
         d=[pos_X,' ',pos_Y,' ',pos_Z];
         data{row,2}= ['<HTML><table border=0 width=400 bgcolor=#FFEA19><TR><TD> ',d,' </TD></TR> </table></HTML>'];
         set(GlobalGet('ElementsDataTable'),'Data',data);
         
         d=str2num(d);
         if strcmp( Scema{row}.type,'lens')
             Scema{row}=moveLens(Scema{row}, d);
         else
             Scema{row}= moveQuad(Scema{row},d);
         end

  GlobalSet('ElementsList',Scema);
  displayUpdate(1);   
  GlobalDelete('ElementPositionX'); 
  GlobalDelete('ElementPositionY'); 
  GlobalDelete('ElementPositionZ'); 
  close(get(get(s,'parent'),'parent'));
end

function acceptOrientationButtonCallBack(s,e)
    
pos_X = (get(GlobalGet('ElementAngleX'),'String')); 
pos_Y = (get(GlobalGet('ElementAngleY'),'String')); 
pos_Z = (get(GlobalGet('ElementAngleZ'),'String')); 

row=GlobalGet('ActiveTableRow');
Scema = GlobalGet('ElementsList');
    
    data = get(GlobalGet('ElementsDataTable'),'Data');
    
%     if  strcmp(event.PreviousData,data{event.Indices(1),event.Indices(2)})
%         return;
%     end
         d=[pos_X,' ',pos_Y,' ',pos_Z];
         data{row,3}= ['<HTML><table border=0 width=400 bgcolor=#FFEA19><TR><TD> ',d,' </TD></TR> </table></HTML>'];
         set(GlobalGet('ElementsDataTable'),'Data',data);
         
         d=str2num(d);
         
         if strcmp( Scema{row}.type,'lens')
             Scema{row}=rotateLens(Scema{row}, d);
         else
             Scema{row}= rotateQuad(Scema{row},d);
         end

  GlobalSet('ElementsList',Scema);
  displayUpdate(1);   
  GlobalDelete('ElementAngleX'); 
  GlobalDelete('ElementAngleY'); 
  GlobalDelete('ElementAngleZ'); 
  close(get(get(s,'parent'),'parent'));
end

function acceptTypeButtonCallBack(s,e)

pm = GlobalGet('ElementTypeList'); 
type=get(pm,'String');
type = type{get(pm,'Value')};
row=GlobalGet('ActiveTableRow');
Scema = GlobalGet('ElementsList');
ElementsTypes=GlobalGet('ElementsTypes');
%  description=
        if    strcmp(type,ElementsTypes{1})
              assignTableElementDescription( row,tableRowAsHTML( [{'Surface'} {'0 0 0'} {'0 0 0'} {'none'} {'Edit'}]));
              Scema{row}=flatQuad( 10,10,[0 0 0],[0 0 0]);
             
        elseif strcmp(type,ElementsTypes{2})
               assignTableElementDescription( row,tableRowAsHTML( [{'Mirror'} {'0 0 0'} {'0 0 0'} {'none'} {'Edit'}]))
               Scema{row}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{row}.extraDataType = strcat(Scema{row}.extraDataType,'_mirror') ;
              
        elseif strcmp(type,ElementsTypes{3})
               assignTableElementDescription(row,tableRowAsHTML( [{'TransparentDG'} {'0 0 0'} {'0 0 0'} {'none'} {'Edit'}]));
               Scema{row}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{row}=convertQuad2DG( Scema{row},0.032, 1, 0, 10^10);
             
        elseif strcmp(type,ElementsTypes{4})
               assignTableElementDescription(row, tableRowAsHTML([{'ReflectiveDG'} {'0 0 0'} {'0 0 0'} {'none'} {'Edit'}]));
               Scema{row}=flatQuad( 10,10,[0 0 0],[0 0 0]);
               Scema{row}=convertQuad2DG( Scema{row},0.032, 1, 0, 10^10);
             
        elseif strcmp(type,ElementsTypes{5})
               assignTableElementDescription(row,tableRowAsHTML( [{'Lens'} {'0 0 0'} {'0 0 0'} {'silica'} {'Edit'}]));
               Scema{row}= getLens( 10, 5, 50, -50,'silica');
             
        elseif strcmp(type,ElementsTypes{6})
               assignTableElementDescription( row,tableRowAsHTML( [{'Empty'} {'-'} {'-'} {'-'} {'-'}]));
               Scema{row}='Empty';
        end
        
        
     
        GlobalSet('ElementsList',Scema);
               displayUpdate(1);   
        GlobalDelete('ElementTypeList'); 
        close(get(get(s,'parent'),'parent'));
end

function acceptMaterialButtonCallBack(s,e)

pm = GlobalGet('ElementMaterialList'); 
type = get(pm,'String');
row = GlobalGet('ActiveTableRow');
type = type{get(pm,'Value')};
data = get(GlobalGet('ElementsDataTable'),'Data');
data{row,4}=type;
set(GlobalGet('ElementsDataTable'),'Data',data);
          
Scema = GlobalGet('ElementsList');
MaterialTypes = GlobalGet('GlassLibKeys');

material=GlobalGet('GlassLib');
material=material(MaterialTypes(type));

Scema{row}.materialDispersion=@(lam)(dispersionLaw(lam, material.refractionIndexData));
Scema{row}.material=material;


GlobalSet('ElementsList',Scema);

displayUpdate(1);   
GlobalDelete('ElementMaterialList'); 
close(get(get(s,'parent'),'parent'));

end

function assignTableElementDescription(row, description)
        data=get(GlobalGet('ElementsDataTable'),'Data');
      
        if size(data,1)==0
             data = description;
             set(tableHandle,'Data',data);
        else
             data(row ,:) = description;
             set(GlobalGet('ElementsDataTable'),'Data',data);    
        end
end

function [textFields,labelFields] = initEditForm(Element,type,aspect,padding)
% aspect=0.6;
sizeX=300;

 

s_size=GlobalGet('Screensize');

textFields=[];labelFields=[];

fig_handler=figure('Units', 'pixels', 'pos',[s_size(3)/2-150 s_size(4)/2-50 sizeX 100],'MenuBar','None','NumberTitle','Off');

GlobalSet('TableCellEditForm',fig_handler);




if type==1%element type
    pannel_handler = uipanel(fig_handler,'Position',[0 0 1 1]);
    set(pannel_handler,'Title',['Element ',num2str(GlobalGet('ActiveTableRow')),' type']);
    set(get(pannel_handler,'Parent'),'Name','Type');    
    pm = uicontrol('parent',pannel_handler,'Style','popupmenu',...
                          'String',GlobalGet('ElementsTypes'),...
                          'Value',1,'Position',[0 40 290 40]);
    GlobalSet('ElementTypeList',pm);    
    acceptButton  = uicontrol('parent', pannel_handler ,'pos',[0  0 295 30],'String', 'Accept','style','pushbutton');
    set(acceptButton,'Callback',@acceptTypeButtonCallBack);
elseif type==2%element position
    pannel_handler = uipanel(fig_handler,'Position',[0 0 1 1]);
    if strcmp(Element.type,'lens')
      Element=Element.frontSurface;
    end
    set(pannel_handler,'Title',['Element ',num2str(GlobalGet('ActiveTableRow')),' XYZ coordinates']);
    set(get(pannel_handler,'Parent'),'Name','Position');
    [textFields,labelFields] = initFields(Element.position,{' X, [mm]',' Y, [mm]',' Z, [mm]'},pannel_handler,aspect,sizeX,padding);
    GlobalSet('ElementPositionX',textFields(1));
    GlobalSet('ElementPositionY',textFields(2));
    GlobalSet('ElementPositionZ',textFields(3));
    acceptButton  = uicontrol('parent', pannel_handler ,'pos',[0  0 295 30],'String', 'Accept','style','pushbutton');
    set(acceptButton,'Callback',@acceptPositionButtonCallBack);
elseif type==3%element orientation
    if strcmp(Element.type,'lens')
      Element=Element.frontSurface;
    end
    pannel_handler = uipanel(fig_handler,'Position',[0 0 1 1]);
    set(pannel_handler,'Title',['Element ',num2str(GlobalGet('ActiveTableRow')),' ABC angles']);
    set(get(pannel_handler,'Parent'),'Name','Angle');
    [textFields,labelFields] = initFields(Element.angles,{'A, [grad]','B, [grad]','C, [grad]'},pannel_handler,aspect,sizeX,padding);
    GlobalSet('ElementAngleX',textFields(1));
    GlobalSet('ElementAngleY',textFields(2));
    GlobalSet('ElementAngleZ',textFields(3));
    acceptButton  = uicontrol('parent', pannel_handler ,'pos',[0  0 295 30],'String', 'Accept','style','pushbutton');
    set(acceptButton,'Callback',@acceptOrientationButtonCallBack);
elseif type==4%element aperture
    pannel_handler = uipanel(fig_handler,'Position',[0 0 1 1]);
    set(pannel_handler,'Title',['Element ',num2str(GlobalGet('ActiveTableRow')),' type']);
    set(get(pannel_handler,'Parent'),'Name','Type');    
    pm = uicontrol('parent',pannel_handler,'Style','popupmenu',...
                   'String',keys(GlobalGet('GlassLibKeys')),...
                   'Value',1,'Position',[0 40 290 40]);
    GlobalSet('ElementMaterialList',pm);    
    acceptButton  = uicontrol('parent', pannel_handler ,'pos',[0  0 295 30],'String', 'Accept','style','pushbutton');
    set(acceptButton,'Callback',@acceptMaterialButtonCallBack);
elseif type==5%element edit form
    EditElementGUI( Element )
end

end

function [textFields,labelFields] = initFields(Data,FieldsNames,parentUI,aspect,sizeX,padding)
text_plus_label=sizeX/length(FieldsNames)-padding;

text_length   = aspect*text_plus_label;

label_length = (1-aspect)*text_plus_label;

for i=1:length(FieldsNames)
    labelFields(i) = uicontrol('parent', parentUI ,'pos',[1+ ( i-1)*(label_length + text_length+padding) 40 label_length 30],'String', FieldsNames{i},'style','text');
    textFields(i)=  uicontrol('parent', parentUI ,'pos', [1+ i*label_length + ( i-1)*(text_length+padding) 40 text_length 30],'style','edit','String',num2str(Data(i)));
end

end