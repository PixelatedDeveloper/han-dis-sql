-- indien je een voorwaarde aanpast wordt de einddatum ingevuld en een nieuwe voorwaarde aangemaakt

	IF EXISTS
	(
		-- kijkt of de dienst actief is en of de voorwaarde hiervoor geldt.
		select 1
		from Voorwaarde v
		inner join Aanbieder a
			ON v.voorwaardeid = a.voorwaardeid
		inner join Dienst d
			ON a.aanbiedernaam = d.aanbiedernaam
		where v.voorwaardebegindatum >= d.begindatum
		AND (v.voorwaardeeinddatum <= d.einddatum OR d.einddatum is NULL)
	)
	THEN
		
		-- eindatum invullen
		UPDATE Voorwaarde
		SET voorwaardeeindatum = now()
		WHERE v.voorwaardeid = [voorwaardeid]
		
		-- Nieuwe rij invoegen
		INSERT INTO Voorwaarde (voorwaardebeschrijving, voorwaardebegindatum, voorwaardeeinddatum) 
		VALUES (['voorwaardebeschrijving'], now(), NULL);
		

	END IF;