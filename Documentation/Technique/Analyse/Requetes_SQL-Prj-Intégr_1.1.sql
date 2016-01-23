-- Par J.F.No�l
-- � noter que dans les fichiers .php les requ�tes SQL n'ont pas de point-virgule.

-- Comme correction g�n�rale, mettre chaque champ de la commande SELECT sur une ligne diff�rente

-- Tester les requ�tes pour les marchandises disponibles
-- Test� le 19 janvier 2016 (avec des commentaires pour PA)
-- Corrections � faire:
-- Dans le WHERE remplacer le ANd par AND
-- Mettre le ANd et le reste de la commande sur une autre ligne
-- Mettre en majuscule CURRENT_DATE
-- Le champ adr.adresse_id dans la commande du SELECT (pas n�cessaire, et nous le gardons pour avoir l'objet complet)
SELECT DISTINCT org.organisme_id, 
				org.nom, 
				adr.no_civique, 
				adr.nom , 
				typrue.description_type_rue , 
				adr.ville , adr.province, 
				adr.code_postal, adr.pays, adr.adresse_id 

FROM alimentaire ali
INNER JOIN marchandise_statut marstat ON marstat.statut_id = ali.marchandise_statut
INNER JOIN transaction trx ON trx.marchandise_id = ali.alimentaire_id 
INNER JOIN organisme org ON org.organisme_id = trx.donneur_id
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON adr.type_rue = typrue.type_rue_id 
WHERE ali.marchandise_statut = 3 ANd ali.date_peremption > current_date;

-- Fonction : donid
-- Dans le SELECT pas n�cessaire (les garder pour les objets) : ali.alimentaire_id, ali.valeur
-- Mettre en majuscule : CURRENT_DATE
-- Ajouter pour l'ORDER BY l'alias du champ : ORDER BY typali.aliment_id DESC
-- � enlever (non-n�cessaire) - le r�sultat reste le m�me
-- INNER JOIN marchandise_statut marstat ON marstat.statut_id = ali.marchandise_statut
-- INNER JOIN marchandise_etat maretat ON maretat.etat_id = ali.marchandise_etat
-- changer pour moi :id_donneur mettre une valeur
-- Temps pris 1.90 ms, 15 record(s)

-- Requ�te avant
SELECT ali.nom, ali.alimentaire_id,
		ali.description_alimentaire, ali.quantite, marunit.description_marchandise_unite,ali.date_peremption, ali.valeur
		
		FROM transaction trx
		
		INNER JOIN organisme org ON org.organisme_id = trx.donneur_id
		INNER JOIN alimentaire ali ON ali.alimentaire_id = trx.marchandise_id
		INNER JOIN type_aliment typali ON typali.aliment_id = ali.type_alimentaire
		INNER JOIN marchandise_statut marstat ON marstat.statut_id = ali.marchandise_statut
		INNER JOIN marchandise_etat maretat ON maretat.etat_id = ali.marchandise_etat
		INNER JOIN marchandise_unite marunit ON marunit.unite_id = ali.marchandise_unite

		WHERE (ali.marchandise_statut = 3 OR ali.marchandise_statut = 2 )AND trx.donneur_id = :id_donneur AND (ali.date_peremption > current_date OR ali.date_peremption IS NULL) ORDER BY aliment_id DESC;

-- Requ�te apr�s, pour tester remplacer :id_donneur par 4 (ajout ; � la fin)
SELECT 	ali.nom
		,ali.description_alimentaire
		, ali.quantite
		, marunit.description_marchandise_unite
		,ali.date_peremption
FROM transaction trx
INNER JOIN organisme org ON org.organisme_id = trx.donneur_id
INNER JOIN alimentaire ali ON ali.alimentaire_id = trx.marchandise_id
INNER JOIN type_aliment typali ON typali.aliment_id = ali.type_alimentaire
INNER JOIN marchandise_unite marunit ON marunit.unite_id = ali.marchandise_unite
WHERE (ali.marchandise_statut = 3 OR ali.marchandise_statut = 2 )
AND trx.donneur_id = :id_donneur 
AND (ali.date_peremption > CURRENT_DATE OR ali.date_peremption IS NULL) 
ORDER BY typali.aliment_id DESC;
		
-- Requ�te Marchandises_disponibles liste dans des dons
-- Fonction : listedondispo, fichier : don.php
-- � ajouter : l'alias du champ dans ORDER BY :  ORDER BY ali.alimentaire_id DESC
-- � enlever : 	INNER JOIN type_aliment typali ON typali.aliment_id = ali.type_alimentaire 
--				INNER JOIN marchandise_etat maretat ON maretat.etat_id = ali.marchandise_etat
SELECT ali.nom, ali.alimentaire_id,
  ali.description_alimentaire, ali.quantite, marunit.description_marchandise_unite, ali.date_peremption,
  ali.valeur, marstat.description_marchandise_statut, org.organisme_id, org.nom, org.telephone, org.poste, 
  adr.adresse_id, adr.no_civique, typrue.description_type_rue, adr.nom, adr.ville, adr.province, adr.code_postal, adr.pays
  
  FROM transaction trx
  
  INNER JOIN organisme org ON org.organisme_id = trx.donneur_id
  INNER JOIN adresse adr ON adr.adresse_id = org.adresse
  INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
  INNER JOIN alimentaire ali ON ali.alimentaire_id = trx.marchandise_id
  INNER JOIN type_aliment typali ON typali.aliment_id = ali.type_alimentaire
  INNER JOIN marchandise_statut marstat ON marstat.statut_id = ali.marchandise_statut
  INNER JOIN marchandise_etat maretat ON maretat.etat_id = ali.marchandise_etat
  INNER JOIN marchandise_unite marunit ON marunit.unite_id = ali.marchandise_unite 
  
  WHERE ali.marchandise_statut = 3 
 
  ORDER BY alimentaire_id DESC;
  
-- 
-- Fonction Liste des oranismes communautaires
/*
- Nom du receveur (organisme qui re�oit)
- Adresse du receveur
- Nom de la personne contact (pr�nom, nom)
- Num�ro de t�l�phone du receveur
- Courriel de l'organisme communautaire
*/
-- PA v�rifie si les champs que je mets conviennent � l'id�e d'objet que tu souhaites utilis�.
SELECT 	org.nom, 
		adr.no_civique, 
		typrue.description_type_rue, 
		adr.nom, 
		adr.ville, 
		adr.province, 
		adr.code_postal, 
		adr.pays,
		util.prenom,
		util.nom,
		org.telephone,
		org.poste,
		util.courriel
FROM organisme org
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
INNER JOIN utilisateur util ON util.utilisateur_id = org.utilisateur_contact
WHERE org.no_osbl IS NOT NULL;