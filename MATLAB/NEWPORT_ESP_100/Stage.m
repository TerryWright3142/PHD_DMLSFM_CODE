% worked fine 31/10
classdef (Abstract) Stage < handle
    methods (Abstract)
        Init(obj, COMport); % initialise the stage with a COM port number
        % synchronised moves - does not return until the move is over
        AbsMoveSynch(obj, pos); % move to an absolute position within the range of the actuator eg 12.23mm
        RelMoveSynch(obj, rel_pos); % relative movement eg +2.12 or -0.12mm
        %Asynchronised moves - returns control immediately whilst the
        %actuator is moving
        AbsMoveAsynch(obj, pos);
        RelMoveAsynch(obj, pos);
        softwareLimits = GetLimits(obj); % returns the software limits
        absPos = GetPositionAbs(obj); % gets the current absolute position
        StopMotion(obj); %emergency stop
        Shutdown(obj); % releases connection with the actuator and the COM port
    end
end