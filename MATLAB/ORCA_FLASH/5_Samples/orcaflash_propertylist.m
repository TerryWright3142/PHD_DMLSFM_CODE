%%matlab implementation of sdk:   propertylist
disp('PROPERTYLIST SAMPLE (PARTIAL IMPLEMENTATION)');
addpath('../4_Matlab');
bRelay = true;
bDebug = false;

DCAM = DCAMSDK(bRelay, bDebug);
disp('loaded dcam');


%% init dcam sdk
data = C_INT32_ARRAY_();
guid = C_DCAM_GUID_();
init = C_DCAMAPI_INIT_(0,0,data.SizeOf(), data, guid);
[err, init] = DCAM.dcamapi_init(init);
err
clear init guid data;
disp('dcamapi_init');

%% OPEN CAMERA
deviceToUse = 0;
open = C_DCAMDEV_OPEN_(deviceToUse);
[err, open] = DCAM.dcamdev_open(open);
err
hdcam = open.GetHDCAM();
clear open;
disp('dcamdev_open');

%% get and display properties
iProp = 0;	
[err1, iProp] = DCAM.dcamprop_getnextid( hdcam, iProp, DCAM.DCAMPROP_OPTION_SUPPORT );
while err1 >= 0
        text = int8(zeros(1,65));
        [err3, text] = DCAM.dcamprop_getname( hdcam, iProp, text, length(text) );
        disp(sprintf( '0x%08x: %s', iProp, text ));
        %get property attribute
        attr = C_DCAMPROP_ATTR_(iProp);
        [err3, attr] = DCAM.dcamprop_getattr(hdcam, attr);

        attrList = [];
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_WRITABLE ),                  attrList = [attrList,'WRITABLE ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_READABLE ),                  attrList = [attrList,'READABLE ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_DATASTREAM ),                attrList = [attrList,'DATASTREAM ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_ACCESSREADY ),               attrList = [attrList,'ACCESSREADY ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_ACCESSBUSY ),                attrList = [attrList,'ACCESSBUSY ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_HASVIEW ),                   attrList = [attrList,'HASVIEW ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_HASCHANNEL ),                attrList = [attrList,'HASCHANNEL ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_HASRATIO ),                  attrList = [attrList,'HASRATIO ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_VOLATILE ),                  attrList = [attrList,'VOLATILE ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_AUTOROUNDING ),              attrList = [attrList,'AUTOROUNDING ']; end
        if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_STEPPING_INCONSISTENT ),     attrList = [attrList,'STEPPING_INCONSISTENT ']; end
        if bitand( uint32(attr.attribute2) , DCAM.DCAMPROP_ATTR2_ARRAYBASE ),                attrList = [attrList,'ARRAYBASE ']; end
        if bitand( uint32(attr.attribute2) , DCAM.DCAMPROP_ATTR2_ARRAYELEMENT ),             attrList = [attrList,'ARRAYELEMENT ']; end
        disp(attrList);
        switch bitand(uint32(attr.attribute) , DCAM.DCAMPROP_TYPE_MASK)	
            case DCAM.DCAMPROP_TYPE_MODE
                disp('TYPE:MODE');
            case DCAM.DCAMPROP_TYPE_LONG
                disp('TYPE:LONG');
            case DCAM.DCAMPROP_TYPE_REAL
                disp('TYPE:REAL');
            otherwise
                disp('TYPE:NONE');	
        end

    if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_HASRANGE )
		disp(sprintf( "min:\t%f", attr.valuemin ));
		disp(sprintf( "max:\t%f", attr.valuemax ));
        
    end
    if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_HASSTEP )
        disp(sprintf( 'step:\t%f', attr.valuestep ));	
    end
    if bitand( uint32(attr.attribute) , DCAM.DCAMPROP_ATTR_HASDEFAULT )
        disp(sprintf( 'default:\t%f', attr.valuedefault ));
    end
    if  bitand(uint32(attr.attribute) , DCAM.DCAMPROP_TYPE_MASK) == DCAM.DCAMPROP_TYPE_MODE 
    %supported modes
        disp('SUPPORTED MODES');
        pv_index = 0;
        v = attr.valuemin;
        err2 = 1;
        while err2 >= 0
                pv_text = int8(zeros(1,65));
                pvt = C_DCAMPROP_VALUETEXT_(iProp, v, pv_text, length(pv_text)); 
                pv_index = pv_index + 1;
                [err3, pvt] = DCAM.dcamprop_getvaluetext( hdcam, pvt );
                pv_text = pvt.text;
                disp(sprintf( "\t%d:\t%s", pv_index, pv_text ));
                [err2, v] = DCAM.dcamprop_queryvalue( hdcam, iProp, v, DCAM.DCAMPROP_OPTION_NEXT );
                clear pvt;
        end
    end

    [err1, iProp] = DCAM.dcamprop_getnextid( hdcam, iProp, DCAM.DCAMPROP_OPTION_SUPPORT );
clear attr;
disp('****************************');
end


%% CLOSE CAMERA
DCAM.dcamdev_close(hdcam)
disp('dcamdev_close');


%% uninit dcam sdk
DCAM.dcamapi_uninit()
disp('dcamapi_uninit');
%% remove dll library
% MUST CLEAR ALL OBJECTS CREATED BY LIBSTRUCT PRIOR TO UNLOADING, THIS IS A
% BUG IN LIB API
clear DCAM;
disp('unloaded dcam');