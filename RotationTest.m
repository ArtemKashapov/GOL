close all; clear all; clc;

vector=[0; 0; 1];

angles=linspace(0,360,100);

rotatedVectors=zeros(3,length(angles));

for i=1:length(angles)
    rotatedVectors(:,i)=rotx(angles(i))*vector;
end

figure(1)
hold on
plot3(rotatedVectors(1,:),rotatedVectors(2,:),rotatedVectors(3,:));
axis equal;
%orginal vector is
plot3([0 0],[0 0],[0 vector(3)],'r');
grid on;
hold off;