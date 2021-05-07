function automaticSurf(id)
    load('DatDepth.mat');
    surf(FixMatrix(DepthDATA{id}{3}), DepthDATA{id}{16});
end