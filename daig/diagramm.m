clc;
clear all;
close all;

question_1 =dlmread('question_1.dat');
question_2 =dlmread('question_2.dat');

maleFemale=dlmread('sex.dat');

f_1=drawDiagramm(question_1 ,maleFemale,1);
% plot2svg('question_1_smooth.svg');
% plot2svg('question_1.svg');
% f_2=drawDiagramm(question_1 ,maleFemale,0);
f_2=drawDiagramm(question_2 ,maleFemale,1);
% plot2svg('question_2_smooth.svg');
% plot2svg('question_2.svg');