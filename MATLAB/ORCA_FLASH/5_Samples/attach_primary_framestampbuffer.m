
function err =  attach_primary_framestampbuffer(DCAM, hdcam, pFrameStamp, framestamp_count )

    err = 0;
	bufattach = DCAMBUF_ATTACH(DCAM.DCAMBUF_ATTACHKIND_PRIMARY_FRAMESTAMP, pFrameStamp, framestamp_count) ;

	[err, bufattach] = DCAM.dcambuf_attach( hdcam, bufattach );
	if( err < 0 )
		dcamcon_show_dcamerr( hdcam, err, "dcambuf_attach()", "KIND=PRIMARY_FRAMESTAMP" );
    end
end
