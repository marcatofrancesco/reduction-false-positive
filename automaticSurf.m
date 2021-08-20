function automaticSurf(id)
    load('daConsegnare/DatDepth.mat');
    surf(FixMatrix(DepthDATA{id}{2}), DepthDATA{id}{1});
end