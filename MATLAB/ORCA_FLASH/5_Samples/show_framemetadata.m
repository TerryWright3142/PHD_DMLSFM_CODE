

function err = show_framemetadata( hdcam, nAlloc )
    %check camera capability
	devcap = c_DCAMDEV_CAPABILITY_();

	[err, devcap] = DCAM.dcamdev_getcapability( hdcam, devcap );
	if( err < 0 )
        dcamcon_show_dcamerr( DCAM, hdcam, err, 'dcamdev_getcapability()' );
    end

	if bitand(devcap.capflag , DCAMDEV_CAPFLAG_TIMESTAMP)
        bTimestamp = true;
    else
        bTimestamp = false;
    end
    
	if bitand(devcap.capflag , DCAMDEV_CAPFLAG_FRAMESTAMP)
        bFramestamp	= true;
    else
        bFramestamp = false;
    end

	if( ~bTimestamp && ~bFramestamp )
        fprintf( 'camera does not support both timestamp and framestamp.\n' );
		return;
    end

	fprintf( 'Support:' );
	if( bTimestamp ),	fprintf( '\tTimestamp' ); end
	if( bFramestamp ),	fprintf( '\tFramestamp' ); end
	fprintf( '\n' );

	% transferinfo param
	transferinfo = C_DCAMCAP_TRANSFERINFO_();
	[err, transferinfo] = dcamcap_transferinfo( hdcam, transferinfo );
	if( err < 0 )
        dcamcon_show_dcamerr( DCAM, hdcam, err, 'dcamcap_transferinfo()' );
		return;
    end

	if( transferinfo.nFrameCount < 1 )
        printf( 'no image.\n' );
		return;
    end

    if transferinfo.nFrameCount <= nAlloc
        iStart = 0;
    else 
        iStart = transferinfo.nFrameCount - nAlloc;
        nFrame	= transferinfo.nFrameCount - iStart;

        if( bTimestamp )
            fprintf( '[TimeStamp]\n' );
            nStampCount = nFrame;
            pTimeStamp(nStampCount) = C_DCAM_TIMESTAMP_();

            [err, pTimeStamp, nStampCount] = copy_metadata_timestamps( hdcam, iStart, pTimeStamp, nStampCount ) ;
            if (err >= 0)
                for i = 1:nStampCount
                    fprintf( '%d:\t%d.%06d\n', iStart + i - 1, pTimeStamp(i).sec, pTimeStamp(i).microsec );
                end
            end

            clear pTimeStamp;
            fprintf( '\n' );
        end

        if( bFramestamp )

            fprintf( '[FrameStamp]\n' );
            nStampCount = nFrame;
            pFrameStamp(nStampCount) = int32(0);

            [err, pFrameStamp, nStampCount] = copy_metadata_framestamps(DCAM, hdcam, iStart, pFrameStamp, nStampCount );
            if( err >= 0)
                for  i = 1:nStampCount
                    fprintf( '%d:\t%d\n', iStart + i - 1, pFrameStamp(i) );
                end
            end

            clear pFrameStamp;
            fprintf( '\n');
        end
    end
end