function [residual1, residual2] = Triangulation( P1, P2, matches, display)
    %% PARAMETERS AND INITIALIZATION
    N = size(matches,1);
    triangulation = zeros(N, 3);
    imageProjection1 = zeros(N, 2);
    imageProjection2 = zeros(N, 2);
    
    %% CAMERA CENTERS
    C1 = findCameraCenter(P1);
    C2 = findCameraCenter(P2);
    
    %% CARTESIAN COORDINATES TO HOMOGENEOUS
    x1 = homogeneousConverter(matches(:,1:2));
    x2 = homogeneousConverter(matches(:,3:4));
    
    %% POINTWISE TRIANGULATION
    for i=1:N
        point1 = x1(i,:);
        point2 = x2(i,:);
        
        axb1 = [0, -point1(3), point1(2); point1(3), 0, -point1(1); -point1(2), point1(1), 0];
        axb2 = [0, -point2(3), point2(2); point2(3), 0, -point2(1); -point2(2), point2(1), 0];
        
        M = [axb1*P1; axb2*P2];
        [~,~,V] = svd(M);
        homogeneousTriangulation = V(:,end)';
        
        triangulation(i,:) = nonhomogeneousConverter(homogeneousTriangulation);
        imageProjection1(i,:) = nonhomogeneousConverter((P1 * homogeneousTriangulation')');
        imageProjection2(i,:) = nonhomogeneousConverter((P2 * homogeneousTriangulation')');
        
    end
    
    %% 3D VISUALIZATION OF THE GRAPH
    if (display)
        figure; axis equal;  hold on;
        plot3(-triangulation(:,1), triangulation(:,2), triangulation(:,3), 'or');
        plot3(-C1(1), C1(2), C1(3),'sb');
        plot3(-C2(1), C2(2), C2(3),'sg');
        xlabel('X axis'); ylabel('Y axis'); zlabel('Z axis');
        hold on
        str = 'Camera : 1';
        t = text(-C1(1), C1(2), C1(3), str, 'HorizontalAlignment','left');
        t.FontSize = 10;
        hold on
        str = 'Camera : 2';
        t = text(-C2(1), C2(2), C2(3), str, 'HorizontalAlignment','left');
        t.FontSize = 10;
    end
    
    %% RESIDUALS
    distances1 = diag(dist2(matches(:,1:2), imageProjection1));
    residual1 = mean(distances1);
    distances2 = diag(dist2(matches(:,3:4), imageProjection2));
    residual2 = mean(distances2);
end