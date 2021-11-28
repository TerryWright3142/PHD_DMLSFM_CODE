function [err, DCAM_TIMESTAMP, nStampCount] = copy_metadata_timestamps( DCAM, hdcam, iStartFrame, DCAM_TIMESTAMP, nStampCount )

	tsb = C_DCAM_TIMESTAMPBLOCK_(DCAM.DCAMREC_METADATAKIND_TIMESTAMPS, nStampCount, iStartFrame, pStamps);
	[err, tsb] = DCAM.dcambuf_copymetadata( hdcam, tsb );
	if err < 0 
        nStampCount = 0;
		dcamcon_show_dcamerr( dcam, hdcam, err, 'dcambuf_copymetadata()');
    end	
	nStampCount = tsb.hdr.outcount;
end
