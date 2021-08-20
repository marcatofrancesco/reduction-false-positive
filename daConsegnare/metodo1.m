% il seguente metodo popolerà l'array results con i risultati del metodo. ogni indice nell'array corrisponde alla corrispondente immagine in DepthDATA con lo stesso indice. I risultiati sono cos' rappresentati: 1--> non face, 0.5 --> face

marginRate = 0.48; % marginRate con almeno il 60% di Recall
concavityCheck = 1;

marginRate = 1.69; % marginRate per avere meno di 10 FP
concavityCheck = 0; % da decommentare per avere meno di 10 FP

results = applicaMetodo(marginRate, DepthDATA, concavityCheck);