function [ ans_ ] =  endWith(str, strend)
ans_=true;

if length(strend)>length(str)||isempty(str)||isempty(strend)
   ans_=false;
   return;
end
l=length(str):-1:1;
L=length(strend):-1:1;
    for i=1:length(strend)
        if str(l(i))==strend(L(i))
            continue;
        else
            ans_=false;
            return;
        end
    end
end



