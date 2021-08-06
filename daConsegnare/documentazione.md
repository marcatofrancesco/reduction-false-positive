# Descrizione Metodo
## Descrizione Testuale
(bisogna scriviere che abbiamo usato la funzione fit del Curve Fitting Toolbox)
## Pseudocodice
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

Il metodo quindi ha complessità temporale pari a $ O(n*m^2) $ in quanto per ogni immagine viene calcolato il massimo una volta e poi viene effettuato il controllo degli zeri sulla matrice, valore per valore.

# Risultati e Prestazione del metodo
<img src="https://latex.codecogs.com/svg.latex?\small&space;Precision&space;=&space;\frac{TruePositive}{TruePositive&plus;FalsePositive}&space;=&space;\frac{389}{389&plus;34}=&space;0,9196&space;\backsimeq&space;92&space;\%" title="\small Precision = \frac{TruePositive}{TruePositive+FalsePositive} = \frac{389}{389+34}= 0,9196 \backsimeq 92 \%" />


<img src="https://latex.codecogs.com/svg.latex?\small&space;Recall&space;=&space;\frac{TruePositive}{TruePositive&plus;FalseNegative}&space;=&space;\frac{389}{389&plus;1025}=&space;0,2751&space;\backsimeq&space;28&space;\%" title="\small Recall = \frac{TruePositive}{TruePositive+FalseNegative} = \frac{389}{389+1025}= 0,2751 \backsimeq 28 \%" />
