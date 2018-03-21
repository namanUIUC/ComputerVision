%% FUNCTION TO RETURN THE FILTER FOR GIVEN SIGMA
function [filter] = createFilter(sigma, type) 
    
    % Currently supporting LoG Filter
    switch type
        
        case 'log'
            logScale = sigma;
            filterBank = cell(numel(logScale),1);
            idx = 0;

            for scale = logScale
                idx = idx + 1;
                filter{idx} = scale^2*fspecial('log', 2*ceil(scale*2.5)+1, scale);
            end
            
        case 'gauss'
            
            logScale = sigma;
            filterBank = cell(numel(logScale),1);
            idx = 0;

            for scale = logScale
                idx = idx + 1;
                filter{idx} = scale*fspecial('gaussian', 2*ceil(scale*2.5)+1, scale);
            end
    end

end
