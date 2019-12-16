close all; clc; clear all;
x=linspace(0,2,1000);
n=linspace(0,3,1000);
cmap=jet(length(n));
f=figure();
hold on;
for i=1:length(n)
plot(x, x.^n(i),'Color',cmap(i,:));
end
grid on;