function  drawRays(fig_handler, rays )
%DRAWRAYS Summary of this function goes here
%   Detailed explanation goes here
set(fig_handler,'DefaultAxesFontSize',14,'DefaultAxesFontName','Times New Roman');
set(fig_handler,'DefaultTextFontSize',14,'DefaultTextFontName','Times New Roman');

if strcmp(version('-release'),'2015b')
    drawRaysIn2015b(rays)
else
    drawRaysInOlderVersions(rays)
end
    xlabel('x, [mm]');ylabel('y, [mm]');zlabel('z, [mm]');
    grid on;
    axis equal;
end
function drawRaysIn2015b(rays)
    if isstruct(rays)
         hold on;
       if length(rays)>=1024
             for i=1:1024%createIndexes(length(rays))
                idx=1+randi(length(rays)-1);
                r_start=rays(idx).r0;
                r_end=rays(idx).r0+rays(i).e*(rays(idx).tEnd-rays(idx).tStart);
                plot3([r_start(1) r_end(1)],...
                      [r_start(2) r_end(2)],...
                      [r_start(3) r_end(3)],'Color',rays(idx).color,'LineWidth',1.2);
            end
       else
             for i=1:length(rays)%createIndexes(length(rays))
                idx=1+randi(length(rays)-1);
                r_start=rays(idx).r0;
                r_end=rays(idx).r0+rays(i).e*(rays(idx).tEnd-rays(idx).tStart);
                plot3([r_start(1) r_end(1)],...
                          [r_start(2) r_end(2)],...
                          [r_start(3) r_end(3)],'Color',rays(idx).color,'LineWidth',1.2);
             end
      end
        hold off;
    else
        hold on;
       if length(rays)>=250
           
        for i=1:250%createIndexes(length(rays))
            idx=1+randi(length(rays)-1);
            r_start=rays(idx,1:3);
            r_end=rays(idx,1:3)+rays(idx,4:6)*(rays(idx,8)-rays(i,7));
            plot3( [r_start(1) r_end(1)],...
                      [r_start(2) r_end(2)],...
                      [r_start(3) r_end(3)],'Color',rays(idx,11:13),'LineWidth',1.2);
        end
           
        
       else
           
        for i=1:length(rays)%createIndexes(length(rays))
            idx=1+randi(length(rays)-1);
            r_start=rays(idx,1:3);
            r_end=rays(idx,1:3)+rays(idx,4:6)*(rays(idx,8)-rays(i,7));
            plot3([r_start(1) r_end(1)],...
                  [r_start(2) r_end(2)],...
                  [r_start(3) r_end(3)],'Color',rays(idx,11:13),'LineWidth',1.2);
        end
           
       end
        hold off;
    end
end
function drawRaysInOlderVersions(rays)
    if isstruct(rays)
         hold on;
        for i=createIndexes(length(rays))
            r_start=rays(i).r0;
            r_end=rays(i).r0+rays(i).e*(rays(i).tEnd-rays(i).tStart);
            plot3(  [r_start(1) r_end(1)],...
                      [r_start(2) r_end(2)],...
                      [r_start(3) r_end(3)],'Color',rays(i).color,'LineWidth',1.2,'LineSmooth','on');
        end
        hold off;
    else
        hold on;
        if length(rays)>250
              for i=createIndexes(size((rays),1))
                        r_start=rays(i,1:3);
                        r_end=rays(i,1:3)+rays(i,4:6)*(rays(i,8)-rays(i,7));
                        plot3([r_start(1) r_end(1)],...
                              [r_start(2) r_end(2)],...
                              [r_start(3) r_end(3)],'Color',rays(i,11:13),'LineWidth',1.2,'LineSmooth','on');
              end
        else
                    for i=1:size(rays,1)
                        r_start=rays(i,1:3);
                        r_end=rays(i,1:3)+rays(i,4:6)*(rays(i,8)-rays(i,7));
                        plot3([r_start(1) r_end(1)],...
                                  [r_start(2) r_end(2)],...
                                  [r_start(3) r_end(3)],'Color',rays(i,11:13),'LineWidth',1.2,'LineSmooth','on');
                    end
        end
        hold off;
    end
    
end
function idx=createIndexes(N)
    if N>=1024
        stp=floor(N/1024);
        idx=1:stp:N;      
    else
        idx=1:N;    
    end
end
