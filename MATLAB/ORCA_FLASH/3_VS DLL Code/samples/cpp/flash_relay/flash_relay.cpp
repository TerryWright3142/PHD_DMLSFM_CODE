// flash_relay.cpp : Defines the exported functions for the DLL application.
//

#include "stdafx.h"
#include "flash_relay.h"
#include "../misc/console4.h"
#include "../misc/common.h"
#include <string>
#include <sstream>
#include <iostream>
#include "support.h"

DCAM_TIMESTAMP*	timestamp_array = NULL;
int32* framestamp_array = NULL;
void attach_primary_framestampbuffer(HDCAM hdcam, int32* pFrameStamp, int32 framestamp_count)
{
	DCAMERR err;

	DCAMBUF_ATTACH	bufattach;
	memset(&bufattach, 0, sizeof(bufattach));

	bufattach.size = sizeof(bufattach);
	bufattach.iKind = DCAMBUF_ATTACHKIND_PRIMARY_FRAMESTAMP;
	bufattach.buffer = (void**)&pFrameStamp;
	bufattach.buffercount = framestamp_count;

	err = dcambuf_attach(hdcam, &bufattach);

}

void attach_primary_timestampbuffer(HDCAM hdcam, DCAM_TIMESTAMP* pTimeStamp, int32 timestamp_count)
{
	DCAMERR err;

	DCAMBUF_ATTACH	bufattach;
	memset(&bufattach, 0, sizeof(bufattach));

	bufattach.size = sizeof(bufattach);
	bufattach.iKind = DCAMBUF_ATTACHKIND_PRIMARY_TIMESTAMP;
	bufattach.buffer = (void**)&pTimeStamp;
	bufattach.buffercount = timestamp_count;

	err = dcambuf_attach(hdcam, &bufattach);
	
}

