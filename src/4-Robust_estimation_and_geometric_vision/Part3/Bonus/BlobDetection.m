function BlobDetection(image, Sigma, ScaleStep, threshold, method, implementation, time)
    
%% HYPER PARAMETERS
    
    color = 'red';      % color of circles
    k=2^(0.5);              % Scaling Parameter                             
    batch = 7;              % Number of Neighbors
    showlevel = 0;          % Display plot for different levels 
    estimate = false;
    display = false;
    
	
%% SPACE SCALE CREATION
	
    [h,w,channel]=size(image);

    % Original filter response
    Original_SS = zeros(h,w,ScaleStep);
    
    % Batch Maximum preprocessing (ordfilt2)
	NonMaxSup_SS = zeros(h,w,ScaleStep);
    
    %Filter responses after non-maximum suppression
	Best_SS = zeros(h,w,ScaleStep);
	
%% IMAGE FORMATING
    
    image = format_image(image,channel);
	if time
		tic
    end
    
%% BLOB ALGORITHM
    switch method
        case 'Up'
            color = 'magenta';
            for i=1:ScaleStep
                [NonMaxSup_SS(:,:,i),Original_SS(:,:,i)] = batch_max_preprocess(image,Sigma*k^(i-1),batch, implementation);

                if (~time)
                    visualization(NonMaxSup_SS(:,:,i),i,Sigma*k^(i-1))
                end
            end


        case 'Down'
            
            for i=1:ScaleStep

                [NonMaxSup_SS(:,:,i),Original_SS(:,:,i)] = image_py_preprocess(image,Sigma,batch,i,k, implementation);

                if (~time)
                    visualization(NonMaxSup_SS(:,:,i),i,Sigma)
                end

            end
        otherwise
            if (implementation == 1)
                return;
            end
            fprintf('Error, Incorrect method! Terminating!\n')
            exit;
    end

    if (implementation == 0)
        % Brute Force
        % Applying Non Max Best fit
        for i=1:h
            for j=1:w
                [value,indx]=max(NonMaxSup_SS(i,j,:));
                Best_SS(i,j,indx)=value;
            end
        end
        Best_SS = Best_SS .* (Best_SS == Original_SS);

    else

%         for i = 1:ScaleStep
%             if i==1
%                 NonMaxSup_SS(:,:,i) = max(NonMaxSup_SS(:,:,1:i+1),[],3);
%             elseif i==ScaleStep
%                 NonMaxSup_SS(:,:,i) = max(NonMaxSup_SS(:,:,i-1:i),[],3);
%             else
%                 NonMaxSup_SS(:,:,i) = max(NonMaxSup_SS(:,:,i-1:i+1),[],3);
%             end
%             % Scale_Space(x,y,i)=g(x,y,er(x,y));
%         end
%         Best_SS=NonMaxSup_SS;

    end

    % Get Circles From Best Fit
    [X,Y,R] = get_circles(Best_SS, threshold, Sigma, k);
    data = get_pixelTopBottom(X,Y);
    [vpx, vpy, vpz, Horizon] = process(image, estimate, display);
    processed = [reshape(vpx,1,3); reshape(vpy,1,3); reshape(vpz,1,3); reshape(Horizon,1,3)];
    H = findHeight(image, processed ,data);
    if time
        toc
    end
    
%% DISPLAY RESULTS
    
	imshow(image); 
	truesize;

    if showlevel == 1
        
        color = {'red','magenta','cyan','green','blue','yellow'};
        val = {1,1.2,1.4,1.6,1.8,2};
        indx = discretize(R,6);
        for i=1:size(indx,1)
            line(X(i,:), Y(i,:), 'Color', color{indx(i)}, 'LineWidth', 1.5*val{indx(i)});
            hold on;
        end
        for i=1:size(H,1)
            str = ['H : ',num2str(H(i))];
            t = text(data(i,1),data(i,2),str, 'HorizontalAlignment','left');
            t.FontSize = 10;
            t.Color = 'w';
            hold on;
        end
        
    else
        
        line(X', Y', 'Color', color, 'LineWidth', 1.5);
        for i=1:size(H,1)
            str = ['H : ',num2str(H(i))];
            t = text(data(i,1),data(i,2),str, 'HorizontalAlignment','left');
            t.FontSize = 8;
            t.Color = 'w';
            hold on;
        end
    end
    
	title(sprintf('Blobs: %d , threshold: %0.3f , sigma: %0.1f , scale-space size: %d',size(X,1), threshold, Sigma, ScaleStep));
	fprintf('%d Blobs printed per ScaleStep', size(X,1));
end