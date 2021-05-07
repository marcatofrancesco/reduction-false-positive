hold on
nFacce = 0;
nNonFacce = 0;
maxG = 300
maxR = 300
for i = 1:1000
    i
    map = nPixels(matriceMedia(DepthDATA{i}{3}), 2, 100);
    key = cell2mat(keys(map))';
    value = cell2mat(values(map))';
    ids = i*ones(size(key,1),1);
    if DepthDATA{i}{8} == 0.5 & maxG > 0
        plot3(key, value, ids, 'g.');
        nFacce = nFacce + 1;
        maxG = maxG - 1;
    elseif maxR > 0
        plot3(key, value, ids, 'r.');
        nNonFacce = nNonFacce + 1;
        maxR = maxR - 1;
    end
end

legend(strcat("FACCE (", num2str(nFacce), ")"), strcat("NON FACCE (", num2str(nNonFacce), ")"))
hold off