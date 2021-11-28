#pragma once
//#include "flash_constants.h"
#include "flash_structures.h"



#ifdef FLASHRELAY_EXPORTS
#define FLASHRELAY_API __declspec(dllexport)
#else
#define FLASHRELAY_API __declspec(dllimport)
#endif

#ifdef __cplusplus
extern "C" {
#endif
	FLASHRELAY_API R_DCAMERR dcamapi_init(
		R_DCAMAPI_INIT* param
	);

	FLASHRELAY_API R_DCAMERR dcamapi_uninit();

	FLASHRELAY_API R_DCAMERR dcamdev_open(
		R_DCAMDEV_OPEN* param
	);

	FLASHRELAY_API R_DCAMERR dcamdev_close(
		unsigned long long int hdcam
	);

	FLASHRELAY_API R_DCAMERR dcamdev_getcapability(
		unsigned long long int hdcam,
		R_DCAMDEV_CAPABILITY* param
	);

	FLASHRELAY_API R_DCAMERR dcamdev_getstring(
		unsigned long long int hdcam,
		R_DCAMDEV_STRING* param
	);

	FLASHRELAY_API R_DCAMERR dcamprop_getvalue(
		unsigned long long int h,
		int32 iProp,
		double* pValue
	);

	FLASHRELAY_API R_DCAMERR dcambuf_alloc(
		unsigned long long int h,
		int32 framecount
	);

	FLASHRELAY_API R_DCAMERR dcambuf_release(
		unsigned long long int h,
		int32 iKind
	);

	FLASHRELAY_API R_DCAMERR dcambuf_lockframe(
		unsigned long long int h,
		const R_DCAMBUF_FRAME* pFrame);

	FLASHRELAY_API R_DCAMERR dcamwait_open(
		R_DCAMWAIT_OPEN* param
	);

	FLASHRELAY_API R_DCAMERR dcamwait_close(
		unsigned long long int hwait
	);

	FLASHRELAY_API R_DCAMERR dcamcap_transferinfo(
		unsigned long long int h,
		R_DCAMCAP_TRANSFERINFO* param
	);

	FLASHRELAY_API R_DCAMERR dcamcap_start(
		unsigned long long int h,
		int32 mode);

	FLASHRELAY_API R_DCAMERR dcamcap_stop(
		unsigned long long int h);

	FLASHRELAY_API R_DCAMERR dcamwait_start(
		unsigned long long int h,
		R_DCAMWAIT_START* param);
	
	FLASHRELAY_API R_DCAMERR dcamdev_setdata(
	unsigned long long int h,
	R_DCAMDATA_HDR* param
	);

	FLASHRELAY_API R_DCAMERR dcamdev_getdata(
	unsigned long long int h,
	R_DCAMDATA_HDR* param
	);

	FLASHRELAY_API R_DCAMERR dcamprop_getattr(
	unsigned long long int h,
	R_DCAMPROP_ATTR* param
	);

	FLASHRELAY_API R_DCAMERR dcamprop_setvalue(
	unsigned long long int h,
	int32 iProp,
	double fValue
	);

	FLASHRELAY_API R_DCAMERR dcamprop_setgetvalue(
	unsigned long long int h,
	int32 iProp,
	double* pValue,
	int32 option
	);

	FLASHRELAY_API R_DCAMERR dcamprop_queryvalue(
	unsigned long long int h,
	int32 iProp,
	double* pValue,
	int32 option
	);

	FLASHRELAY_API R_DCAMERR dcamprop_getnextid(
	unsigned long long int h,
	int32* pProp,
	int32 option
	);

	FLASHRELAY_API R_DCAMERR dcamprop_getname(
	unsigned long long int h,
	int32 iProp,
	char* text,
	int32 textbytes
	);

	FLASHRELAY_API R_DCAMERR dcamprop_getvaluetext(
	unsigned long long int h,
	R_DCAMPROP_VALUETEXT* param
	);

	FLASHRELAY_API R_DCAMERR dcambuf_attach(
	unsigned long long int h,
	const R_DCAMBUF_ATTACH* param
	);

	FLASHRELAY_API R_DCAMERR dcambuf_copyframe(
	unsigned long long int h,
	R_DCAMBUF_FRAME* pFrame
	);

	FLASHRELAY_API R_DCAMERR dcambuf_copymetadata(
	unsigned long long int h,
	R_DCAM_METADATAHDR* hdr
	);

	FLASHRELAY_API R_DCAMERR dcamcap_status(
	unsigned long long int h,
	int32* pStatus
	);

	FLASHRELAY_API R_DCAMERR dcamcap_firetrigger(
	unsigned long long int h,
	int32 iKind
	);

	FLASHRELAY_API R_DCAMERR dcamcap_record(
	unsigned long long int h,
	unsigned long long int hrec
	);

	FLASHRELAY_API R_DCAMERR dcamwait_abort(
	unsigned long long int h
	);

	FLASHRELAY_API R_DCAMERR dcamrec_open(
	R_DCAMREC_OPEN* param
	);

	FLASHRELAY_API R_DCAMERR dcamrec_close(
	unsigned long long int hrec
	);

	FLASHRELAY_API R_DCAMERR dcamrec_lockframe(
	unsigned long long int hrec,
	R_DCAMREC_FRAME* pFrame
	);

	FLASHRELAY_API R_DCAMERR dcamrec_copyframe(
	unsigned long long int hrec,
	R_DCAMREC_FRAME* pFrame
	);

	FLASHRELAY_API R_DCAMERR dcamrec_writemetadata(
	unsigned long long int hrec,
	const R_DCAM_METADATAHDR* hdr
	);

	FLASHRELAY_API R_DCAMERR dcamrec_lockmetadata(
	unsigned long long int hrec,
	R_DCAM_METADATAHDR* hdr
	);

	FLASHRELAY_API R_DCAMERR dcamrec_copymetadata(
	unsigned long long int hrec,
	R_DCAM_METADATAHDR* hdr
	);

	FLASHRELAY_API R_DCAMERR dcamrec_lockmetadatablock(
	unsigned long long int hrec,
	R_DCAM_METADATABLOCKHDR* hdr
	);

	FLASHRELAY_API R_DCAMERR dcamrec_copymetadatablock(
	unsigned long long int hrec,
	R_DCAM_METADATABLOCKHDR* hdr
	);

	FLASHRELAY_API R_DCAMERR dcamrec_pause(
	unsigned long long int hrec
	);

	FLASHRELAY_API R_DCAMERR dcamrec_resume(
	unsigned long long int hrec
	);

	FLASHRELAY_API R_DCAMERR dcamrec_status(
	unsigned long long int hrec,
	R_DCAMREC_STATUS* pStatus
	);
	

#ifdef __cplusplus
}
#endif




