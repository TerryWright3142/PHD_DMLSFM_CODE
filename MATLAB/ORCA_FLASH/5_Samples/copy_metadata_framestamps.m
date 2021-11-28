
function [err, pStamp, nStampCount] = copy_metadata_framestamps(DCAM, hdcam, iStartFrame, pStamp, nStampCount )

	fsb = C_DCAM_FRAMESTAMPBLOCK_(DCAM.DCAMREC_METADATAKIND_FRAMESTAMPS,nStampCount,iStartFrame,pStamp) ;	
	[err, fsb]  = DCAM.dcambuf_copymetadata( hdcam, fsb );
	if( err < 0 )
        nStampCount = 0;
		dcamcon_show_dcamerr( DCAM, hdcam, err, 'dcambuf_copymetadata()' );
    end

	nStampCount = fsb.hdr.outcount;

end