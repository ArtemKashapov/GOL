function [ ans_ ] =  startWith(str, strend)
ans_=true;

if length(strend)>length(str)||isempty(str)||isempty(strend)
   ans_=false;
   return;
end

% L = 1:length(strend);%:-1:1;
    for i=1:length(strend)
        if str(i)==strend(i)
            continue;
        else
            ans_=false;
            return;
        end
    end
end



