% funzione che data una matrice con dei valori =0 li sostituisce con il
% valore dell'argomento zeroValue, nel caso zeroValue non fosse presente
% verrà sostituito con il valore massimo della matrice. La funzione
% restituisce la matrice "aggiustata".
function newm = FixMatrix(matrix, zeroValue)    
    sizes = size(matrix); %individuo le dimensioni della matrice
    
    %estraggo altezza e largezza della matrice
    height = sizes(1); 
    length = sizes(2);

    for i = 1:height
        for j = 1:length

            if double(matrix(i,j))==0 % se il valore della matrice iniziale ha il valore =0
                if ~exist('zeroValue','var') 
                    newm(i,j)=max(matrix(:)); % il valore nella nuova matrice viene impostato a massimo(quindi a sfondo) se non esiste lo zeroValue
                else
                    newm(i,j)=zeroValue; % il valore nella nuova matrice viene impostato a zeroValue
                end
            else
                newm(i,j) = double(matrix(i,j)); % altrimenti se il valore non è =0 viene impostato il valore presente nella matrice originale
            end
        end
    end
end