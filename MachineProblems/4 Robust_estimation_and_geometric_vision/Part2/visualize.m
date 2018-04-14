function visualize(I1,I2,matches)
    figure; 
    imshow([I1 I2]); 
    hold on; 
    plot(matches(:,1),matches(:,2),'ys'); 
    plot(matches(:,3) + size(I1,2), matches(:,4), 'ys'); 
    hold on; 
    title('Corners');
    
    
    figure; 
    imshow([I1 I2]); hold on;
    plot(matches(:,1), matches(:,2), 'ys');
    plot(matches(:,3)+size(I1,2), matches(:,4), 'ys');
    line([matches(:,1) matches(:,3) + size(I1,2)]', matches(:,[2 4])', 'Color', 'r');
    hold on; 
    title('Matches');
end