classdef Streaming < handle
    % A superclass for creating a time-based streaming object
    
    
    % Copyright 2015 The MathWorks, Inc.
    
    properties (SetAccess = protected)
        Period
        Timer
    end
    
    methods
        
        function obj = Streaming(varargin)
            
            % Create timer object to control Streaming rate
            if nargin < 1 || isempty(varargin)
                varargin{1} = 2; % seconds
            end
            obj.Period = varargin{1};
            obj.Timer = timer('ExecutionMode','FixedRate',...
                'Period',obj.Period,'TimerFcn',@(~,~) step(obj));
        end
        
        function start(obj)
            start(obj.Timer);
        end
        
        function stop(obj)
            stop(obj.Timer);
        end
        
        function delete(obj)
            delete(obj.Timer);
        end
        
        function setPeriod(obj,period)
            if strcmpi(obj.Timer.Running,'on')
                stop(obj);
                restart = true;
            else
                restart = false;
            end
            obj.Timer.Period = period;
            obj.Period = obj.Timer.Period;
            if restart
                start(obj);
            end
        end
    end
end