% ALPAO SDK Wrapper
%
% This class help to drive Alpao deformable mirrors
%
classdef asdkDM < handle
    properties
        nAct = 0;
    end
    
    properties (SetAccess = private, Hidden=true )
        dmId = -1;
    end
    
    methods
        function obj = asdkDM( serialName )
            %% Default class constructor
            
            obj.dmId = asdkMex( 0, serialName );
            obj.nAct = asdkMex( 5, obj.dmId, 'NbOfActuator' );
        end

        function delete( obj )
            %% Default class destructor
            
            asdkMex( 1, obj.dmId );
        end

        function Send( obj, values )
            %% Send values to the mirror
            % Parameters:
            %   values - vector of nAct values to send.  
            if ( numel( values ) ~= obj.nAct )
                error( 'ASDK:DM:InvalidSize', 'Invalid number of element.');
            end
            asdkMex( 2, obj.dmId, values );
        end

        function Reset( obj )
            %% Flat the mirror
            
            asdkMex( 7, obj.dmId );
        end
        
        function SendPattern( obj, values, nRepeat )
            %% Send multiple values to the mirror and repeat it
            % Parameters:
            %   values  - vector of nAct*nPattern values to send.
            %   nRepeat - number of time to send the vector ( '0' mean
            %             infinitly )
            
            nElem = numel( values );
            assert( isvector(values) && mod(nElem,obj.nAct) == 0, ...
                'Invalid number of element' );
            asdkMex( 3, obj.dmId, values, numel( values ) / obj.nAct, nRepeat );
        end
        
        function Stop( obj )
            %% Stop current transfer to mirror
            
            asdkMex( 4, obj.dmId );
        end
        
        function value = Get( obj, cmdName )
            %% Get value from SDK
            % Parameters:
            %   cmdName - name of the value.  
            
            value = asdkMex( 5, obj.dmId, cmdName );
        end
        
        function Set( obj, cmdName, value )
            %% Set value from SDK
            % Parameters:
            %   cmdName - name of the value. 
            %   value   - value to set (string or numerical)
            
            asdkMex( 6, obj.dmId, cmdName, value );
        end
    end
        
    methods (Hidden)
        function SendPatternSingle( obj, values, nRepeat, actuatorId )
            %% Send multiple values to the mirror and repeat it
            % Parameters:
            %   values  - vector of nAct values to send.
            %   nRepeat - number of time to send the vector ( '0' mean
            %             infinitly )
            %   actuId  - actuator number in [1:nAct]
            
            asdkMex( 8, obj.dmId, values, actuatorId, nRepeat );
        end
    end
    
    methods (Static)
        function PrintLastLog()
            asdkMex( -1 );
        end
        function [message, id] = GetLastLog()
            [message, id] = asdkMex( -2 );
        end
    end
end