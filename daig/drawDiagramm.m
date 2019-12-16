function fig_handler= drawDiagramm(data,maleOrFemale,smooth)
%DRAWDIAGRAMM Summary of this function goes here
%   Detailed explanation goes here

choosen=sum(data);
circ_1=[];
circ_2=[];
circ_3=[];
circ_out=[];
R_1=2;
R_2=4;
R_3=6;
phi=linspace(0,2*pi,100);
for i=1:length(choosen)
    if choosen(i)>=6
        circ_1=[circ_1 struct('number',i,'position',[0 0],'maleOrFemale',...
                                    maleOrFemale(i),'choises',find(data(i,:)),'hitPoint',[])];
    end
    if (choosen(i)<6)&&(choosen(i)>=3)
        circ_2=[circ_2 struct('number',i,'position',[0 0],'maleOrFemale',...
                                    maleOrFemale(i),'choises',find(data(i,:)),'hitPoint',[])];
    end
    if (choosen(i)<3)&&(choosen(i)>0)
        circ_3=[circ_3 struct('number',i,'position',[0 0],'maleOrFemale',...
                                    maleOrFemale(i),'choises',find(data(i,:)),'hitPoint',[])];
    end
     if choosen(i)==0
        circ_out=[circ_out struct('number',i,'position',[0 0],'maleOrFemale',...
                                    maleOrFemale(i),'choises',find(data(i,:)),'hitPoint',[])];
    end
end
phi_1=linspace(0,2*pi,length(circ_1)+1);
phi_2=linspace(0,2*pi,length(circ_2)+1);
phi_3=linspace(0,2*pi,length(circ_3)+1);
phi_4=linspace(0,2*pi,length(circ_out)+1);

for i=1:length(circ_1)
    circ_1(i).position=0.5*R_1*[cos(phi_1(i)) sin(phi_1(i))];
    circ_1(i).hitPoint=circ_1(i).position-circ_1(i).position/norm(circ_1(i).position)*0.5;
end

for i=1:length(circ_2)
    circ_2(i).position=0.5*(R_2+R_1)*[cos(phi_2(i)) sin(phi_2(i))];
    circ_2(i).hitPoint=circ_2(i).position-circ_2(i).position/norm(circ_2(i).position)*0.5;
end

for i=1:length(circ_3)
    circ_3(i).position=0.5*(R_3+R_2)*[cos(phi_3(i)) sin(phi_3(i))];
    circ_3(i).hitPoint=circ_3(i).position-circ_3(i).position/norm(circ_3(i).position)*0.5;
end

for i=1:length(circ_out)
    circ_out(i).position=1.25*R_3*[cos(phi_4(i)) sin(phi_4(i))];
    circ_out(i).hitPoint=circ_out(i).position-circ_out(i).position/norm(circ_out(i).position)*0.5;
end    

drawMatrix=zeros(size(data,2),1+2+3+2);
size(drawMatrix);
for i=1:length(circ_1)
    drawMatrix(circ_1(i).number,1)=circ_1(i).maleOrFemale;
    drawMatrix(circ_1(i).number,2:3)=circ_1(i).position;
    drawMatrix(circ_1(i).number,4:6)=circ_1(i).choises;
    drawMatrix(circ_1(i).number,7:8)=circ_1(i).hitPoint;
end

for i=1:length(circ_2)
    drawMatrix(circ_2(i).number,1)=circ_2(i).maleOrFemale;
    drawMatrix(circ_2(i).number,2:3)=circ_2(i).position;
    drawMatrix(circ_2(i).number,4:6)=circ_2(i).choises;
     drawMatrix(circ_2(i).number,7:8)=circ_2(i).hitPoint;
end

for i=1:length(circ_3)
    drawMatrix(circ_3(i).number,1)=circ_3(i).maleOrFemale;
    drawMatrix(circ_3(i).number,2:3)=circ_3(i).position;
    drawMatrix(circ_3(i).number,4:6)=circ_3(i).choises;
     drawMatrix(circ_3(i).number,7:8)=circ_3(i).hitPoint;
