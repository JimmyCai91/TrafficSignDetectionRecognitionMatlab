% addpath('..\mmread\');
% 
tags = {'bike','bikeHere','here','car','lim4M','lim40',...
    'lim80','noCar','noPark','notruck'};
load ..\svm_model\final_model model;
is_model = model;
load ..\svm_model\Red_BJ model;
red_model = model;
load ..\svm_model\Blue_BJ model;
blue_model = model;
% 
% video = mmread('..\video.wmv',1);
% numFrames = -video.nrFramesTotal;
% load ..\video.mat;

% for i = 68:167  % blue
% for i = 1:68 % red
for i = 1:1000
% for i = 50:numFrames
%     video = mmread('..\video.wmv',i);
    %%% image size is 405*720
    img = imresize(video.frames(i).cdata, [1080*0.75 1440]);
    tic;
    %%% rgb2hsv
    hsv = ndrgb2hsv(double(img));
    %%% detection
    blue_s = blue_segment(hsv(:,:,1), hsv(:,:,2), hsv(:,:,3)); 
    red_s = red_segment(hsv(:,:,1), hsv(:,:,2), hsv(:,:,3));
    %%% get detected patch
    blue_labels = []; red_labels = [];
    if size(blue_s,1) && size(blue_s,2)
        blue_patches = get_patch(img,blue_s);
        blue_labels = classify( blue_patches, is_model, blue_model, 1);
    end
    if size(red_s,1) && size(red_s,2)
        red_patches = get_patch(img,red_s);
        red_labels = classify( red_patches, is_model, red_model, -1 );
    end
    labels = [red_labels;blue_labels];
    reg_s = [red_s blue_s];
    %%% draw detected sign
    if size(reg_s,1) && size(reg_s,2)
        imshow(img); hold on;
        fn = find(labels>-1);
        for j = 1:length(fn)
            rect_H = rectangle('Position', reg_s{fn(j)}.BoundingBox, 'LineWidth', 2);
            set(rect_H, 'EdgeColor', [0,0,1]);
            text(reg_s{fn(j)}.BoundingBox(1)+reg_s{fn(j)}.BoundingBox(3),...
                    reg_s{fn(j)}.BoundingBox(2)+reg_s{fn(j)}.BoundingBox(4),...
                    tags{labels(fn(j))}, 'FontSize', 20, 'FontWeight', 'Bold',...
                    'Color', [0 0 1]);
        end
        hold off;
    else
        imshow(img);
    end
    toc;
    drawnow;
%     pause; 
end