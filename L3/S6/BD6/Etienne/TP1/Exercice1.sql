\i /ens/laplante/BD6/creer-tournage.sql
SELECT numlieu FROM Lieu WHERE arrondissement = 75013 AND adresse LIKE '%WATT%';
SELECT numfilm FROM Evenement WHERE numlieu IN (363,525,2343);
SELECT numrealisateur FROM Film WHERE numfilm IN (678,225,497);
SELECT nom,prenom FROM Realisateur WHERE numrealisateur IN (261,485,20);
SELECT COUNT(adresse) FROM Lieu WHERE adresse LIKE UPPER('%');
SELECT COUNT(adresse) FROM Lieu WHERE adresse LIKE '%';
SELECT * FROM Lieu WHERE adresse LIKE '%IENA%';
SELECT COUNT(nom) FROM Realisateur WHERE prenom LIKE UPPER('Ma_wenn');
SELECT nom FROM Realisateur WHERE prenom LIKE UPPER('');
SELECT * FROM Realisateur WHERE nom LIKE UPPER('%Nakache%');
SELECT * FROM Realisateur WHERE nom LIKE UPPER('%Berthe%');
SELECT * FROM Lieu WHERE arrondissement IS NULL;
SELECT * FROM Lieu WHERE arrondissement = NULL;
SELECT * FROM Evenement WHERE datefin = datedebut+4;
SELECT * FROM Evenement WHERE datefin - datedebut BETWEEN 3 AND 7;
SELECT numfilm, datedebut, datefin, datefin - datedebut AS nbjours FROM Evenement WHERE datefin - datedebut BETWEEN 3 AND 7;
SELECT numfilm, datedebut, datefin, datefin - datedebut AS nbjours FROM Evenement WHERE datefin - datedebut BETWEEN 3 AND 7 ORDER BY nbjours;
SELECT COUNT(*) FROM Evenement WHERE datefin = datedebut+2;
SELECT MAX(datefin - datedebut) FROM Evenement;
SELECT * FROM Evenement WHERE datefin - datedebut BETWEEN 7 AND 214;
SELECT COUNT(*) FROM Evenement WHERE datefin < datedebut;
DROP TABLE Evenement, Lieu, Film, Realisateur;
