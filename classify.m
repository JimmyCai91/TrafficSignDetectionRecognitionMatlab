function labels = classify( patches, is_model, class_model, num)
    if size(patches,2)
        %%% extract HoG features
        feats = zeros(size(patches,1),1764);
        for i=1:size(patches,1)
            imshow(patches{i});
            feature = double(extractHOGFeatures(patches{i}, 'CellSize', [8 8]));
            if max(feature) ~= min(feature)
                feature = (feature - min(feature))/(max(feature)-min(feature));
            end
            feats(i,:) = feature;
        end
        %%% svm classify
        labels = svmpredict(ones(size(patches,1),1), feats, is_model, '-q');
        fn = find(labels==1);
        labels(fn) = svmpredict(ones(length(fn),1), feats(fn,:), class_model, '-q');
        if num == -1
            labels(fn) = labels(fn)+4;
        end
    end
end

