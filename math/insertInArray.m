function [retarr]=insertInArray(arr,x)
% This function inserts vector x in array arr.
% arr is sorted in ascending order by arr(j,1), and this function inserts x so that it remains sorted  
larr=rows(arr);
l=length(x); % we don't check if l is the second dimension of arr, but we should
i=1;
retarr=arr;
while(i<=larr)
 if x(1)<retarr(i,1)
  break; 
 end
 i++;
end
if i<=larr % then we have to insert our value into an array
 retarr=[retarr;retarr(larr,:)]; 
 for j=larr-1:-1:i
  retarr(j+1,:)=retarr(j,:);
 end
end 
retarr(i,:)=x;
end

