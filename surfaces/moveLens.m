
%% Двигает  линзу в координату position
%% сдвиг происходит относительно первой поерхности
function [ Lens ] = moveLens( Lens,position)
%MOVELENSE Summary of this function goes here
%   Detailed explanation goes here
delta_pos=Lens.backSurface.position-Lens.frontSurface.position;
Lens.frontSurface=moveQuad(Lens.frontSurface,position);
Lens.backSurface=moveQuad(Lens.backSurface,position+delta_pos);


end

