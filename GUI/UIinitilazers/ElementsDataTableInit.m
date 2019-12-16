function  ElementsDataTableInit( parent )
%ELEMENTSDATATABLEINIT Summary of this function goes here
%   Detailed explanation goes here

scrsize = get( groot, 'Screensize' );

Table = uitable('Parent', parent, 'Position', [10 10 410 scrsize(4)*0.79]);

GlobalGet('datatTableHeaders')
       
set(Table,'ColumnName', GlobalGet('datatTableHeaders'));

set(Table,'ColumnFormat',{[], [], [], [],[] })

set(Table,'ColumnWidth', {'auto', 'auto', 'auto', 'auto','auto'});

set(Table,'ColumnEditable', [false, false, false, false]);

set(Table,'CellSelectionCallback',@(s,e)CellSelectionCallback(s,e));

GlobalSet('ElementsDataTable',Table);

end

 

function CellSelectionCallback(sender, event)

if numel(event.Indices)==0
    return
end

data = get(sender,'Data');
ActiveTableRow=GlobalGet('ActiveTableRow');

   for i=1:5
            element=data{ActiveTableRow,i};
            k = strfind(element,'#');
            element(k:k+6)='#CCECFE';
            data{ActiveTableRow,i}=element;
        
            element=data{event.Indices(1),i};
            k = strfind(element,'#');
            element(k:k+6)='#FFEA19';
            data{event.Indices(1),i}=element;
            
   end
    GlobalSet('ActiveTableRow',event.Indices(1)); 
    ElementFieldEditForm(event.Indices(2));
    set(sender,'Data',data);
end


 