end

for i=1:length(circ_out)
    drawMatrix(circ_out(i).number,1)=circ_out(i).maleOrFemale;
    drawMatrix(circ_out(i).number,2:3)=circ_out(i).position;
    drawMatrix(circ_out(i).number,4:6)=circ_out(i).choises;
    drawMatrix(circ_out(i).number,7:8)=circ_out(i).hitPoint;
end 

fig_handler=figure('Units', 'centimeters', 'pos',  [0 0 17 17]);
set(fig_handler,'DefaultAxesFontSize',10,'DefaultAxesFontName','Times New Roman');
set(fig_handler,'DefaultTextFontSize',10,'DefaultTextFontName','Times New Roman');
% axis equal;
axis square 
axis off;
hold on;
plot(R_1*cos(phi),R_1*sin(phi),'k','lineWidth',1.5);
plot(R_2*cos(phi),R_2*sin(phi),'k','lineWidth',1.5);
plot(R_3*cos(phi),R_3*sin(phi),'k','lineWidth',1.5);
hold off;
bound=max([abs(min(min(drawMatrix(:,2:3)))) abs(max(max(drawMatrix(:,2:3))))]);
xlim([-bound-0.5 bound+0.5]);
ylim([-bound-0.5 bound+0.5]);

        for i=1:size(drawMatrix,1)
            drawIteam(drawMatrix,i,smooth);
        end
end
function drawIteam(data,idx,smooth)
    if data(idx,1)==1;
        drawTriangle(data(idx,2:4), 1)
    else
         drawCirc(data(idx,2:4), 1)
    end
    text(data(idx,2),data(idx,3),num2str(idx),'HorizontalAlignment','center','FontSize',14,...
        'FontName','Times New Roman');
    if smooth==1
        drawLine([data(idx,7:8) -data(idx,7:8)/norm(data(idx,7:8))],...
                      [data(data(idx,4),7:8) -data(data(idx,4),7:8)/norm(data(data(idx,4),7:8))])
        drawLine([data(idx,7:8) -data(idx,7:8)/norm(data(idx,7:8))],...
                      [data(data(idx,5),7:8) -data(data(idx,5),7:8)/norm(data(data(idx,5),7:8))])
        drawLine([data(idx,7:8) -data(idx,7:8)/norm(data(idx,7:8))],...
                      [data(data(idx,6),7:8) -data(data(idx,6),7:8)/norm(data(data(idx,6),7:8))])
    else
        drawLine(data(idx,7:8),data(data(idx,4),7:8))
        drawLine(data(idx,7:8),data(data(idx,5),7:8))
        drawLine(data(idx,7:8),data(data(idx,6),7:8))
    end
end
function drawCirc(position, scale)
    hold on
    phi=linspace(0,2*pi,36);
    plot(scale*0.5*cos(phi)+position(1),scale*0.5*(sin(phi))+position(2),'k','lineWidth',1.5)
    hold off;
end
function drawTriangle(position, scale)
    hold on
    x_s=[0.5 -0.5*sin(pi/6) -0.5*sin(pi/6) 0.5];
    y_s=[0     0.5*cos(pi/6) -0.5*cos(pi/6) 0];
     phi=linspace(0,2*pi,36);
     plot(position(1)+scale*x_s,...
           position(2)+scale*y_s,'k','lineWidth',1.5)
          plot(scale*0.5*cos(phi)+position(1),scale*0.5*(sin(phi))+position(2),'k','lineWidth',0.25)
    hold off;
end
function drawLine(front, back)
hold on;
plot(front(1),front(2),'or');
hold off;
drawArrow(front, back,0.2);
end
function  rotM = rotMat(angleX)
rotM =[[cos(angleX) -sin(angleX)];...
           [sin(angleX) cos(angleX)]];
end
