function  height_map = get_surface(surface_normals, image_size, method)
% surface_normals: 3 x num_pixels array of unit surface normals
% image_size: [h, w] of output height map/image
% height_map: height map of object

    
%% <<< fill in your code below >>>

    switch method
        case 'column'
            tic
            p = surface_normals(1,:,1)./surface_normals(1,:,3);
            p(1) = 0;
            h_row = cumsum(p);
            q = surface_normals(2:image_size(1),:,2)./surface_normals(2:image_size(1),:,3);
            height_map = cumsum(cat(1,h_row,q));
            toc
        case 'row'
            tic
            q = surface_normals(:,1,2)./surface_normals(:,1,3);
            q(1) = 0;
            h_col = cumsum(q);
            p = surface_normals(:,2:image_size(2),1)./surface_normals(:,2:image_size(2),3);
            height_map = cumsum(cat(2,h_col,p),2);
            toc
        case 'average'
            tic
            p = surface_normals(1,:,1)./surface_normals(1,:,3);
            p(1) = 0;
            h_row = cumsum(p);
            q = surface_normals(2:image_size(1),:,2)./surface_normals(2:image_size(1),:,3);
            height_map1 = cumsum(cat(1,h_row,q));
            q = surface_normals(:,1,2)./surface_normals(:,1,3);
            q(1) = 0;
            h_col = cumsum(q);
            p = surface_normals(:,2:image_size(2),1)./surface_normals(:,2:image_size(2),3);
            height_map2 = cumsum(cat(2,h_col,p),2);
            height_map = (height_map1+height_map2)/2;
            toc
        case 'random'
            tic 
            n = 50;
            height = image_size(1);
            width = image_size(2);
            height_map = zeros(height,width);
            p = surface_normals(:,:,1)./surface_normals(:,:,3);
            q = surface_normals(:,:,2)./surface_normals(:,:,3);
            for row = 1:height
                for col =1:width
                    if (row ==1 && col ==1)
                        height_map(row, col) = 0;
                    else
                        for i = 1:n
                            csum = 0;
                            count = 1;
                            
                            R = randi(2, row+col, 1);
                            
                            w=1;
                            h=1;
                            
                            while(w<col || h<row)
                                if w>=col
                                    R(count)=2;
                                end
                                
                                if h>=row
                                    R(count)=1;
                                end
                                
                                if R(count) == 1
                                    csum = csum + p(h,w);
                                    w=w+1;
                                else
                                    csum = csum + q(h,w);
                                    h=h+1;
                                end
                                
                                count=count+1;
                            end
                            height_map(row,col) = height_map(row,col)+csum;
                        end
                        
                        height_map(row,col) = height_map(row,col)/n;
                    end
                end
            end
            toc
    end

end

