clear all; close all;clc;
matlab=true;
initEnvio(matlab);
% global raysOutMin;
global MaksTelMatrMin={0};
global absolutemax
global absolutemin;
absolutemax=2000;
absolutemin=0;
curt=clock();
global outfilename=sprintf('zout%d%d',curt(2),curt(3));
global mtp5679=[45.000,-362.800,100,108.900,20.000,140.000,124,11.600,-110];

global minInd;
global mtpMinInd=[45,-362.8,-100,-108.9,14.3,145,-200,11.6,-200];
global mtpsize=9;

%  [x, obj, info, iter, nf, lambda] = sqp (x0, phi)
