function  ResultsDisplayInit( parent )
%RESULTSDISPLAYINIT Summary of this function goes here
%   Detailed explanation goes here
GlobalSet('ResultsTabPannel',uitabgroup(parent,'Position',[0.01 0.01 0.99 0.99]));
initScemeDisplay();
GlobalSet('SpotsResutsPannel',uitab(GlobalGet('ResultsTabPannel'),'Title','Spot diagramm'));
GlobalSet('IlluninationResutsPannel',uitab(GlobalGet('ResultsTabPannel'),'Title','Illumination'));
end

function initScemeDisplay()
  
    GlobalSet('TracingResutsPannel',uitab(GlobalGet('ResultsTabPannel'),'Title','Tracing'))
    GlobalSet('TracingResutsAxis',axes('parent', GlobalGet('TracingResutsPannel')));
    GlobalSet('TracingResutsPlot',subplot(1,1, 1, 'Parent', GlobalGet('TracingResutsPannel')));
   
    set(GlobalGet('TracingResutsAxis'), 'XGrid','on');
    set(GlobalGet('TracingResutsAxis'), 'YGrid','on');
    set(GlobalGet('TracingResutsAxis'), 'ZGrid','on');
    rotate3d(GlobalGet('TracingResutsAxis'),'on')
    
%     view(GlobalGet('TracingResutsAxis'),[30 90]);
end



function drawOpticalElements()

end