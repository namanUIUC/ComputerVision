function height = findHeight(image, info, data)
   
    vpx = info(1,:);
    vpy = info(2,:);
    vpz = info(3,:);
    horizon = info(4,:);
    b0 = [628 509 1];
    t0 = [628 465 1];
    H = 1.6764;
    height = zeros(size(data, 1), 1);
    
    
    for i = 1:size(data, 1)
        b = data(i, 1:3);
        r = data(i, 4:6);
        line1 = real(cross(b0', b'));
        v = real(cross(line1, horizon));
        v = v/v(3);

        line2 = real(cross(v', t0'));
        vertical_line = real(cross(r', b'));
        t = real(cross(line2', vertical_line'));
        t = t/t(3);
        
        
        height(i) = H*sqrt(sumsqr(r-b))*sqrt(sumsqr(vpz-t))/...
        sqrt(sumsqr(t-b))/sqrt(sumsqr(vpz-r));
    
        figure();
        imagesc(image);
        hold on;
        plot([vpz(1) vpx(1)], [vpz(2) vpx(2)]);
        plot([v(1) b0(1)], [v(2) b0(2)], '--r');
        plot([t0(1) b0(1)], [t0(2) b0(2)], '-r');
        plot([v(1) t0(1)], [v(2) t0(2)], '--r');
        plot([v(1) t(1)], [v(2) t(2)], '--g');
        plot([b(1) t(1)], [b(2) t(2)], '--g');
        plot([b(1) v(1)], [b(2) v(2)], '--g');
        plot([b(1) r(1)], [b(2) r(2)], '-y');
        plot(b(1),b(2),r(1),r(2),'*b')
        axis equal;
        axis image;
        hold on
        title(sprintf('Height Calculated is %s',num2str(height(i))));


        

    end
end