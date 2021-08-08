% il seguente metodo popolerà l'array results con i risultati del metodo. ogni indice nell'array corrisponde alla corrispondente immagine in DepthDATA con lo stesso indice. I risultiati sono cos' rappresentati: 1--> non face, 0.5 --> face

marginRate = 0.66

results = zeros(size(transpose(DepthDATA),1), 1); %inizializzo l'array results vuoto

for i = 1:size(transpose(DepthDATA)) % analizzo tutte le immagini presenti in DepthDATA

	matrix = DepthDATA{i}{2}; % considero la depth map della regione trovata dal face detector
	maxMatrix = max(matrix(:)); % individuo il valore massimo all'interno della matrice

	fixedMatrix = FixMatrix(matrix, maxMatrix); % aggiusto i valori che sono =0, quindi catturati erroneamente dal depth sensor
	matrixVCenter = round(size(fixedMatrix, 1)/2); % trovo la riga centrale della matrice
	centralrow = fixedMatrix(matrixVCenter,:); % salvo nell'array centralrow i valori della riga centrale della metrice fixedMatrix

	% preparo i dati per effettuare il fit e la regressione parabolica
	x = transpose(1:size(centralrow, 2));
	y = double(transpose(centralrow));

	f=fit(x,y,'poly2'); % effettuo la regressione parabolica

	coefficientValues = coeffvalues(f); % estraggo i coefficenti dell'equazione di secondo grado dal fit

	vertice = -coefficientValues(2)/(2.*coefficientValues(1));  % individuo il vertice della parabola

	matrixHCenter = round(size(fixedMatrix, 2)/2); % trovo la colonna centrale della matrice

	marginA = matrixHCenter - marginRate*size(fixedMatrix, 1); % calcolo il primo margine spostandomi a sinistra rispetto alla colonna centrale
	marginB = matrixHCenter + marginRate*size(fixedMatrix, 1); % calcolo il secondo margine spostandomi a destra rispetto alla colonna centrale

	if (vertice < marginA || vertice > marginB || coefficientValues(1) < 0) % controllo che il vertice sia esterno ai margini o che la parabola sia concava
		results(i, 1) = 1; % allora essa viene identificata come nonFace
	else
		results(i, 1) = 0.5; % altrimenti viene identificata come face
	end

end

