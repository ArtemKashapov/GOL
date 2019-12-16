clc; clear all; close all;
%%Просто волосатый эллипс(полу-эллипс). Пример определения нормали
t=linspace(0,1*pi,64);
B=1;A=2;

r_0=[0 0];
x=cos(t)*0.5*A+r_0(1); 
y=sin(t)*0.5*B+r_0(2);

figure(1)

plot(x,y,'r');
axis equal;grid on;
xlabel('x');ylabel('y');
hold on;

for i=1:length(x)
    dir=[2*(x(i)-r_0(1))/A^2, 2*(y(i)-r_0(2))/B^2];
    dir=dir/norm(dir);
    x_=[x(i) x(i)+dir(1)];
    y_=[y(i) y(i)+dir(2)];
    plot(x_,y_,'g');
end
hold off;