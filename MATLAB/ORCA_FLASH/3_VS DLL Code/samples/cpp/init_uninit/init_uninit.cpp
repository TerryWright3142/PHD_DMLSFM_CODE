// console/init_uninit

#include "../misc/console4.h"
#include "../misc/common.h"

#define USE_INITOPTION	0	// set DCAMAPI_INITOPTION when the value isn't 0.
#define USE_INITGUID	0	// set GUID parameter when the value isn't 0.

#if USE_INITGUID
#include "../misc/dcamapix.h"
#endif

int main( int argc, char* const argv[] )
{

	printf( "PROGRAM START\n" );
	printf("HDCAM has size %d \n", sizeof(HDCAM));
	printf("void* has size %d \n", sizeof(void*));
	DCAMDEV_STRING	param;
	memset(&param, 0, sizeof(param));
	printf("sizeof(DCAMDEV_STRING param) %d \n", sizeof(param));
	int ret = 0;
	DCAMERR err;

	// initialize DCAM-API
	DCAMAPI_INIT	paraminit;
	memset( &paraminit, 0, sizeof(paraminit) );
	paraminit.size	= sizeof(paraminit);
	printf("sizeof(paraminit) %d   \n", sizeof(paraminit));

#if USE_INITOPTION
	// set option of initialization
	int32 initoption[] = {
							DCAMAPI_INITOPTION_APIVER__LATEST,
							DCAMAPI_INITOPTION_ENDMARK			// it is necessary to set as the last value.
						 };

	paraminit.initoption		= initoption;
	paraminit.initoptionbytes	= sizeof(initoption);
#endif

#if USE_INITGUID
	// set GUID parameter
	DCAM_GUID	guid = DCAM_GUID_MYAPP;

	paraminit.guid	= &guid;
#endif
	if (failed((DCAMERR)1))
	{
		printf("failed \n");
	}
	else
	{
		printf("succeeded \n");
	}
	
	err = dcamapi_init( &paraminit );
	if( failed(err) )
	{
		dcamcon_show_dcamerr( NULL, err, "dcamapi_init()" );
		ret = 1;
	}
	else
	{
		int32	nDevice = paraminit.iDeviceCount;
		printf( "dcamapi_init() found %d device(s).\n", nDevice );

		int32 iDevice;
		for( iDevice = 0; iDevice < nDevice; iDevice++ )
		{
			dcamcon_show_dcamdev_info( (HDCAM)iDevice );
		}
	}
	HDCAM
	// finalize DCAM-API
	dcamapi_uninit();	// recommended call dcamapi_uninit() when dcamapi_init() is called even if it failed.
	
	printf( "PROGRAM END\n" );
	return ret;
}