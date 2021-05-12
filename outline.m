function outline = outline(matrix,minVar)
    matrix = FixMatrix(matrix);
    minMatrix = min(matrix(:));
    maxMatrix = max(matrix(:));
    delta = maxMatrix-minMatrix;
    interval = delta * minVar/100;
    
    sizes = size(matrix);
    
    height = sizes(1);
    length = sizes(2);
    
    dots = zeros(0, 2);
    
    p = 1;
    
    for i=2:height-1 %rows
        for j=2:length-1 %columns
            diffs = zeros(1,8);
            diffs(1) = abs(matrix(i, j) - matrix(i-1, j)); %top
            diffs(2) = abs(matrix(i, j) - matrix(i+1, j)); %bot
            diffs(3) = abs(matrix(i, j) - matrix(i, j-1)); %left
            diffs(4) = abs(matrix(i, j) - matrix(i, j+1)); %right
            diffs(5) = abs(matrix(i, j) - matrix(i-1, j-1)); %topleft
            diffs(6) = abs(matrix(i, j) - matrix(i-1, j+1)); %topright
            diffs(7) = abs(matrix(i, j) - matrix(i+1, j-1)); %botleft
            diffs(8) = abs(matrix(i, j) - matrix(i+1, j+1)); %botright
            if max(diffs) >= interval
                newm(i,j) = 1;
                dots = [dots; [j i]];
                p = p + 1;
            end
        end
    end
    
    plot(dots(:,1),dots(:,2),'.');
    hold on
    coefficients = EllipseDirectFit(dots);
    f = @(x,y) coefficients(1)*x.^2 + coefficients(2)*x.*y + coefficients(3)*y.^2 + coefficients(4)*x + coefficients(5)*y + coefficients(6);
    fimplicit(f, [0 length 0 height]);
    
    hold off
    outline = dots;
end

