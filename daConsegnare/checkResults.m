% stampa ad output i risultati del cluster
giuste = 0;
sbagliate = 0;
nonIndividuate = 0;
totaleNF = 0;
for i = 1:size(results)
    if DepthDATA{i}{8} == 1
        totaleNF = totaleNF +1;
    end
    if DepthDATA{i}{8} == 1 && results(i)== 0.5
        nonIndividuate = nonIndividuate+1;
    end
    if results(i)== 1
        if DepthDATA{i}{8} == 0.5
            sbagliate = sbagliate+1;
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
