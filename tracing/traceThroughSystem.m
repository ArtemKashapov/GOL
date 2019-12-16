function [ raysIn, raysMiddle, raysOut ] = traceThroughSystem( raysIn,varargin)
%TRACETHROUGHSYSTEM Summary of this function goes here
%   Detailed explanation goes here
    if nargin==0
        printf('No system and rays provided in traceThroughSystem\n');
        raysMiddle=[];
        raysOut=[];
    elseif nargin==2
        [raysIn, raysMiddle, raysOut ] = traceAsArray(varargin{1},raysIn);
    elseif nargin==3
        [raysIn, raysMiddle, raysOut ] = traceByOrder(varargin{1},varargin{2},raysIn);
    else
     printf('Wrong number of arguments in traceTrhoughSystem, it expects 2 or 3 arguments\n');
     raysMiddle=[];
     raysOut=[];       
    end
end
% ����������� �� ��������� � orderSequence ������� ����� ����� �������� ��
% ������ opticalElements
function [raysIn, raysMiddle, raysOut ] = traceByOrder(opticalElements,orderSequence,rays)
    if isempty(orderSequence)
        disp('WARRING: no sequence found');
        [raysIn, raysMiddle, raysOut ] = traceAsArray(opticalElements,rays);
         return;
    end
    if isempty(opticalElements)
         disp('WARRING: no elements to trace');
        raysMiddle=[]; raysOut=[];
        return;
    end
         raysMiddle=[]; raysOut=[];raysIn=[];

          [raysIn_, raysMiddle_, raysOut_ ] = traceThrough(opticalElements{orderSequence(1)}, rays);
 
           raysMiddle = [raysMiddle; raysMiddle_];
           raysIn    = [raysIn; raysIn_];
           raysIn_=raysOut_;
        
        for i=2:length(orderSequence)-1
              [raysIn_, raysMiddle_, raysOut_ ] = traceThrough(opticalElements{orderSequence(i)}, raysIn_);
               raysMiddle = [raysMiddle; raysMiddle_;raysIn_];
               raysIn_=raysOut_;
        end
        
        [~, raysMiddle_, raysOut_ ] = traceThrough(opticalElements{orderSequence(length(orderSequence))}, raysIn_);

                raysMiddle = [raysMiddle; raysMiddle_];
                raysOut = [raysOut; raysOut_];

        
end

% ����������� ������ opticalElements � ������� ���������� ���������

function [raysIn, raysMiddle, raysOut ] = traceAsArray(opticalElements,rays)
    if isempty(opticalElements)
        raysMiddle=[]; raysOut=[];
        return;
    end
    
    raysMiddle=[]; raysOut=[];raysIn=[];
  
          [raysIn_, raysMiddle_, raysOut_ ] = traceThrough(opticalElements{1}, rays);
 
           raysMiddle = [raysMiddle; raysMiddle_];
           raysIn    = [raysIn; raysIn_];
           raysIn_=raysOut_;
        
        for i=2:length(opticalElements)-1
              [raysIn_, raysMiddle_, raysOut_ ] = traceThrough(opticalElements{i}, raysIn_);
               raysMiddle = [raysMiddle; raysMiddle_;raysIn_];
               raysIn_=raysOut_;
        end
        
        [~, raysMiddle_, raysOut_ ] = traceThrough(opticalElements{length(opticalElements)}, raysIn_);

                raysMiddle = [raysMiddle; raysMiddle_];
                raysOut = [raysOut; raysOut_];
end

function [raysIn, raysMiddle, raysOut ] = traceThrough(opticalElement,raysIn)
    if strcmp(opticalElement.type,'surface')
      [raysIn ,raysOut]=processSurface(opticalElement,raysIn);
      raysMiddle=[];
      return;
    elseif strcmp(opticalElement.type,'lens')
      [ raysIn, raysMiddle, raysOut ] = traceThroughtLens( opticalElement, raysIn);
      return;
    else
        raysIn=[];
        raysMiddle=[];
        raysOut=[];
        error('ERROR:Unknown elemenet in tracing task list');
%         return;
    end
end

function [raysIn ,raysOut]=processSurface(quadSurface,raysIn)
% l=length(quadSurface.extraDataType);
    if isempty(quadSurface.extraDataType)
        [raysIn]=quadIntersect(quadSurface,raysIn);
        raysOut=raysIn;
        return;
    end    
   
    
   if  endWith(quadSurface.extraDataType, 'DG');%strcmp(endsWith(quadSurface.extraDataType),'DG')
        [ raysIn ,raysOut] = difractionFromQuad(quadSurface,raysIn);
         return;
   elseif endWith(quadSurface.extraDataType,'mirror');%strcmp(quadSurface.type,'mirror')
%       disp(size(raysIn))
        [raysOut,raysIn]=reflectFormQuad(quadSurface,raysIn);
        return;
   else
        [raysIn]=quadIntersect(quadSurface,raysIn);
        raysOut=raysIn;
        return;
    end
end

