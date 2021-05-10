hold on
nFacce = 0;
nNonFacce = 0;
maxG = 300
maxR = 300
plot3(NaN, NaN, NaN, 'g.');
plot3(NaN, NaN, NaN, 'r.');
for i = 1:1000
    i
    map = nPixels(matriceMedia(DepthDATA{i}{3}, NaN), 2, 100);
    key = cell2mat(keys(map))';
    value = cell2mat(values(map))';
    ids = i*ones(size(key,1),1);
    if DepthDATA{i}{8} == 0.5 & maxG > 0
        plot3(key, value, ids, 'g.');
        nFacce = nFacce + 1;
        maxG = maxG - 1;
    elseif DepthDATA{i}{8} == 1 & maxR > 0
        plot3(key, value, ids, 'r.');
        nNonFacce = nNonFacce + 1;
        maxR = maxR - 1;
    end
end
hold off
title("PIXEL-DEPTH");
legend(strcat("FACCE (", num2str(nFacce), ")"), strcat("NON FACCE (", num2str(nNonFacce), ")"))

figure
hold on
nFacce = 0;
nNonFacce = 0;
maxG = 300
maxR = 300
plot3(NaN, NaN, NaN, 'g.');
plot3(NaN, NaN, NaN, 'r.');
for i = 1:1000
    i
    map = meanVar(FixMatrix(DepthDATA{i}{3}, NaN));
    key = map(1);
    value = map(2);
    ids = i;
    if DepthDATA{i}{8} == 0.5 & maxG > 0
        plot3(key, value, ids, 'g.');
        nFacce = nFacce + 1;
        maxG = maxG - 1;
    elseif DepthDATA{i}{8} == 1 & maxR > 0
        plot3(key, value, ids, 'r.');
        nNonFacce = nNonFacce + 1;
        maxR = maxR - 1;
    end
end
hold off
title("MEDIA-VARIANZA");
legend(strcat("FACCE (", num2str(nFacce), ")"), strcat("NON FACCE (", num2str(nNonFacce), ")"))