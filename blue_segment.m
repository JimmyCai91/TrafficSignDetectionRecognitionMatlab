function new_s = blue_segment(h,s,v)

%     amx = 2.1;  amn = 1.1;
%     bmx = 12.0; bmn = 1.4;
%     rmx = 7.5;  rmn = 1.4;
%     a = img(:,:,3) > amn*img(:,:,2) & img(:,:,3) < amx*img(:,:,2);
%     b = img(:,:,3) > bmn*img(:,:,1) & img(:,:,3) < bmx*img(:,:,1);
%     c = img(:,:,2) > rmn*img(:,:,1) & img(:,:,2) < rmx*img(:,:,1);
%     img_seg = a & b & c; 
    img_seg = ( h > 0.54 & h < 0.65 ) & (s > 0.3) & (v > 0.2);
% % %     imshow(img_seg);
    s = regionprops(img_seg, 'BoundingBox');
%     imshow(img); hold on;
    new_s = cell(1,0); j = 1;
    for i = 1:length(s)
        if s(i).BoundingBox(3) > 20 && s(i).BoundingBox(4) > 20 ...
                && s(i).BoundingBox(3) < 100 && s(i).BoundingBox(4) < 100 ...
                && s(i).BoundingBox(3)/s(i).BoundingBox(4) < 1.1 ...
                && s(i).BoundingBox(4)/s(i).BoundingBox(3) < 1.4
%             rect_H = rectangle('Position', s(i).BoundingBox, 'LineWidth', 2);
%             set(rect_H, 'EdgeColor', [0,0,1]); 
              new_s{j} = s(i); j = j+1;
        end
    end; 
%     hold off;
% % %       subplot(1,2,1); imshow(img);
% % %       subplot(1,2,2); imshow(img_seg);
end