#ifdef __cplusplus
extern "C" {
#endif
	FLASHRELAY_API void CreateMetaData(int number_of_metadata) {
		//con("createmetadata", 0, 0);
		timestamp_array = new DCAM_TIMESTAMP[number_of_metadata];
		memset(timestamp_array, -1, sizeof(DCAM_TIMESTAMP) * number_of_metadata);

		framestamp_array = new int32[number_of_metadata];
		memset(framestamp_array, -1, sizeof(int32) * number_of_metadata);
	}
	FLASHRELAY_API void DeleteMetaData() {
		//con("deletemetadata", 0, 0);
		delete[] timestamp_array;
		timestamp_array = NULL;
		delete[] framestamp_array;
		framestamp_array = NULL;
	}
	FLASHRELAY_API void AttachMetaData(unsigned long long int hdcam, int number_of_metadata) {
		//con("attachmetadata", 0, 0);
		attach_primary_timestampbuffer((HDCAM)hdcam, timestamp_array, number_of_metadata);
		attach_primary_framestampbuffer((HDCAM)hdcam, framestamp_array, number_of_metadata);
	}
	FLASHRELAY_API void GetMetaData(unsigned long long int hdcam, int number_of_metadata, int32* frameID, int32* sec, int32* us) {
		DCAMERR err;
		DCAMCAP_TRANSFERINFO transinfo;
		memset(&transinfo, 0, sizeof(transinfo));
		transinfo.size = sizeof(transinfo);
		// get number of captured image
		err = dcamcap_transferinfo((HDCAM)hdcam, &transinfo);
		
		if (transinfo.nFrameCount < 1)
		{
			con("no image.\n", 0, 0);
			return;
		}
		int32 iStart = transinfo.nFrameCount - number_of_metadata;
		if (iStart < 0)
			iStart = 0;

		int i;
		for (i = iStart; i < transinfo.nFrameCount; i++)
		{
			int32 ind = i % number_of_metadata;

			frameID[ind] = framestamp_array[ind];
			sec[ind] = timestamp_array[ind].sec;
			us[ind] = timestamp_array[ind].microsec;
		}
	}


		
	FLASHRELAY_API R_DCAMERR Dcamapi_init(
		R_DCAMAPI_INIT* param,
		bool bTest
	) 
	{
		
		if (bTest) {
			//examine parameters


			param->iDeviceCount = 1; 
			return (R_DCAMERR)-1;
		}
		else {

			R_DCAMERR err = (R_DCAMERR)dcamapi_init((DCAMAPI_INIT*)param);
			return err;
		}
	}

	FLASHRELAY_API R_DCAMERR Dcamapi_uninit(bool bTest) {
		if (bTest) {
			return (R_DCAMERR)-1;
		}
		else {
			R_DCAMERR err = (R_DCAMERR)dcamapi_uninit();
			return err;
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamdev_open(
		R_DCAMDEV_OPEN* param,
		bool bTest
	) {
		if (bTest) {
			//examine parameters

			return (R_DCAMERR)-1;
		}
		else {
			R_DCAMERR err = dcamdev_open((DCAMDEV_OPEN*)param);
			return err;
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamdev_close(
		unsigned long long int hdcam,
		bool bTest
	) {
		if (bTest) {
			return (R_DCAMERR)-1;
		}
		else {
			R_DCAMERR err =  (R_DCAMERR)dcamdev_close((HDCAM)hdcam);
			return err;
		}
	}

	
	FLASHRELAY_API R_DCAMERR Dcamdev_getcapability(
		unsigned long long int hdcam,
		R_DCAMDEV_CAPABILITY* param,
		bool bTest
	) {
		if (bTest) {
			
			//examine parameters
			con("Dcamdev_getcapability", 0, 0);
			con(param->capflag, 0, 20);
			param->capflag = 555;
			con(param->capflag, 0, 40);
			return (R_DCAMERR)-1;
		}
		else {
			R_DCAMERR err =  (R_DCAMERR)dcamdev_getcapability((HDCAM)hdcam, (DCAMDEV_CAPABILITY*)param);
			return err;
		
		}
	}


	FLASHRELAY_API  R_DCAMERR  Dcamdev_getstring(
		unsigned long long int hdcam,
		R_DCAMDEV_STRING* param,
		bool bTest
	) {
		if (bTest) {
			return (R_DCAMERR)-1;
		}
		else {
			R_DCAMERR err =  (R_DCAMERR) dcamdev_getstring((HDCAM)hdcam, (DCAMDEV_STRING*) param);
			return err;
		}
	}

	FLASHRELAY_API R_DCAMERR Dcambuf_alloc(
		unsigned long long int h,
		int32 framecount,
		bool bTest
	) {
		if (bTest) {
			//examine parameters

			return (R_DCAMERR)-1;
		}
		else {
			return  (R_DCAMERR)dcambuf_alloc((HDCAM)h, framecount);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcambuf_release(
		unsigned long long int h,
		int32 iKind,
		bool bTest
	) {
		if (bTest) {
			//examine parameters

			return (R_DCAMERR)-1;
		}
		else {
			return  (R_DCAMERR)dcambuf_release((HDCAM)h, iKind);
		}
	}





	FLASHRELAY_API R_DCAMERR Dcamprop_getvalue(
		unsigned long long int h,
		int32 iProp,
		double* pValue,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("Dcamprop_getvalue", 0, 0);
			con(*pValue, 0, 20);
			*pValue = 333;
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamprop_getvalue((HDCAM)h, iProp, pValue);
		}
	}




	FLASHRELAY_API R_DCAMERR Dcambuf_lockframe(
		unsigned long long int h,
		R_DCAMBUF_FRAME* pFrame,
		bool bTest
	) {
		if (bTest) {
			//examine parameters


			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcambuf_lockframe((HDCAM)h, (DCAMBUF_FRAME*)pFrame);
		}
	}



	FLASHRELAY_API R_DCAMERR Dcamcap_start(
		unsigned long long int h,
		int32 mode,
		bool bTest
	) {
		if (bTest) {
			//examine parameters

			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamcap_start((HDCAM)h, mode);
		}
	}

	FLASHRELAY_API R_DCAMERR Dcamcap_stop(
		unsigned long long int h,
		bool bTest
	) {
		if (bTest) {
			//examine parameters

			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamcap_stop((HDCAM)h);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamcap_transferinfo(
		unsigned long long int h,
		R_DCAMCAP_TRANSFERINFO* param,
		bool bTest
	) {
		if (bTest) {
			//examine parameters

			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamcap_transferinfo((HDCAM)h, (DCAMCAP_TRANSFERINFO*)param);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamwait_open(
		R_DCAMWAIT_OPEN* param,
		bool bTest
	) {
	
		//this function has a HDCAM and will return a HWAIT
		if (bTest) {
			//examine parameters
			return (R_DCAMERR)-1;
		}
		else {
			R_DCAMERR err =  dcamwait_open((DCAMWAIT_OPEN*)param);
			return err;	
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamwait_close(
		unsigned long long int hwait,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamwait_close((HDCAMWAIT)hwait);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamwait_start(
		unsigned long long int h,
		R_DCAMWAIT_START* param,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamwait_start((HDCAMWAIT)h, (DCAMWAIT_START*)param);
		}
	}

	FLASHRELAY_API  R_DCAMERR Dcamdev_setdata(
		unsigned long long int h,
		R_DCAMDATA_HDR* param,
		bool bTest
	) {
		if (bTest) {
			//examine parameters

			con("dcamdev_setdata", 0, 0);
			con(param->iKind, 0, 20);
			con(param->option, 0, 40);
			con(param->reserved2, 0, 60);
			param->iKind = 1000;
			param->option = 2000;
			param->reserved2 = 3000;
			con(param->iKind, 0, 20);
			con(param->option, 0, 40);
			con(param->reserved2, 0, 60);

			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamdev_setdata((HDCAM)h, (DCAMDATA_HDR*)param);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamdev_getdata(
		unsigned long long int h,
		R_DCAMDATA_HDR* param,
		bool bTest
	) {
		if (bTest) {
			//examine parameters

			con("dcamdev_setdata", 0, 0);
			con(param->iKind, 0, 20);
			con(param->option, 0, 40);
			con(param->reserved2, 0, 60);
			param->iKind = 1000;
			param->option = 2000;
			param->reserved2 = 3000;
			con(param->iKind, 0, 20);
			con(param->option, 0, 40);
			con(param->reserved2, 0, 60);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamdev_getdata((HDCAM)h, (DCAMDATA_HDR*)param);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamprop_getattr(
		unsigned long long int h,
		R_DCAMPROP_ATTR* param,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("Dcamprop_getattr", 0, 0);
			con(param->valuedefault, 0, 20);
			param->valuedefault = 20.999;
			con(param->valuedefault, 0, 40);


			return (R_DCAMERR)-1;
		}
		else {
			return  (R_DCAMERR)dcamprop_getattr((HDCAM)h, (DCAMPROP_ATTR*)param);
		}
	}






	FLASHRELAY_API R_DCAMERR Dcamprop_setvalue(
		unsigned long long int h,
		int32 iProp,
		double fValue,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamprop_setvalue", 0, 0);
			con(iProp, 0, 20);
			con(fValue, 0, 40);

			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamprop_setvalue((HDCAM)h, iProp, fValue);
		}
	}

	FLASHRELAY_API R_DCAMERR Dcamprop_setgetvalue(
		unsigned long long h,
		int32 iProp,
		double* pValue,
		int32 option,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamprop_setgetvalue", 0, 0);
			con(iProp, 0, 20);
			con(*pValue, 0, 40);
			con(option, 0, 60);
			*pValue = 3.142;
			con(*pValue, 0, 80);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamprop_setgetvalue((HDCAM)h, iProp, pValue, option);
		}
	}

	FLASHRELAY_API R_DCAMERR Dcamprop_queryvalue(
		unsigned long long h,
		int32 iProp,
		double* pValue,
		int32 option,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamprop_queryvalue", 0, 0);
			con(iProp, 0, 20);
			con(*pValue, 0, 40);
			con(option, 0, 60);
			*pValue = 3.142;
			con(*pValue, 0, 80);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamprop_queryvalue((HDCAM)h, iProp, pValue, option);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamprop_getnextid(
		unsigned long long int h,
		int32* pProp,
		int32 option,
		bool bTest
	) {
		if (bTest) {
			con("Dcamprop_getnextid", 0, 0);
			con(*pProp, 0, 20);
			con(option, 0, 40);
			*pProp = 12345;
			con(*pProp,0,60);

			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamprop_getnextid((HDCAM)h, pProp, option);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamprop_getname(
		unsigned long long int h,
		int32 iProp,
		void* text,
		int32 textbytes,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			//examine parameters
			con("dcamprop_getname", 0, 0);
			con(iProp, 0, 20);
			con((char*)text, 0, 40);
			con(textbytes, 0, 60);
			char* textc = (char*)text;
			textc[0] = 'A';
			textc[1] = 'B';
			textc[2] = 'C';
			con(textc, 0, 80);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamprop_getname((HDCAM)h, iProp, (char*)text, textbytes);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamprop_getvaluetext(
		unsigned long long int h,
		R_DCAMPROP_VALUETEXT* param,
		bool bTest
	) {
		if (bTest) {
			con("dcamprop_getvaluetext", 0, 0);
			con(param->iProp, 0, 20);
			con((char*)param->text, 0, 40);
			con(param->textbytes, 0, 60);
			con(param->value, 0, 80);
			char* textc = (char*)param->text;
			textc[0] = 'A';
			textc[1] = 'B';
			textc[2] = 'C';
			con(textc, 0, 100);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamprop_getvaluetext((HDCAM)h, (DCAMPROP_VALUETEXT*)param);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcambuf_attach(
		unsigned long long int hdcam,
		 R_DCAMBUF_ATTACH* param,
		bool bTest
	) {
		if (bTest) {

			//examine parameters
			void**	pFrames = new void*[param->buffercount];
			int32 bufframebytes = 6; //from test matlab

			int		i;
			char* buf = (char*)param->buffer;
			for (i = 0; i < param->buffercount; i++)
			{
				pFrames[i] = buf + bufframebytes * i;
			}

			//now fill in some of the pFrames
			char* buf1 = (char*)pFrames[1];
			for (int ii = 0; ii < 6; ii++) {
				buf1[ii] = 111;
			}


			//this will attach the buffer to DCAM
			//pixels will be copied into the buffer
			return (R_DCAMERR)1;
		}
		else {
			//examine parameters
			void**	pFrames = new void*[param->buffercount];
			double fRet = 0;
			Dcamprop_getvalue(hdcam, DCAM_IDPROP_BUFFER_FRAMEBYTES, &fRet, false);
			int32 bufframebytes = (int32)fRet;

			int		i;
			char* buf = (char*)param->buffer;
			for (i = 0; i < param->buffercount; i++)
			{
				pFrames[i] = buf + bufframebytes * i;
			}

			DCAMBUF_ATTACH bufattach;
			memset(&bufattach, 0, sizeof(bufattach));
			bufattach.size = sizeof(bufattach);
			bufattach.iKind = DCAMBUF_ATTACHKIND_FRAME;
			bufattach.buffer = pFrames;
			bufattach.buffercount = param->buffercount;

			//this will attach the buffer to DCAM
			//pixels will be copied into the buffer
			return (R_DCAMERR)dcambuf_attach((HDCAM)hdcam, &bufattach);

		}
	}



	FLASHRELAY_API R_DCAMERR Dcambuf_copyframe(
		unsigned long long int h,
		R_DCAMBUF_FRAME* pFrame,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcambuf_copyframe", 0, 0);

			pFrame->buf = (void*) new int[5];
			for (int f = 0; f < 5; f++) {
				((int*)pFrame->buf)[f] = 4;
				con(((int*)pFrame->buf)[f], 0, 20 + 20 * f);
			}
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcambuf_copyframe((HDCAM)h, (DCAMBUF_FRAME*)pFrame);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcambuf_copymetadata(
		unsigned long long int h,
		R_DCAM_METADATAHDR* hdr,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcambuf_copymetadata", 0, 0);
			con(hdr->iFrame, 0, 20);
			con(hdr->iKind, 0, 40);
			con(hdr->option, 0, 60);
			hdr->iFrame = 1000;
			hdr->iKind = 2000;
			hdr->option = 3000;

			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcambuf_copymetadata((HDCAM)h, (DCAM_METADATAHDR*)hdr);
		}
	}

	FLASHRELAY_API R_DCAMERR Dcamcap_status(
		unsigned long long int h,
		int32* pStatus,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamcap_status", 0, 0);
			con(*pStatus, 0, 20);
			*pStatus = 2000;
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamcap_status((HDCAM)h, pStatus);
			
		}
	}




	FLASHRELAY_API R_DCAMERR Dcamcap_firetrigger(
		unsigned long long int h,
		int32 iKind,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamcap_firetrigger", 0, 0);
			con(iKind, 0, 20);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamcap_firetrigger((HDCAM)h, iKind);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamcap_record(
		unsigned long long int h,
		unsigned long long int hrec,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamcap_record", 0, 0);
			con((int)h, 0, 20);
			con((int)hrec, 0, 40);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamcap_record((HDCAM)h, (HDCAMREC)hrec);
		}
	}



	FLASHRELAY_API R_DCAMERR Dcamwait_abort(
		unsigned long long int h,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamwait_abort", 0, 0);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamwait_abort((HDCAMWAIT)h);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_open(
		R_DCAMREC_OPEN* param,
		bool bTest
	) {
		if (bTest) {
			con("dcamrec_open", 0, 0);
			con(param->userdatasize, 0, 20);
			param->userdatasize = 40;

			//examine parameters

			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_open((DCAMREC_OPEN*)param);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_close(
		unsigned long long int hrec,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamrec_close", 0, 0);
			return (R_DCAMERR)-1;
		}
		else {
			return  (R_DCAMERR)dcamrec_close((HDCAMREC)hrec);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_lockframe(
		unsigned long long int hrec,
		R_DCAMREC_FRAME* pFrame,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con(" dcamrec_lockframe", 0, 0);
			pFrame->buf = (void*) new int[5];
			for (int f = 0; f < 5; f++) {
				((int*)pFrame->buf)[f] = 6;
				con(((int*)pFrame->buf)[f], 0, 20 + 20 * f);
			}
			return (R_DCAMERR)-1;
		}
		else {
			return  (R_DCAMERR)dcamrec_lockframe((HDCAMREC)hrec, (DCAMREC_FRAME*)pFrame);
		}
	}

	FLASHRELAY_API R_DCAMERR Dcamrec_copyframe(
		unsigned long long int hrec,
		R_DCAMREC_FRAME* pFrame,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con(" dcamrec_copyframe", 0, 0);
			pFrame->buf = (void*) new int[5];
			for (int f = 0; f < 5; f++) {
				((int*)pFrame->buf)[f] = 6;
				con(((int*)pFrame->buf)[f], 0, 20 + 20 * f);
			}
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_copyframe((HDCAMREC)hrec, (DCAMREC_FRAME*)pFrame);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_writemetadata(
		unsigned long long int hrec,
		R_DCAM_METADATAHDR* hdr,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamrec_writemetadata", 0, 0);
			con(hdr->iFrame, 0, 20);
			con(hdr->iKind, 0, 40);
			con(hdr->option, 0, 60);
			hdr->iFrame = 1000;
			hdr->iKind = 2000;
			hdr->option = 3000;

			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_writemetadata((HDCAMREC)hrec, (DCAM_METADATAHDR*)hdr);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_lockmetadata(
		unsigned long long int hrec,
		R_DCAM_METADATAHDR* hdr,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamrec_lockmetadata", 0, 0);
			con(hdr->iFrame, 0, 20);
			con(hdr->iKind, 0, 40);
			con(hdr->option, 0, 60);
			hdr->iFrame = 1000;
			hdr->iKind = 2000;
			hdr->option = 3000;
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_lockmetadata((HDCAMREC)hrec, (DCAM_METADATAHDR*)hdr);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_copymetadata(
		unsigned long long int hrec,
		R_DCAM_METADATAHDR* hdr,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamrec_copymetadata", 0, 0);
			con(hdr->iFrame, 0, 20);
			con(hdr->iKind, 0, 40);
			con(hdr->option, 0, 60);
			hdr->iFrame = 1000;
			hdr->iKind = 2000;
			hdr->option = 3000;
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_copymetadata((HDCAMREC)hrec, (DCAM_METADATAHDR*)hdr);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_lockmetadatablock(
		unsigned long long int hrec,
		R_DCAM_METADATABLOCKHDR* hdr,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamrec_lockmetadatablock", 0, 0);
			con(hdr->iFrame, 0, 20);
			con(hdr->iKind, 0, 40);
			con(hdr->option, 0, 60);
			hdr->iFrame = 1000;
			hdr->iKind = 2000;
			hdr->option = 3000;
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_lockmetadatablock((HDCAMREC)hrec, (DCAM_METADATABLOCKHDR*)hdr);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_copymetadatablock(
		unsigned long long int hrec,
		R_DCAM_METADATABLOCKHDR* hdr,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamrec_copymetadatablock", 0, 0);
			con(hdr->iFrame, 0, 20);
			con(hdr->iKind, 0, 40);
			con(hdr->option, 0, 60);
			hdr->iFrame = 1000;
			hdr->iKind = 2000;
			hdr->option = 3000;
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_copymetadatablock((HDCAMREC)hrec, (DCAM_METADATABLOCKHDR*)hdr);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_pause(
		unsigned long long int hrec,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("damrec_pause", 0, 0);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_pause((HDCAMREC)hrec);
		}
	}


	FLASHRELAY_API R_DCAMERR Dcamrec_resume(
		unsigned long long int hrec,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("damrec_resume", 0, 0);
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_resume((HDCAMREC)hrec);
		}
	}

	FLASHRELAY_API R_DCAMERR Dcamrec_status(
		unsigned long long int hrec,
		R_DCAMREC_STATUS* pStatus,
		bool bTest
	) {
		if (bTest) {
			//examine parameters
			con("dcamrec_status", 0, 0);
			con(pStatus->currentframe_index, 0, 0);
			con(pStatus->currentsession_index, 0, 0);
			con(pStatus->flags, 0, 0);
			con(pStatus->maxframecount_per_session, 0, 0);
			con(pStatus->missingframe_count, 0, 0);

			pStatus->currentframe_index = 1000;
			pStatus->currentsession_index = 2000;
			return (R_DCAMERR)-1;
		}
		else {
			return (R_DCAMERR)dcamrec_status((HDCAMREC)hrec, (DCAMREC_STATUS*)pStatus);
		}
	}
 
#ifdef __cplusplus
}
#endif




