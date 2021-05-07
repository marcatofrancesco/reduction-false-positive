nFacce = 0
key = [];
value = [];
for i = 1:200
    if DepthDATA{i}{8} == 0.5
        i
        nFacce = nFacce + 1;
        map = nPixels(FixMatrix(DepthDATA{i}{3}), 2);
        key = [key cell2mat(keys(map))];
        value = [value cell2mat(values(map))];
    end
end
plot(key, value, '.');
title(["FACCE " num2str(nFacce)]);

figure;
nNonFacce = 0
key = [];
value = [];
for i = 1:200
    if DepthDATA{i}{8} == 1
        i
        nNonFacce = nNonFacce + 1;
        map = nPixels(FixMatrix(DepthDATA{i}{3}), 2);
        key = [key cell2mat(keys(map))];
        value = [value cell2mat(values(map))];
    end
end
plot(key, value, '.');
title(["NON FACCE " num2str(nNonFacce)]);