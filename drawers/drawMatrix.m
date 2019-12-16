function fig_handler = drawMatrix( x,label_x,y,label_y,z,dimension)
%DRAWMATRIX Summary of this function goes here
%   Detailed explanation goes here

fig_handler=figure('Units', 'centimeters', 'pos',  [0 0 dimension(1) dimension(2)]);
set(fig_handler,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(fig_handler,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman');
% plot(x/pi*180,y,'k','LineSmooth','on','LineWidth',1.5);
imagesc(x,y,z);
colormap jet;
colorbar
grid on;
axis equal;
 
xlim([min(x) max(x)]);
ylim([min(y) max(y)]);
% dots2ticks();
xlabel(label_x);
ylabel(label_y);
% plot2svg('pictures/directiondiag.svg')
end

