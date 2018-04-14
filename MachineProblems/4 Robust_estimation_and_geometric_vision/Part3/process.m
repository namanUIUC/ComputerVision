function [vpx, vpy, vpz, Horizon] = process(image, estimate, display)

if (estimate)
    vpz = getVanishingPoint(image, 'For getVanishingPoint Z (converging right side of img)');
    vpx = getVanishingPoint(image, 'For getVanishingPoint X (converging left side of img)');
    vpy = getVanishingPoint(image, 'For getVanishingPoint Y (converging vertically down of img)');
else
    vpz = [-200 215 1];
    vpx = [1300 225 1];
    vpy = [430 4680 1];
%     vpx = [-202 215 1]';
%     vpy = [1371 230 1]';
%     vpz = [503 4867 1]';
end

Horizon = getHorizon(image, vpx, vpy, vpz, display);

if (display)
    figure();
    imagesc(image);
    hold on;
    plot(vpx(1), vpx(2), 'r*');
    plot(vpy(1), vpy(2), 'r*');
    plot(vpz(1), vpz(2), 'r*');
    hold on;
    title('Displaying Vanishing Points');
end

end