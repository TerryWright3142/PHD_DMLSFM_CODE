#pragma once
#include "flash_types.h"
/*
THIS IS A COLLECTION OF DCAMAPI STRUCTURES THE DIFFERENCE
IS R_ BEFORE EACH STRUCTURE. THIS IS USED TO PREVENT AMBIGUITY
IN THE DEBUG (ALSO CALLED RELAY) DLL WHICH WILL ESSENTIALLY PASS THE 
STRUCTURES THROUGH. R_ STRUCTURES ALSO HAVE HDCAM HANDLES ETC ENCODED 
AS UNSIGNED LONG LONG INT.  THESE ARE TYPES WHICH ARE ACCEPTABLE 
TO MATLAB.

MATLAB HAS CLASSES WHICH CAN ASSEMBLE AND PASS THESE
STRUCTURES THROUGH TO THE DLL FUNCTIONS

EACH MATLAB CLASS IS PREFIXED WITH C_

SUMMARY:
DCAMAPI_INIT    structure for DCAMAPI
R_DCAMAPI_INIT	structure for DEBUG/RELAY DLL
C_DCAMAPI_INIT	matlab class which will corectly package R_DCAMAPI_INIT


*/
typedef  struct R_DCAM_GUID_ {
	_ui32		Data1;		//
	unsigned short		Data2;		//
	unsigned short		Data3;		//
	unsigned char		Data4[8];		//
} R_DCAM_GUID;

typedef struct R_DCAMAPI_INIT_ {
	int32		size;		// sizeof(*this)
	int32		iDeviceCount;		// number of recognized devices
	int32		reserved;		// Reserved
	int32		initoptionbytes;		// maximum bytes of the initoption array
	const int32*		initoption;		// initialize options, array of DCAMAPI_INITOPTION
	const R_DCAM_GUID*		guid;		// GUID option
} R_DCAMAPI_INIT;


typedef struct R_DCAMDEV_OPEN_ {
	int32		size;		// sizeof(*this)
	int32		index;		// index of the device to open
	unsigned long long int		hdcam;		//
} R_DCAMDEV_OPEN;

typedef struct R_DCAMDEV_STRING_ {
	int32		size;		// sizeof(*this)
	int32		iString;		//
	void*		text;		// look at sending this as a c-string from matlab
	int32		textbytes;		//
} R_DCAMDEV_STRING;

typedef struct R_DCAMWAIT_OPEN_ {
	int32		size;		// sizeof(*this)
	int32		supportevent;		// supported events
	unsigned long long int		hwait;		// handle for dcamwait functions
	unsigned long long int		hdcam;		// the HDCAM handle of the device
} R_DCAMWAIT_OPEN;

typedef struct R_DCAMCAP_TRANSFERINFO_ {
	int32		size;		// sizeof(*this)
	int32		iKind;		// DCAMCAP_TRANSFERKIND
	int32		nNewestFrameIndex;		// index of the newest frame
	int32		nFrameCount;		// number of captured frames
} R_DCAMCAP_TRANSFERINFO;

typedef struct R_DCAM_TIMESTAMP_ {
	int32		sec;		//
	int32		microsec;		//
} R_DCAM_TIMESTAMP;

typedef struct R_DCAMBUF_FRAME_ {
	int32		size;		// sizeof(*this)
	int32		iKind;		// reserved
	int32		option;		// reserved
	int32		iFrame;		// frame index
	void*		buf;		// pointer to the image
	int32		rowbytes;		// byte size for next line
	R_DCAM_PIXELTYPE		type;		// pixel type in image data
	int32		width;		// horizontal pixel count
	int32		height;		// vertical line count
	int32		left;		// horizontal start pixel
	int32		top;		// vertical start line
	R_DCAM_TIMESTAMP		timestamp;		// time stamp
	int32		framestamp;		// frame stamp
	int32		camerastamp;		// camera stamp
} R_DCAMBUF_FRAME;

typedef struct R_DCAMWAIT_START_ {
	int32		size;		// sizeof(*this)
	int32		eventhappened;		//
	int32		eventmask;		//
	int32		timeout;		//
} R_DCAMWAIT_START;

typedef struct R_DCAMPROP_ATTR_ {
	int32		cbSize;		// sizeof(*this)
	int32		iProp;		// DCAMIDPROPERTY
	int32		option;		// reserved
	int32		iReserved1;		// reserved
	_ui32		attribute;		// DCAMPROPATTRIBUTE
	int32		iGroup;		// reserved
	int32		iUnit;		// DCAMPROPUNIT
	_ui32		attribute2;		// DCAMPROPATTRIBUTE2
	double		valuemin;		// minimum value
	double		valuemax;		// maximum value
	double		valuestep;		// minimum stepping value between two contiguous valid values
	double		valuedefault;		// default value
	int32		nMaxChannel;		// max channel if supported
	int32		iReserved3;		// 0 reserved
	int32		nMaxView;		// max view if supported
	int32		iProp_NumberOfElement;		// property id to get number of elements of this property if it is array
	int32		iProp_ArrayBase;		// base id of array if element
	int32		iPropStep_Element;		// step for iProp to next element
} R_DCAMPROP_ATTR;

