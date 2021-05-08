function meanVar = meanVar(matrix)
    meanVar = [mean(matrix(:), 'omitnan') var(matrix(:), 'omitnan')];
end

