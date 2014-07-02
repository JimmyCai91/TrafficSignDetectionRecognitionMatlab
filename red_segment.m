% % %  最终版，之后所有的分类器训练都
% % % % 在这个检测的基础上进行
function new_s = red_segment( h, s, v )
% img = imread('.\img\22.jpg');
% [h, s, v] = rgb2hsv_fast(img);
% hsv = rgb2hsv(img);
% h = hsv(:,:,1);
% s = hsv(:,:,2);
% v = hsv(:,:,3);
% [h, s, v] = rgb2hsv_fast(img,'signle');
% img_seg = ( h >0.81 | ( h > 0.01 & h < 0.06))&(s > 0.1)&( v > 0.15 & v < 0.8 );
img_seg = ( h >0.91 | ( h > 1e-5 & h < 0.035))&(s > 0.22)&( v > 0.15);
% subplot(1,2,1); imshow(img);
% subplot(1,2,2); imshow(img_seg);
% % % se = strel('disk',3);
% % % img_seg = imdilate(img_seg,se);
s = regionprops(img_seg, 'BoundingBox');
% imshow(img); hold on;
new_s = cell(1,0); j = 1;
for i = 1:length(s)
% % %     这里使用的交通标志大小的限定是根据经验而定的
% % % %     在其他视频中使用时，需要根据视频的分辨率适当调整参数
    if s(i).BoundingBox(3) > 30 && ...
            s(i).BoundingBox(4) > 30 && ...
            s(i).BoundingBox(3) < 130 && ...
            s(i).BoundingBox(4) < 130 && ...
            s(i).BoundingBox(3)/s(i).BoundingBox(4) < 1.2 && ...
            s(i).BoundingBox(4)/s(i).BoundingBox(3) < 1.2
        p_seg_img = imcrop(img_seg, s(i).BoundingBox);
        if sum(sum(p_seg_img))/(s(i).BoundingBox(3)*s(i).BoundingBox(4)) < 0.47
%             rect_H = rectangle('Position', s(i).BoundingBox, 'LineWidth', 2);
%             set(rect_H, 'EdgeColor', [0,0,1]); 
            new_s{j} = s(i); j = j+1;
        end
    end
end
% hold off;
% end
