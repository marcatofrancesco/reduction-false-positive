% noFace si popolerà con gli indici delle immagini ritenuti non volti dai
% seguenti criteri
% falseNegative sono immagini ritenute non volti dal fit ma che in realtà sono
% volti

noFace = [];
counter =1;
falseNegative = [];
gg = 1;
% ho fatto solo le prime 1000 immagini per comodità
%controllo le prime 1000 immagini dal label 2 (solo faccia)
for i = 1:1000
    
    matrix = DepthDATA{i}{2};
    maxMatrix = max(matrix(:));
    testMedia = matriceMedia(matrix, maxMatrix);
    matrixCenter = round(size(testMedia, 1)/2);
    centralrow = testMedia(matrixCenter,:);

    x = transpose(1:size(centralrow, 2));
    y = transpose(centralrow);
    
    f=fit(x,y,'poly2');
    %plot(f,x,y) 
    coefficientValues = coeffvalues(f);
    %if coefficientValues(2)>0.1     vecchio metodo (buono ma senza senso)
    vertice = -coefficientValues(2)/(2*coefficientValues(1));  %vertice della parabola
    if (vertice<0 || vertice>size(testMedia, 1)) % controllo che il vertice sia interno all'immagine
        noFace(counter) = i;
        counter = counter +1;
        if DepthDATA{i}{8} == 0.5
            falseNegative(gg) = i;
            gg = gg+1;
        end
    end
end

