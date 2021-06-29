% stampa ad output i rusultati del cluster
giuste = 0;
sbagliate = 0;
nonIndividuate = 0;
totaleNF = 0;
for i = 1:size(clusterData)
    % il secondo valore di cluster data non è per niente preciso ma riesce
    % ad eliminare maggior parte dei falsi positivi, ma ne vale la pena?
    % perchè toglie anche molte facce correttamente trovate
    % in pratica volevo dire se sono entrambe centrali ma boh
    if DepthDATA{i}{8} == 1
        totaleNF = totaleNF +1;
    end
    if DepthDATA{i}{8} == 1 && idx(i)== 1
        nonIndividuate = nonIndividuate+1;
    end
    if idx(i)== 2
        %disp(i)
        if DepthDATA{i}{8} == 0.5
            sbagliate = sbagliate+1;
            %
        else
            giuste = giuste+1;
        end
    end
end
disp("NonFace correttamente individuate: ")
disp(giuste)
disp("NonFace erratamente individuate: ")
disp(sbagliate)
disp("NonFace non individuate: ")
disp(nonIndividuate)
disp("Totale NonFace: ")
disp(totaleNF)