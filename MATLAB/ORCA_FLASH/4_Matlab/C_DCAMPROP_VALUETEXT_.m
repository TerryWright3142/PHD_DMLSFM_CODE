% typedef struct R_DCAMPROP_VALUETEXT_ {
% 	int32		cbSize;		// sizeof(*this)
% 	int32		iProp;		// DCAMIDPROP
% 	double		value;		// value of the property
% 	char*		text;		// text of the value
% 	int32		textbytes;		// text buf size
% } R_DCAMPROP_VALUETEXT;
classdef C_DCAMPROP_VALUETEXT_ < C_BASIC_TYPES
    properties
      iProp;
      value;
      text;
      textbytes;
    end
    methods 
        function obj = C_DCAMPROP_VALUETEXT_(iProp, value, text, textbytes)  
            obj.size = 24; %  sizeof(DCAMPROP_VALUETEXT)
            obj.iProp = iProp;
            obj.value = value;
            obj.text = text;
            obj.textbytes = textbytes;
            pstruct.cbSize = obj.size;
            pstruct.iProp = obj.iProp;
            pstruct.value = obj.value;
            pstruct.text = obj.text;
            pstruct.textbytes = obj.textbytes;
            obj.matlabPtr = libpointer('R_DCAMPROP_VALUETEXT_',pstruct); 
        end
        function Refresh(obj)
            obj.text = obj.GetPtr().Value.text;
            obj.textbytes = obj.GetPtr().Value.textbytes;
        end


    end
end