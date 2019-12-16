function  displayUpdate( display2update )
%DISPLATUPDATE Summary of this function goes here
%   Detailed explanation goes here
% cla(GlobalGet('TracingResutsAxis'),'data');
delete(get(GlobalGet('TracingResutsAxis'),'children'));
        if display2update==1
             hold(GlobalGet('TracingResutsAxis'),'on');
             DrawElements(GlobalGet('ElementsList'),GlobalGet('TracingResutsAxis'));
             hold(GlobalGet('TracingResutsAxis'),'off');
        elseif display2update==2

        elseif display2update==3

        end
end

