
function err =  attach_framestampbuffer( DCAM, hdcam, pFrameStamp, framestamp_count )
err = 0;
bufattach = DCAMBUF_ATTACH(DCAM.DCAMBUF_ATTACHKIND_PRIMARY_FRAMESTAMP, pFrameStamp, framestamp_count) ;


	err = DCAM.dcambuf_attach( hdcam, bufattach );
	if( err < 0 )
		dcamcon_show_dcamerr( hdcam, err, "dcambuf_attach()", "KIND=FRAMESTAMP" );
    end
end
