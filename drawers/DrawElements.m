function  DrawElements( Elements, varargin )
%DRAWELEMENTS Summary of this function goes here
%   Detailed explanation goes here

    if ~iscell(Elements)
        disp('Unknown data in lens drawer');
        return;
    end
    if isempty(Elements)
           disp('No lens to draw');
           return;
    end
    
if isempty(varargin)
    hndl=gca;
else
    hndl=varargin{1};
end

view(hndl,[0 0]);
axis(hndl,'vis3d');
hold(hndl,'on');
% set(hndl,'BoxStyle','full','Box','on')
    for i=1:length(Elements)
        if isempty(Elements{i})
          continue;
        end
        if strcmp(Elements{i},'Empty')
            continue;
        end
        if sum((strcmp(fieldnames(Elements{i}),'type')) )~=0
           %% Lenses
           drawSingleElement(Elements{i},hndl);
        else
             disp('Element can not be drawn ')
        end
    end
hold(hndl,'on');
end


function drawSingleElement(Element,fig)
            if strcmp(Element.type,'lens')
                  drawLens(Element,fig);
            elseif strcmp(Element.type,'surface')
                  drawQuad(Element,fig);
            else
                 disp('Element can not be drawn');
            end
end
