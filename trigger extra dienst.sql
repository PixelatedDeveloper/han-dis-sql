/*
Gemaakt door Mike
Beschrijving:
De hoeveelheid korting op een extra dienst mag niet hoger zijn als de prijs van die extra dienst
*/ WERKT NOG NIET!!!
DROP TRIGGER trg_extradienstkorting;
DELIMITER $$
CREATE TRIGGER trg_extradienstkorting 
BEFORE INSERT ON kortingbijextradienst 
FOR EACH ROW
BEGIN
  IF EXISTS (	
	SELECT ked.kortingid
	FROM Korting K 
	INNER JOIN kortingbijextradienst ked 
		ON k.kortingid = ked.kortingid 
	INNER JOIN extradienst ed 
		ON ked.aanbiedernaam = ed.aanbiedernaam 
		AND ked.extradienstnaam = ed.extradienstnaam
	WHERE k.kortinghoeveelheid > ed.extradienstprijs 
	AND ked.aanbiedernaam = new.aanbiedernaam 
	AND ked.extradienstnaam = new.extradienstnaam 
	AND ked.kortingid = new.kortingid
	group by ked.kortingid
	) 
   THEN 
	CALL raise_application_error(4, "korting hoger dan prijs extra dienst");
   END IF; 
END; $$
DELIMITER ;
