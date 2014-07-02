function m_extrac_hog( patches )
    
    features = [];
    for i=1:size(imgs,1)
        imi = imgs(i).name;
        if length(imi)<4
            continue;
        end
        t = lower(imi(end-2:end));
        if ~(strcmp(t,'jpg'))
            continue;
        end
        filename = strcat(path,'\',lower(imi));
        img = imread(filename);
        feature = extractHOGFeatures(img, 'CellSize', [8 8]);
        features = [features; feature]; 
    end
    savepath = strcat('./','GMSB.mat');
    save(savepath, 'features');
    
    
% % % --- end ---
    load chirp;
    sound(y,Fs);
    
end



