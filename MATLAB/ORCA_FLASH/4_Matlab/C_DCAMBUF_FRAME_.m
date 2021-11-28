% typedef struct R_DCAMBUF_FRAME_ {
% 	int32		size;		// sizeof(*this)
% 	int32		iKind;		// reserved
% 	int32		option;		// reserved
% 	int32		iFrame;		// frame index
% 	void*		buf;		// pointer to the image
% 	int32		rowbytes;		// byte size for next line
% 	R_DCAM_PIXELTYPE		type;		// pixel type in image data
% 	int32		width;		// horizontal pixel count
% 	int32		height;		// vertical line count
% 	int32		left;		// horizontal start pixel
% 	int32		top;		// vertical start line
% 	R_DCAM_TIMESTAMP		timestamp;		// time stamp
% 	int32		framestamp;		// frame stamp
% 	int32		camerastamp;		// camera stamp
% } R_DCAMBUF_FRAME;

classdef C_DCAMBUF_FRAME_ < C_BASIC_TYPES
    properties    
      iKind;
      option;
      iFrame;
      buf;
      rowbytes;
      type;
      width;
      height;
      left;
      top;
      timestamp;
      framestamp;
      camerastamp;
    end
    methods 
        function obj = C_DCAMBUF_FRAME_(iFrame, iKind, option,  ...
                buf, rowbytes, ...
                type, width, height, left, top, ...
                timestamp, framestamp, camerastamp ...
                )
            obj.size = 60;  %sizeof(DCAMBUF_FRAME)  60, 64?
            obj.iFrame = iFrame;
            if nargin == 1
                obj.iKind = 0;
                obj.option = 0;
                obj.buf = [];
                obj.rowbytes = 0;
                obj.type = 0;
                obj.width = 0;
                obj.height = 0;
                obj.left = 0;
                obj.top = 0;
                obj.timestamp = C_DCAM_TIMESTAMP_(0,0);
                obj.framestamp = 0;
                obj.camerastamp = 0;            
            else
                obj.iKind = iKind;
                obj.option = option;
                obj.buf = buf;
                obj.rowbytes = rowbytes;
                obj.type = type;
                obj.width = width;
                obj.height = height;
                obj.left = left;
                obj.top = top;
                obj.timestamp = timestamp;
                obj.framestamp = framestamp;
                obj.camerastamp = camerastamp;
            end  
                pstruct.size = obj.size;
                pstruct.iKind = obj.iKind;
                pstruct.option = obj.option;
                pstruct.iFrame = obj.iFrame;
                pstruct.buf = obj.buf;
                pstruct.rowbytes = obj.rowbytes;
                pstruct.type = obj.type;
                pstruct.width = obj.width;
                pstruct.height = obj.height;
                pstruct.left = obj.left;
                pstruct.top = obj.top;
                pstruct.timestamp = obj.timestamp.GetPtr();
                pstruct.framestamp = obj.framestamp;
                pstruct.camerastamp = obj.camerastamp;
                
                obj.matlabPtr = libpointer('R_DCAMBUF_FRAME_', pstruct);               
        end
        function MakePtr(obj)
                pstruct.size = obj.size;
                pstruct.iKind = obj.iKind;
                pstruct.option = obj.option;
                pstruct.iFrame = obj.iFrame;
                pstruct.buf = obj.buf;
                pstruct.rowbytes = obj.rowbytes;
                pstruct.type = obj.type;
                pstruct.width = obj.width;
                pstruct.height = obj.height;
                pstruct.left = obj.left;
                pstruct.top = obj.top;
                pstruct.timestamp = obj.timestamp.GetPtr();
                pstruct.framestamp = obj.framestamp;
                pstruct.camerastamp = obj.camerastamp;
                
                obj.matlabPtr = libpointer('R_DCAMBUF_FRAME_', pstruct);             
            
        end
        %do we need a refresh function arnt these passed by ref
        function Refresh(obj)
            obj.iKind   = obj.GetPtr().Value.iKind;
            obj.option  = obj.GetPtr().Value.option;
            obj.buf     = obj.GetPtr().Value.buf;
            obj.rowbytes = obj.GetPtr().Value.rowbytes;
            obj.type    = obj.GetPtr().Value.type;
            obj.width   = obj.GetPtr().Value.width;
            obj.height  = obj.GetPtr().Value.height;
            obj.left    = obj.GetPtr().Value.left;
            obj.top     = obj.GetPtr().Value.top;
            obj.timestamp = obj.GetPtr().Value.timestamp;
            obj.framestamp = obj.GetPtr().Value.framestamp;
            obj.camerastamp = obj.GetPtr().Value.camerastamp; 
            %obj.timestamp.Refresh();
        end

    end
end