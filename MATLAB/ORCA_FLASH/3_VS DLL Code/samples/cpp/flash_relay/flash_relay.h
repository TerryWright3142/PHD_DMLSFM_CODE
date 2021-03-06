//#include "flash_constants.h"
#include "flash_structures.h"
/*
THIS IS A DEBUG DLL
IT TAKES THE PARAMETERS, PROCESSES THEM
AND THEN PASSES THEM ONTO THE ACTUAL
DCAMAPI.DLL
YOU CAN EXAMINE THE PARAMETERS TO MAKE SURE THAT
THEY ARE BEING SENT IN THE CORRECT FORM. ALSO YOU 
CAN EXAMINE THE RETURN PARAMETERS, MAKE SURE THAT THE CAMERA
IS BEHAVING AS IT SHOULD
*/


#ifdef FLASHRELAY_EXPORTS
#define FLASHRELAY_API __declspec(dllexport)
#else
#define FLASHRELAY_API __declspec(dllimport)
#endif


#ifdef __cplusplus
extern "C" {
#endif
	///

	FLASHRELAY_API void CreateMetaData(int number_of_metadata);
	FLASHRELAY_API void DeleteMetaData();
	FLASHRELAY_API void AttachMetaData(unsigned long long int hdcam, int number_of_metadata);
	FLASHRELAY_API void GetMetaData(unsigned long long int hdcam, int number_of_metadata, int32* frameID, int32* sec, int32* us);


	///
	FLASHRELAY_API R_DCAMERR Dcamapi_init(
		R_DCAMAPI_INIT* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamapi_uninit(bool bTest);
	FLASHRELAY_API R_DCAMERR Dcamdev_open(
		R_DCAMDEV_OPEN* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamdev_close(
		unsigned long long int hdcam,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamdev_getcapability(
		
		unsigned long long int hdcam,
		R_DCAMDEV_CAPABILITY* param,
		bool bTest
	);	
	FLASHRELAY_API R_DCAMERR Dcamdev_getstring(
		unsigned long long int hdcam,
		R_DCAMDEV_STRING* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamprop_getvalue(
		unsigned long long int h,
		int32 iProp,
		double* pValue,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcambuf_alloc(
		unsigned long long int h,
		int32 framecount,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcambuf_release(
		unsigned long long int h,
		int32 iKind,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcambuf_lockframe(
		unsigned long long int h,
		R_DCAMBUF_FRAME* pFrame,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamwait_open(
		R_DCAMWAIT_OPEN* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamwait_close(
		unsigned long long int hwait,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamcap_transferinfo(
		unsigned long long int h,
		R_DCAMCAP_TRANSFERINFO* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamcap_start(
		unsigned long long int h,
		int32 mode,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamcap_stop(
		unsigned long long int h,
		bool bTest
	);	
	FLASHRELAY_API R_DCAMERR Dcamwait_start(
		unsigned long long int h,
		R_DCAMWAIT_START* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamprop_getattr(
		unsigned long long int h,
		R_DCAMPROP_ATTR* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamprop_setvalue(
		unsigned long long int h,
		int32 iProp,
		double fValue,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamprop_setgetvalue(
		unsigned long long int h,
		int32 iProp,
		double* pValue,
		int32 option,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamprop_queryvalue(
		unsigned long long int h,
		int32 iProp,
		double* pValue,
		int32 option,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamprop_getnextid(
		unsigned long long int h,
		int32* pProp,
		int32 option,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamprop_getname(
		unsigned long long int h,
		int32 iProp,
		void* text,
		int32 textbytes,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamprop_getvaluetext(
		unsigned long long int h,
		R_DCAMPROP_VALUETEXT* param,
		bool bTest
	);	
	FLASHRELAY_API R_DCAMERR Dcamdev_setdata(
		unsigned long long int h,
		R_DCAMDATA_HDR* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamdev_getdata(
		unsigned long long int h,
		R_DCAMDATA_HDR* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcambuf_attach(
		unsigned long long int h,
		R_DCAMBUF_ATTACH* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcambuf_copyframe(
		unsigned long long int h,
		R_DCAMBUF_FRAME* pFrame,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcambuf_copymetadata(
		unsigned long long int h,
		R_DCAM_METADATAHDR* hdr,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamcap_status(
		unsigned long long int h,
		int32* pStatus,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamcap_firetrigger(
		unsigned long long int h,
		int32 iKind,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamcap_record(
		unsigned long long int h,
		unsigned long long int hrec,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamwait_abort(
		unsigned long long int h,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_open(
		R_DCAMREC_OPEN* param,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_close(
		unsigned long long int hrec,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_lockframe(
		unsigned long long int hrec,
		R_DCAMREC_FRAME* pFrame,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_copyframe(
		unsigned long long int hrec,
		R_DCAMREC_FRAME* pFrame,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_writemetadata(
		unsigned long long int hrec,
		R_DCAM_METADATAHDR* hdr,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_lockmetadata(
		unsigned long long int hrec,
		R_DCAM_METADATAHDR* hdr,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_copymetadata(
		unsigned long long int hrec,
		R_DCAM_METADATAHDR* hdr,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_lockmetadatablock(
		unsigned long long int hrec,
		R_DCAM_METADATABLOCKHDR* hdr,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_copymetadatablock(
		unsigned long long int hrec,
		R_DCAM_METADATABLOCKHDR* hdr,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_pause(
		unsigned long long int hrec,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_resume(
		unsigned long long int hrec,
		bool bTest
	);
	FLASHRELAY_API R_DCAMERR Dcamrec_status(
		unsigned long long int hrec,
		R_DCAMREC_STATUS* pStatus,
		bool bTest
	);
	
	
#ifdef __cplusplus
}
#endif





