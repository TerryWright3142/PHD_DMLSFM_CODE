
function err =  show_metadata_information( DCAM, hdcam, number_of_metadata, DCAM_TIMESTAMP_PTR, framestamp_array )

    err = 0;
    transinfo = DCAMCAP_TRANSFERINFO();
    [err, transinfo] = DCAM.dcamcap_transferinfo( hdcam, transinfo );
    if (err < 0)
        DCAM.dcamcon_show_dcamerr( hdcam, err, 'dcamcap_transferinfo()' );
        return;
    end
    if ( transinfo.nFrameCount < 1 )
        fprintf( "no image.\n" );
        return;

    end
    iStart = transinfo.nFrameCount - number_of_metadata;
    if( iStart < 0 )
        iStart = 0;
        fprintf( "index\tframe stamp\ttime stamp\n" );
        for i = iStart : (transinfo.nFrameCount-1)
            ind = i % number_of_metadata;
            fprintf( "%d\t%d\t%d.%06d\n", i, framestamp_array(ind), timestamp_array(ind).sec, timestamp_array(ind).microsec );
        end
    end
end