# Descrizione Metodo
## Descrizione Testuale
Data la matrice DepthDATA, considero per ogni elemento il campo (di indice 2) contenente la matrice di valori di profondità.
Richiamo quindi il metodo "FixMatrix" che va a sostituire nella matrice di profondità i valori 0 con il massimo delle profondità presenti nella matrice.
I valori a 0 di Depth infatti, indicano un "errore" nella determinazione della profondità da parte del sensore; nella maggior parte dei casi l'errore è causato da elementi troppo lontani dal sensore. <br/> Per questo vengono posizionati sulla massima profondità, ovvero sullo "sfondo".

Dalla matrice modificata viene poi presa la riga centrale, e si effettua una "regressione parabolica" sui valori della riga centrale.
Per la regressione parabolica si usa la funzione fit del Curve Fitting Toolbox.

I coefficienti vengono poi usati per calcolare la posizione in ascissa del vertice.

Definisco due margini calcolati come segue:

<img src="https://latex.codecogs.com/svg.image?A&space;=&space;matrixHCenter&space;-&space;marginRate&space;\times&space;matrixWidth" title="A = matrixHCenter - marginRate \times matrixWidth" />

<img src="https://latex.codecogs.com/svg.image?B&space;=&space;matrixHCenter&space;&plus;&space;marginRate&space;\times&space;matrixWidth" title="B = matrixHCenter + marginRate \times matrixWidth" />

Dove matrixHCenter è la posizione della colonna centrale della matrice di profondità e matrixWidth è la larghezza della matrice.

Il coefficiente marginRate arbitrario che indica quanto ci si distanzia dal centro della matrice nel considerare i margini.

Nel caso in cui il vertice della parabola ottenuta con regressione parabolica si trovi all'esterno del range definito dai due margini OPPURE se il coefficiente di secondo grado è negativo (parabola concava), allora contrassegno l'immagine come NonFace, altrimenti come NonFace.
<br/><br/>
Si può infatti notare come un'immagine Face dovrebbe avere valori più bassi (quindi più vicini alla
camera) verso il centro della matrice (naso, ecc.) come nel seguente fit: 

<img src="https://github.com/marcatofrancesco/reduction-false-positive/raw/main/images/mail1.jpg">

Che invece non è il caso di una NonFace: 

<img src="https://github.com/marcatofrancesco/reduction-false-positive/raw/main/images/mail2.jpg">

Si nota inoltre che la parabola di una Face è giocoforza convessa.
<br/><br/>
Il marginRate è stato quindi scelto sulla base del miglior compromesso tra Precision e Recall.

<img src="https://github.com/marcatofrancesco/reduction-false-positive/raw/main/images/testingGraph.png">

Come si può vedere nel grafico all'aumentare del marginRate la Precision aumenta a discapito del Recall.<br/>
E' stato scelto per questo come compromesso un marginRate di 0,58.



## Pseudocodice
```
Per ogni elemento con indice i di DepthDATA:
  matrix = DepthDATA{i}{2}; 
  fixedMatrix = FixMatrix(matrix);
  matrixVCenter = round(size(fixedMatrix, 1)/2);
  centralrow = fixedMatrix(matrixVCenter,:);
  f = parabolic_fit(centralrow);
  coefficientValues = coeffvalues(f);
  vertice = -coefficientValues(2)/(2 * coefficientValues(1)); // -b/2a
  marginRate = 0.58;
  matrixHCenter = round(size(fixedMatrix, 2)/2);
  marginA = matrixHCenter - marginRate*size(fixedMatrix, 1);
  marginB = matrixHCenter + marginRate*size(fixedMatrix, 1);
  
  if(vertice < marginA or vertice > marginB or coefficientValues(1) < 0):
      //contrassegno come NonFace
  else:
      //contrassegno come Face
```

# Analisi Complessità Temporale
Per analizzare la complessità del metodo si tiene conto della complessità temporale delle seguenti funzioni utilizzate:
- <img src="https://latex.codecogs.com/svg.latex?\small&space;size&space;=&space;O(1)" title="\small size = O(1)" />
- <img src="https://latex.codecogs.com/svg.latex?\small&space;transpose&space;=&space;O(1)" title="\small transpose = O(1)" />
- <img src="https://latex.codecogs.com/svg.latex?\small&space;fit=&space;O(1)" title="\small fit= O(1)" />
- <img src="https://latex.codecogs.com/svg.latex?\small&space;max&space;=&space;O(n)" title="\small max = O(n)" />

Per ognuna delle precedenti funzioni sono stati calcolati i vari tempi di esecuzione al variare della quantità di dati utilizzati, i risultati hanno portato alle precedenti conclusioni.

D'ora in avanti considereremo: 

<img src="https://latex.codecogs.com/svg.latex?\small&space;n&space;=&space;numero&space;\&space;di&space;\&space;immagini" title="\small n = numero \ di \ immagini" />    

<img src="https://latex.codecogs.com/svg.latex?\small&space;m&space;=&space;dimensione&space;\&space;totale&space;\&space;dell'immagine" title="\small m = dimensione \ totale \ dell'immagine" />

Il metodo quindi ha complessità temporale pari a  <img src="https://latex.codecogs.com/svg.latex?\small&space;O(n*m^2)" title="\small O(n*m^2)" />  in quanto per ogni immagine viene calcolato il massimo una volta e poi viene effettuato il controllo degli zeri sulla matrice, valore per valore.

# Risultati e Prestazione del metodo
Il metodo ottiene quidi i seguenti risultati in termini di recall e precision:
<img src="https://latex.codecogs.com/svg.latex?\small&space;Precision&space;=&space;\frac{TruePositive}{TruePositive&plus;FalsePositive}&space;=&space;\frac{711}{711&plus;49}=&space;0,9355&space;\backsimeq&space;94&space;\%" title="\small Precision = \frac{TruePositive}{TruePositive+FalsePositive} = \frac{711}{711+49}= 0,9355 \backsimeq 94 \%" />


<img src="https://latex.codecogs.com/svg.latex?\small&space;Recall&space;=&space;\frac{TruePositive}{TruePositive&plus;FalseNegative}&space;=&space;\frac{711}{711&plus;703}=&space;0,5028&space;\backsimeq&space;50&space;\%" title="\small Recall = \frac{TruePositive}{TruePositive+FalseNegative} = \frac{711}{711+703}= 0,5028 \backsimeq 50 \%" />
Infatti vengono individuate correttamente 711 non Face con soli 49 falsi positivi.

# Legenda file

-metodo1.m contiene l'effettivo programma che controllando tutte le immagini presenti dentro DepthDATA salva nel vettore results se è faccia (0.5) o non faccia (1)
-checkResults.m a partire dal vettore results, conteggia il numero di NonFace correttamente individuate o erratamente individuate
-fixMatrix.m contiene la funziona fixMatrix che data una matrice di profondità sostituisce i valori 0 con il massimo della profondità
-testValori.m testa i vari valori di marginRate (da 0.3 a 0.7) cancolandone di volta in volta Precision e Recall. Alla fine mostra l'andamento del tutto
-risultatiTestValori.fig mostra il grafico risultante dall'esecuzione del file testValori.m con l'andamento di Precision e Recall.
