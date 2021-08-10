% stampa ad output i risultati ottenuti nell'array results
% dichiaro contatori
giuste = 0; % truePositive
sbagliate = 0; % falsePositive
nonIndividuate = 0; % FalseNegative
totaleNF = 0; % totale NonFace
for i = 1:size(results) % per ogni immagine in result
    if DepthDATA{i}{8} == 1
        totaleNF = totaleNF +1; % aggiorno contatore nonFace
    end
    if DepthDATA{i}{8} == 1 && results(i)== 0.5
        nonIndividuate = nonIndividuate+1; % aggiorno contatore FalseNegative
    end
    if results(i)== 1
        if DepthDATA{i}{8} == 0.5
            sbagliate = sbagliate+1; % aggiorno contatore falsePositive
        else
            giuste = giuste+1; % aggiorno contatore truePositive
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
