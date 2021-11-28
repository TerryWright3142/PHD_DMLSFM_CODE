% typedef struct R_DCAMPROP_ATTR_ {
% 	int32		cbSize;		// sizeof(*this)
% 	int32		iProp;		// DCAMIDPROPERTY
% 	int32		option;		// reserved
% 	int32		iReserved1;		// reserved
% 	int32		attribute;		// DCAMPROPATTRIBUTE
% 	int32		iGroup;		// reserved
% 	int32		iUnit;		// DCAMPROPUNIT
% 	int32		attribute2;		// DCAMPROPATTRIBUTE2
% 	double		valuemin;		// minimum value
% 	double		valuemax;		// maximum value
% 	double		valuestep;		// minimum stepping value between two contiguous valid values
% 	double		valuedefault;		// default value
% 	int32		nMaxChannel;		// max channel if supported
% 	int32		iReserved3;		// 0 reserved
% 	int32		nMaxView;		// max view if supported
% 	int32		iProp_NumberOfElement;		// property id to get number of elements of this property if it is array
% 	int32		iProp_ArrayBase;		// base id of array if element
% 	int32		iPropStep_Element;		// step for iProp to next element
% } R_DCAMPROP_ATTR;

classdef C_DCAMPROP_ATTR_  < C_BASIC_TYPES
    properties
        % check [in out] for this
        iProp;		
        option;		
        iReserved1;	
        attribute;		
        iGroup;		
        iUnit;		
        attribute2;		
        valuemin;		
        valuemax;		
        valuestep;		
        valuedefault;		
        nMaxChannel;	
        iReserved3;	
        nMaxView;
        iProp_NumberOfElement;	
        iProp_ArrayBase;		
        iPropStep_Element;		
    end
    methods 
        function obj = C_DCAMPROP_ATTR_ (iProp)         

                    obj.size = 88; % check this
                    obj.iProp = iProp;		
                    obj.option = 0;		
                    obj.iReserved1=0;	
                    obj.attribute=0;		
                    obj.iGroup=0;		
                    obj.iUnit=0;		
                    obj.attribute2=0;		
                    obj.valuemin=0;		
                    obj.valuemax=0;		
                    obj.valuestep=0;		
                    obj.valuedefault=0;		
                    obj.nMaxChannel=0;	
                    obj.iReserved3=0;	
                    obj.nMaxView=0;
                    obj.iProp_NumberOfElement=0;	
                    obj.iProp_ArrayBase=0;		
                    obj.iPropStep_Element=0;
                
                    pstruct.cbSize = obj.size;
                    pstruct.iProp = obj.iProp;
                    pstruct.option = obj.option;
                    pstruct.iReserved1 = obj.iReserved1;
                    pstruct.attribute = obj.attribute;
                    pstruct.iGroup = obj.iGroup;
                    pstruct.iUnit = obj.iUnit;
                    pstruct.attribute2 = obj.attribute2;
                    pstruct.valuemin = obj.valuemin;
                    pstruct.valuemax = obj.valuemax;
                    pstruct.valuestep = obj.valuestep;
                    pstruct.valuedefault = obj.valuedefault;
                    pstruct.nMaxChannel = obj.nMaxChannel;
                    pstruct.iReserved3 = obj.iReserved3;
                    pstruct.nMaxView = obj.nMaxView;
                    pstruct.iProp_NumberOfElement = obj.iProp_NumberOfElement;
                    pstruct.iProp_ArrayBase = obj.iProp_ArrayBase;
                    pstruct.iPropStep_Element = obj.iPropStep_Element;
                
                
                
                  obj.matlabPtr = libpointer('R_DCAMPROP_ATTR_',pstruct); 
        end
        function Refresh(obj)	
                    obj.option = obj.GetPtr().Value.option;			
                    obj.attribute= obj.GetPtr().Value.attribute;		
                    obj.iGroup= obj.GetPtr().Value.iGroup;		
                    obj.iUnit= obj.GetPtr().Value.iUnit;		
                    obj.attribute2= obj.GetPtr().Value.attribute2;		
                    obj.valuemin= obj.GetPtr().Value.valuemin;		
                    obj.valuemax= obj.GetPtr().Value.valuemax;		
                    obj.valuestep= obj.GetPtr().Value.valuestep;		
                    obj.valuedefault= obj.GetPtr().Value.valuedefault;		
                    obj.nMaxChannel= obj.GetPtr().Value.nMaxChannel;		
                    obj.nMaxView= obj.GetPtr().Value.nMaxView;
                    obj.iProp_NumberOfElement= obj.GetPtr().Value.iProp_NumberOfElement;	
                    obj.iProp_ArrayBase= obj.GetPtr().Value.iProp_ArrayBase;		
                    obj.iPropStep_Element= obj.GetPtr().Value.iPropStep_Element;
            
        end
    end
end