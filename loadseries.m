function s=loadseries(path)
    s=[];
    
    fn = dir(path);
    for i=1:length(fn),
        if (numel(fn(i).name) > 4 && strcmp(fn(i).name(end-3:end), '.jpg'))
            img = imread([path, '/', fn(i).name]);
            if (numel(s) && size(img,1) ~= size(s,2))
                continue;
            end
            s(end+1,:,:) = img(:,:,1);
        end
    end
end
