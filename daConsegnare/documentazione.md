# Descrizione Metodo
## Descrizione Testuale
(bisogna scriviere che abbiamo usato la funzione fit del Curve Fitting Toolbox)
## Pseudocodice
# Analisi Complessità Temporale
Per analizzare la complessità del metodo si tiene conto della complessità temporale delle seguenti funzioni utilizzate:
- size $ O(1) $
- transpose $ O(1) $
- fit $ O(1) $
- max $ O(n) $ con n = elementi della matrice

Per ognuna delle precedenti funzioni sono stati calcolati i vari tempi di esecuzione al variare della quantità di dati utilizzati, i risultati hanno portato alle precedenti conclusioni.

D'ora in avanti considereremo: 

$ n = numero \ di \ immagini$

$ m = dimensione \ totale \ dell'immagine$

Il metodo quindi ha complessità temporale pari a $ O(n*m^2) $ in quanto per ogni immagine viene calcolato il massimo una volta e poi viene effettuato il controllo degli zeri sulla matrice, valore per valore.

# Risultati e Prestazione del metodo
Precision = $\frac{TruePositive}{TruePositive+FalsePositive} = \frac{389}{389+34}= 0,9196 \backsimeq 92 \% $  


Recall = $\frac{TruePositive}{TruePositive+FalseNegative} = \frac{389}{389+1025}= 0,2751 \backsimeq 28 \% $ 