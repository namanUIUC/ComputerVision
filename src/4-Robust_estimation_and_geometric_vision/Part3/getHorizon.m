function horizon = getHorizon(image, vpx, vpy, vpz, display)

[~,flag] = max([norm(vpx), norm(vpy), norm(vpz)]);

if(flag == 1)
    
    horizon = real(cross(vpx', vpy'));
    length = sqrt(horizon(1)^2 + horizon(2)^2);
    horizon = horizon/length;
    
    if (display)
        figure();
        imagesc(image);
        hold on;
        plot([vpx(1) vpy(1)], [vpx(2) vpy(2)]);
        axis image;
        hold on;
        title('Displaying Horizon');
    end
end

if(flag == 2)
    
    horizon = real(cross(vpz', vpx'));
    length = sqrt(horizon(1)^2 + horizon(2)^2);
    horizon = horizon/length;
    
    if (display)
        figure();
        imagesc(image);
        hold on;
        plot([vpz(1) vpx(1)], [vpz(2) vpx(2)]);
        axis image;
        hold on;
        title('Displaying Horizon');
    end
end

if(flag == 3)
    
    horizon = real(cross(vpy', vpz'));
    length = sqrt(horizon(1)^2 + horizon(2)^2);
    horizon = horizon/length;
    
    if (display)
        figure();
        imagesc(image);
        hold on;
        plot([vpy(1) vpz(1)], [vpy(2) vpz(2)]);
        axis image;
        hold on;
        title('Displaying Horizon');
    end
end

end
