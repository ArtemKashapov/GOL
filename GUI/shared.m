%% ========================================================
%% FILE: shared.m
%% VER: 1.0
%% LAST-MODIFIED: 2009/07/15 23:00
%% AUTHOR: "Gary Lee" <garywlee@gmail.com>
%%
%% Description
%%
%% The utility class to store the data which need to be 
%% modified in-place. When using a variable which created 
%% by this class, it can be used as a pass-by-reference
%% argument for function. Or, alias variables.
%%
%% The basic idea is the content of handle class will not be
%% copied. Then, create a class inherited from handle class and
%% reimplement the operator functions. The object created by 
%% this class will work like normal matlab primitive data types.
%%
%%
%% For example, 
%%  a = shared([1:100]);
%%  b = a;
%%  b(1:10) = 0;
%%  a(1:10)
%%  
%%  inplace_intr(b);
%%  a(1:10)
%%
%%  function inplace_intr(d)
%%      d.data = d + 1;
%%  end
%%
%% Special note:
%%  1. You can't use something like 'a = a + 1'. Use 'a.data = a + 1' instead.
%% 
%% Please report bugs to <a href="mailto:garywlee@gmail.com">garywlee@gmail.com</a>
%% 
%% Copyright (c) 2009, Gary Lee, All rights reserved.
%% ========================================================
%% Redistribution and use in source and binary forms, with or without 
%% modification, are permitted provided that the following conditions are 
%% met:
%% 
%%     * Redistributions of source code must retain the above copyright 
%%       notice, this list of conditions and the following disclaimer.
%%     * Redistributions in binary form must reproduce the above copyright 
%%       notice, this list of conditions and the following disclaimer in 
%%       the documentation and/or other materials provided with the distribution
%%       
%% THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" 
%% AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE 
%% IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE 
%% ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE 
%% LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR 
%% CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF 
%% SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS 
%% INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN 
%% CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) 
%% ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE 
%% POSSIBILITY OF SUCH DAMAGE.
%% ========================================================

classdef shared < handle
    properties 
        %% Store the data to be shared.
        data;
    end    
    methods
        function self = shared(defVal)
            if nargin >= 1 && ~isempty(defVal)
                self.data = defVal;
            end                    
        end        
       
        function r = subsref(self, s)
            if strcmp(s.type, '.') && strcmp(s.subs, 'data')
                r = builtin('subsref', self, s);
            else
                r = subsref(self.data, s);
            end            
        end
       
        function self = subsasgn(self, s, b)
            if strcmp(s.type, '.') && strcmp(s.subs, 'data')
                self = builtin('subsasgn', self, s, b);
            else       
                self.data = subsasgn(self.data, s, b);
            end
        end
       
        function display(self)
            display(self.data)
        end
       
        function r = plus(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = plus(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = plus(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = plus(a, b.data);
            end            
        end
        
        function r = minus(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = minus(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = minus(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = minus(a, b.data);
            end            
        end
        
        function r = uminus(a)
            r = uminus(a.data);
        end        
        
        function r = uplus(a)
            r = uplus(a.data);
        end
        
        function r = times(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = times(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = times(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = times(a, b.data);
            end            
        end        
        
        function r = mtimes(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = mtimes(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = mtimes(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = mtimes(a, b.data);
            end                    
        end
        
        function r = rdivide(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = rdivide(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = rdivide(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = rdivide(a, b.data);
            end                            
        end
        
        function r = ldivide(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = ldivide(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = ldivide(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = ldivide(a, b.data);
            end
        end
        
        function r = mrdivide(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = mrdivide(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = mrdivide(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = mrdivide(a, b.data);        
            end
        end
        
        function r = mldivide(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = mldivide(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = mldivide(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = mldivide(a, b.data);        
            end     
        end
        
        function r = power(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = power(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = power(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = power(a, b.data);        
            end         
        end
        
        function r = mpower(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = mpower(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = mpower(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = mpower(a, b.data);        
            end       
        end        
        
        function r = lt(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = lt(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = lt(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = lt(a, b.data);        
            end                    
        end
        
        function r = gt(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = gt(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = gt(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = gt(a, b.data);        
            end                           
        end
        
        function r = le(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = le(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = le(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = le(a, b.data);        
            end                                
        end
        
        function r = ge(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = ge(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = ge(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = ge(a, b.data);        
            end                                       
        end
        
        function r = ne(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = ne(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = ne(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = ne(a, b.data);        
            end                                       
        end
        
        function r = eq(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = eq(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = eq(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = eq(a, b.data);        
            end                                        
        end
        
        function r = and(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = and(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = and(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = and(a, b.data);        
            end                                            
        end        
        
        function r = or(a,b)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = or(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = or(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = or(a, b.data);        
            end                                       
        end               
        
        function r = not(a)
            r = not(a.data)
        end
        
        function r = colon(a,d,varargin)
            if size(varargin,2) == 0,
                if      isa(a, 'shared') &&  isa(d, 'shared')   r = colon(a.data, d.data);
                elseif  isa(a, 'shared') && ~isa(d, 'shared')   r = colon(a.data, d);
                elseif ~isa(a, 'shared') &&  isa(d, 'shared')   r = colon(a, d.data);        
                end   
            else                  
                b = varargin{1};
                if      isa(a, 'shared') &&  isa(d, 'shared') &&  isa(b, 'shared')  r = colon(a.data, d.data, b.data);
                elseif  isa(a, 'shared') &&  isa(d, 'shared') && ~isa(b, 'shared')  r = colon(a.data, d.data, b);
                elseif  isa(a, 'shared') && ~isa(d, 'shared') &&  isa(b, 'shared')  r = colon(a.data, d, b.data);
                elseif ~isa(a, 'shared') &&  isa(d, 'shared') &&  isa(b, 'shared')  r = colon(a, d.data, b.data);        
                elseif ~isa(a, 'shared') &&  isa(d, 'shared') && ~isa(b, 'shared')  r = colon(a, d.data, b);
                elseif  isa(a, 'shared') &&  isa(d, 'shared') && ~isa(b, 'shared')  r = colon(a.data, d.data, b);
                elseif  isa(a, 'shared') && ~isa(d, 'shared') && ~isa(b, 'shared')  r = colon(a.data, d, b);
                end                  
           end                
        end
        
        function r = ctranspose(a)
            r = ctranspose(a.data);
        end
        
        function r = transpose(a)
            r = transpose(a.data);
        end
        
        function r = horzcat(a, b, varargin)            
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = horzcat(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = horzcat(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = horzcat(a, b.data);        
            end                
            for v = varargin,
                if isa(v, 'shared')
                    r = horzcat(r, v.data);
                else
                    r = horzcat(r, v);
                end
            end
        end
        
        function r = vertcat(a, b, varargin)
            if      isa(a, 'shared') &&  isa(b, 'shared')   r = vertcat(a.data, b.data);
            elseif  isa(a, 'shared') && ~isa(b, 'shared')   r = vertcat(a.data, b);
            elseif ~isa(a, 'shared') &&  isa(b, 'shared')   r = vertcat(a, b.data);        
            end             
            for v = varargin,
                if isa(v, 'shared')
                    r = vertcat(r, v.data);
                else
                    r = vertcat(r, v);
                end
            end        
        end
        
        function r = subsindex(a)       
            r = a.data - 1;
        end       
        
    end %% methods
end %% function.
