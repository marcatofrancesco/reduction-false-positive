% stampa ad output i risultati ottenuti nell'array results
% dichiaro contatori
truePositive = 0; % NonFace
falsePositive = 0; % Face individuati come NonFace
trueNegative = 0; % Face
falseNegative = 0; % NonFace individuati come Face

totaleF = 0; % totale Face
totaleNF = 0; % totale NonFace
for i = 1:size(results) % per ogni immagine in result
    if DepthDATA{i}{8} == 1
        totaleNF = totaleNF + 1; % aggiorno contatore nonFace
    else
        totaleF = totaleF + 1; % aggiorno contatore Face
    end
    if DepthDATA{i}{8} == 1 && results(i) == 0.5
        falseNegative = falseNegative+1; % aggiorno contatore FalseNegative
    elseif DepthDATA{i}{8} == 0.5 && results(i) == 0.5
        trueNegative = trueNegative + 1;
    end
    
    if results(i)== 1
        if DepthDATA{i}{8} == 0.5
            falsePositive = falsePositive+1; % aggiorno contatore falsePositive
        else
            truePositive = truePositive+1; % aggiorno contatore truePositive
        end
    end
end
disp("Veri Positivi (NonFace correttamente individuate):");
disp(truePositive);
disp("Falsi Positivi (Face individuate come NonFace):");
disp(falsePositive);
disp("Veri Negativi (Face correttamente individuate):");
disp(trueNegative);
disp("Falsi Negativi (NonFace individuate come Face):");
disp(falseNegative);
disp("Totale Face:");
disp(totaleF);
disp("Totale NonFace:");
disp(totaleNF);
