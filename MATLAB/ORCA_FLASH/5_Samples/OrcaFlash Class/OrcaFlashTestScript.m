%% reset

imaqreset

%% find

imaqfind(vid)


%% set

set(vid)

%% adapters

imaqhwinfo('hamamatsu')

%% imaqtool

imaqtool

%%  


dev_info = imaqhwinfo('hamamatsu',1)



%% capture vid
vid = videoinput('hamamatsu',1, dev_info.DefaultFormat)

%% preview
preview(vid);

%% close

closepreview(vid);

%% capture
% Set video input object properties for this application.
vid.TriggerRepeat = 100;
vid.FrameGrabInterval = 5;
 %% 
% Set value of a video source object property.
vid_src = getselectedsource(vid);
vid_src.Tag = 'motion detection setup';

% Create a figure window.
figure; 

% Start acquiring frames.
start(vid)

% Calculate difference image and display it.
while(vid.FramesAvailable >= 2)
    data = getdata(vid,2); 
    diff_im = imabsdiff(data(:,:,:,1),data(:,:,:,2));
    imshow(diff_im);
    drawnow     % update figure window
end
%% 
stop(vid)


%% cleanup

delete(vid)
clear
close(gcf)