function automaticSurf(id)
    load('daConsegnare/DatDepth.mat');
    surf(FixMatrix(DepthDATA{id}{3}), DepthDATA{id}{16});
end