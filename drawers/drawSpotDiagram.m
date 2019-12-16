function [ x_spot,y_spot,colors,angleSize] = drawSpotDiagram(fig_handler,quad_,rays)
%DRAWSPOTDIAGRAM Summary of this function goes here
%   Detailed explanation goes here
%     fig_handler=figure('Units', 'centimeters', 'pos',  [0 0 dimension(1) dimension(2)]);
%     axis vis3d 
%     set(fig_handler,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
%     set(fig_handler,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman');
   tic
    [x_spot,y_spot,colors,angleSize]=spotDiagram(quad_,rays);
    if length(x_spot)==0
     return;
    end
   toc
    hold on;
    if length(x_spot)>1500
        for i=1:2500
            idx=1+randi(length(x_spot)-1);
            plot(x_spot(idx),y_spot(idx),'.','color',colors(idx,:));
        end
    
    else
        for i=1:length(x_spot)
            plot(x_spot(i),y_spot(i),'.','color',colors(i,:));
        end
    end
%    plot([-quad_.L/2 quad_.L/2   quad_.L/2 -quad_.L/2 -quad_.L/2]+quad_.position(1),...
%           [quad_.H/2 quad_.H/2 -quad_.H/2 -quad_.H/2  quad_.H/2]+quad_.position(2),'k','LineWidth',1.5);
    if quad_.apertureType==1 % rectangular aperture
     L2=quad_.apertureData(1);
     H2=quad_.apertureData(2);
     plot([-L2 L2   L2 -L2 -L2]+quad_.position(1),...
            [H2 H2 -H2 -H2  H2]+quad_.position(2),'k','LineWidth',1.5);
     xlim([-1.1*L2 1.1*L2]+quad_.position(1));
     ylim([-1.1*H2 1.1*H2]+quad_.position(2));
    end % we don't plot the boundaries if the quad is not rectangular. To be fixed
    hold off;
    grid on;
    axis equal;
    xlabel('x, [ mm ]');
    ylabel('y, [ mm ]');
    title(sprintf('Fraction of rays depicted is %.2f',length(x_spot)/length(rays)));
end