typedef struct R_DCAMPROP_VALUETEXT_ {
	int32		cbSize;		// sizeof(*this)
	int32		iProp;		// DCAMIDPROP
	double		value;		// value of the property
	void*		text;		// text of the value
	int32		textbytes;		// text buf size
} R_DCAMPROP_VALUETEXT;


typedef struct R_DCAMDEV_CAPABILITY_ {
	int32		size;		// size of whole structure
	int32		domain;		// Specify domain
	int32		capflag;		// supported flag
	int32		kind;		// detail of domain
} R_DCAMDEV_CAPABILITY;


typedef struct R_DCAMDEV_CAPABILITY_LUT_ {
	R_DCAMDEV_CAPABILITY		hdr;		// size = sizeof(*this), domain = DCAMDEV_CAPDOMAIN__DCAMDATA, kind = DCAMDATA_KIND__LUT
	int32		linearpointmax;		// max count of point for linear LUT
} R_DCAMDEV_CAPABILITY_LUT;

typedef struct R_DCAMDEV_CAPABILITY_REGION_ {
	R_DCAMDEV_CAPABILITY		hdr;		// size = sizeof(*this), domain = DCAMDEV_CAPDOMAIN__DCAMDATA, kind = DCAMDATA_KIND__REGION
	int32		horzunit;		// horizontal step of region
	int32		vertunit;		// vertical step of region
} R_DCAMDEV_CAPABILITY_REGION;

typedef struct R_DCAMDEV_CAPABILITY_FRAMEOPTION_ {
	R_DCAMDEV_CAPABILITY		hdr;		// size = sizeof(*this), domain = DCAMDEV_CAPDOMAIN__FRAMEOPTION
	int32		supportproc;		// supported DCAMBUF_PROCTYPE
} R_DCAMDEV_CAPABILITY_FRAMEOPTION;

typedef struct R_DCAMDATA_HDR_ {
	int32		size;		// size of whole structure, not only this
	int32		iKind;		//
	int32		option;		// DCAMDATA_OPTION
	int32		reserved2;		// reserved
} R_DCAMDATA_HDR;

typedef struct R_DCAMDATA_REGION_ {
	R_DCAMDATA_HDR		hdr;		// size member should be size of this structure
	int32		option;		// reserved
	int32		type;		// DCAMDATA_REGIONTYPE
	void*		data;		// top pointer of data
	int32		datasize;		// size of data
	int32		reserved;		// reserved
} R_DCAMDATA_REGION;


typedef struct R_DCAMDATA_REGIONRECT_ {
	short		left;		//
	short		top;		//
	short		right;		//
	short		bottom;		//
} R_DCAMDATA_REGIONRECT;


typedef struct R_DCAMDATA_LUT_ {
	R_DCAMDATA_HDR		hdr;		// size member should be size of this structure
	int32		type;		// DCAMDATA_LUTTYPE
	int32		page;		// page number
	void*		data;		// top pointer of data
	int32		datasize;		// size of data
	int32		reserved;		// reserved
} R_DCAMDATA_LUT;


typedef struct R_DCAMDATA_LINEARLUT_ {
	int32		lutin;		//
	int32		lutout;		//
} R_DCAMDATA_LINEARLUT;


//this structure is different to defined in DCAM 
//however this structure can be passed from matlab to DCAM via relay dll
typedef struct R_DCAMBUF_ATTACH_ {
	int32		size;		// sizeof(*this)
	int32		iKind;		// DCAMBUF_ATTACHKIND
	void*		buffer;		// a combined buffer of all of the frames
	int32		buffercount;		// number of frames
} R_DCAMBUF_ATTACH;

typedef struct R_DCAMREC_FRAME_ {
	int32		size;		// sizeof(*this)
	int32		iKind;		// reserved
	int32		option;		// DCAMREC_FRAME_OPTION
	int32		iFrame;		// frame index
	void*		buf;		// pointer for top-left image
	int32		rowbytes;		// byte size for next line
	R_DCAM_PIXELTYPE		type;		// this member is reserved, set to 0  it is a _u32
	int32		width;		// horizontal pixel count
	int32		height;		// vertical line count
	int32		left;		// horizontal start pixel
	int32		top;		// vertical start line
	R_DCAM_TIMESTAMP		timestamp;		// time stamp
	int32		framestamp;		// frame stamp
	int32		camerastamp;		// camera stamp
} R_DCAMREC_FRAME;

