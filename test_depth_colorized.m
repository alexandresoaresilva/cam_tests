addpath('+realsense');
% pipe = realsense.pipeline();
% Make Colorizer object to prettify depth output

% profile = pipe.stop();
% colorizer = realsense.colorizer();
% Start streaming on an arbitrary camera with default settings



% Get streaming device's name

pipe = realsense.pipeline();

profile = pipe.start();
dev = profile.get_device();
name = dev.get_info(realsense.camera_info.name);

% 0 to 43 options
option = realsense.option(uint64(2)); %enum for options
no_of_parameters = length(string(enumeration(option))); %number of elements : 0-43
opt = realsense.options(uint64(2));
opt.supports_option
        % Get frames. We discard the first couple to allow
    % the camera time to settle
for i = 1:5
    fs = pipe.wait_for_frames();
end
% 
% a = realsense.librealsense_mex('rs2::options','supports#rs2_option',...
%                                     opt.objectHandle,...
%                                     int64(option));

% video_frame.
while(1)
    % Select depth frame
%     depth_frame = fs.get_depth_frame();
    RGB_frame = fs.get_color_frame();
    % Colorize depth frame
%     depth_color = colorizer.colorize(depth_frame);
%     RGB_color = colorizer.colorize(color_frame);
    % Get actual data and convert into a format imshow can use
    % (Color data arrives as [R, G, B, R, G, B, ...] vector)
%     data_depth = depth_color.get_data();
    data_RGB = RGB_frame.get_data();
    
%     img = permute(reshape(data',[3,depth_color.get_width(),depth_color.get_height()]),[3 2 1]);
    img = permute(reshape(data_RGB',[3,RGB_frame.get_width(),RGB_frame.get_height()]),[3 2 1]);
    imshow(img);
    drawnow        
    title(sprintf("Colorized depth frame from %s", name));
    fs = pipe.wait_for_frames();
end
