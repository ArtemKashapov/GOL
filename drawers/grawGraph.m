function fig_handler = grawGraph( x,label_x,y,label_y,dimension)
%GRAWGRAPH Summary of this function goes here
%   Detailed explanation goes here
fig_handler=figure('Units', 'centimeters', 'pos',  [0 0 dimension(1) dimension(2)]);
set(fig_handler,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
set(fig_handler,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman');
plot(x,y,'k','LineSmooth','on','LineWidth',1.5);
grid on;
xlim([min(x) max(x)]);
ylim([min(y) max(y)]);
dots2ticks();
xlabel(label_x);
ylabel(label_y);

end