typedef struct R_DCAMREC_OPEN_ {
	int32		size;		// sizeof(*this)
	int32		reserved;		//
	unsigned long long int		hrec;		// handle for dcamrec functions
	//TCHAR seems to cause issues
	const TCHAR*		path;		// destination path
	const TCHAR*		ext;		// extension of destination file
	int32		maxframepersession;		// maximum per session
	int32		userdatasize;		// user data size
	int32		userdatasize_session;		// user data size for session
	int32		userdatasize_file;		// user data size for file
	int32		usertextsize;		// user text size
	int32		usertextsize_session;		// user text size for session
	int32		usertextsize_file;		// user text size for file
} R_DCAMREC_OPEN;

typedef struct R_DCAM_METADATAHDR_ {
	int32		size;		// size of whole structure, not only this
	int32		iKind;		// DCAM_METADATAKIND (DCAMBUF_METADATAKIND or DCAMREC_METADATAKIND)
	int32		option;		// value meaning depends on DCAM_METADATAKIND
	int32		iFrame;		// frame index
} R_DCAM_METADATAHDR;

typedef struct R_DCAM_METADATABLOCKHDR_ {
	int32		size;		// size of whole structure, not only this
	int32		iKind;		// DCAM_METADATAKIND
	int32		option;		// value meaning depends on DCAMBUF_METADATAOPTION or DCAMREC_METADATAOPTION
	int32		iFrame;		// start frame index
	int32		in_count;		// max count of meta data
	int32		outcount;		// count of got meta data
} R_DCAM_METADATABLOCKHDR;

typedef struct R_DCAM_USERDATATEXT_ {
	R_DCAM_METADATAHDR		hdr;		// size member should be size of this structure
	void*		text;		// Text meta data
	int32		text_len;		// byte size of meta data
	int32		codepage;		// DCAM_CODEPAGE
} R_DCAM_USERDATATEXT;

typedef struct R_DCAM_USERDATABIN_ {
	R_DCAM_METADATAHDR		hdr;		// size member should be size of this structure
	void*		bin;		// binary meta data
	int32		bin_len;		// byte size of binary meta data
	int32		reserved;		// 0 reserved
} R_DCAM_USERDATABIN;

typedef struct R_DCAM_TIMESTAMPBLOCK_ {
	R_DCAM_METADATABLOCKHDR		hdr;		// size member should be size of this structure
	R_DCAM_TIMESTAMP*		timestamps;		// pointer for TIMESTAMP block
	int32		timestampsize;		// sizeof(DCAM_TIMESTAMP)
	int32		timestampvaildsize;		// return the written data size of DCAM_TIMESTAMP
	int32		timestampkind;		// return timestamp kind(Hardware, Driver, DCAM etc..)
	int32		reserved;		// 0 reserved
} R_DCAM_TIMESTAMPBLOCK;

typedef struct R_DCAM_FRAMESTAMPBLOCK_ {
	R_DCAM_METADATABLOCKHDR		hdr;		// size member should be size of this structure
	int32*		framestamps;		// pointer for frame stamp block
	int32		reserved;		// 0 reserved
} R_DCAM_FRAMESTAMPBLOCK;


typedef struct R_DCAM_METADATATEXTBLOCK_ {
	R_DCAM_METADATABLOCKHDR		hdr;		// size member should be size of this structure
	void*		text;		// array of pointer for user text metadata
	int32*		textsizes;		// array of pointer for sizes of user text metadata
	int32		bytesperunit;		// global size of text metadata
	int32		reserved;		// reserved
	int32*		textcodepage;		// code page for text
} R_DCAM_METADATATEXTBLOCK;

typedef struct R_DCAM_METADATABINBLOCK_ {
	R_DCAM_METADATABLOCKHDR		hdr;		// size member should be size of this structure
	void*		bin;		// array of pointers for user data
	int32*		binsizes;		// array of pointer for sizes of user binary metadata
	int32		bytesperunit;		// global size of binary metadata
	int32		reserved;		// reserved
} R_DCAM_METADATABINBLOCK;

typedef struct R_DCAMREC_STATUS_ {
	int32		size;		// sizeof(*this)
	int32		currentsession_index;		// current session index
	int32		maxframecount_per_session;		// maximum frame count per session
	int32		currentframe_index;		// current frame index
	int32		missingframe_count;		// missing frame count
	int32		flags;		// DCAMREC_STATUSFLAG
	int32		totalframecount;		// total frame count
	int32		reserved;		// reserved
} R_DCAMREC_STATUS;



