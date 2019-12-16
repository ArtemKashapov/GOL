function [ R_A_Y_S ] = shiftRays( R_A_Y_S, position )
%SHIFTRAYS Summary of this function goes here
%   Detailed explanation goes here
        R_A_Y_S(:,1)=R_A_Y_S(:,1)+position(1);
        R_A_Y_S(:,2)=R_A_Y_S(:,2)+position(2);
        R_A_Y_S(:,3)=R_A_Y_S(:,3)+position(3);
end

