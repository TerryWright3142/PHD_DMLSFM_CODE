function  err = attach_primary_timestampbuffer (DCAM, hdcam, DCAM_TIMESTAMP, timestamp_count )
	err = 0;
    %pass an array of buffers to fill - usual issues
	bufattach = DCAMBUF_ATTACH(DCAM.DCAMBUF_ATTACHKIND_PRIMARY_TIMESTAMP, DCAM_TIMESTAMP, timestamp_count) ;
	[err, bufattach] = DCAM.dcambuf_attach( hdcam, bufattach );
	if( err < 0 )
		DCAM.dcamcon_show_dcamerr( hdcam, err, "dcambuf_attach()", "KIND=PRIMARY_TIMESTAMP" );
    end
end