-- Par J.F.No�l
-- � noter que dans les fichiers .php les requ�tes SQL n'ont pas de point-virgule.

-- Comme correction g�n�rale, mettre chaque champ de la commande SELECT sur une ligne diff�rente

-- Tester les requ�tes pour les marchandises disponibles sur la carte
-- Fichier: carte.php, fonction : entreprisedon() 
-- D'abord l'affichage des entreprises qui ont des marchandises disponibles avec leurs coordonn�es
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

-- Fonction : donid, REMPLACER :id_donneur mettre une valeur ex: 4
-- Affiche les informations marchandises disponibles pour une entreprise en particulier
-- Dans le SELECT pas n�cessaire (les garder pour les objets) : ali.alimentaire_id, ali.valeur
-- Mettre en majuscule : CURRENT_DATE
-- Ajouter pour l'ORDER BY l'alias du champ : ORDER BY typali.aliment_id DESC
-- � enlever (non-n�cessaire) - le r�sultat reste le m�me
-- INNER JOIN marchandise_statut marstat ON marstat.statut_id = ali.marchandise_statut
-- INNER JOIN marchandise_etat maretat ON maretat.etat_id = ali.marchandise_etat
-- 
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

-- Requ�te apr�s, pour tester REMPLACER :id_donneur par 4 (ajout ; � la fin)
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
		
-- Requ�te Marchandises_disponibles liste dans des dons (avant que Catherine fasse une carte Trello)
-- Fonction : listedondispo, fichier : don.php
-- � ajouter : l'alias du champ dans ORDER BY :  ORDER BY ali.alimentaire_id DESC
-- � enlever : 	INNER JOIN type_aliment typali ON typali.aliment_id = ali.type_alimentaire 
--				INNER JOIN marchandise_etat maretat ON maretat.etat_id = ali.marchandise_etat
SELECT ali.nom, 
	ali.alimentaire_id,
	ali.description_alimentaire, 
	ali.quantite, 
	marunit.description_marchandise_unite, 
	ali.date_peremption,
	ali.valeur, 
	marstat.description_marchandise_statut, 
	org.organisme_id, 
	org.nom, 
	org.telephone, 
	org.poste, 
	adr.adresse_id, 
	adr.no_civique, 
	typrue.description_type_rue, 
	adr.nom, 
	adr.ville, 
	adr.province, 
	adr.code_postal, 
	adr.pays
  
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
  
-- Liste des marchandises disponibles par Catherine
/*	
    Type Cat�gorie
    Nom du produit
    Description du produit
    Quantit�
    Unit�
    Date de p�remption
    Nom de l'entreprise donneur
    Adresse de l'entreprise donneur
    Num�ro de t�l�phone de l'entreprise donneur et le num�ro de poste
    Pr�nom et Nom de la personne contact de l'entreprise donneur (s'il y a)
    Courriel de l'entreprise donneur (s'il y a)
*/  


-- Changement dans la clause WHERE,2016-02-01
-- Enlever du WHERE : AND (ali.date_peremption > CURRENT_DATE OR ali.date_peremption IS NULL)
-- Pour avoir les marchandises p�rim�es, car elles peuvent �tre donn�es et encore bonnes.
-- L'ordre dans le GROUP BY est le m�me que dans l'�nonc� de Catherine plus haut.

SELECT MAX(trx.date_disponible) as date_disponible,
    typali.description_type_aliment,
    ali.nom,
    ali.description_alimentaire,
    ali.quantite,
    marunit.description_marchandise_unite,
    ali.date_peremption,
    org.nom,
    adr.adresse_id,
    adr.no_civique,
    typrue.description_type_rue,
    adr.nom,
    adr.ville,
    adr.province,
    adr.code_postal,
    adr.pays,
    org.telephone,
    org.poste,
    util.prenom,
    util.nom,
    util.courriel

FROM type_aliment typali
INNER JOIN alimentaire ali ON ali.type_alimentaire = typali.aliment_id
INNER JOIN marchandise_unite marunit ON marunit.unite_id = ali.marchandise_unite
INNER JOIN transaction trx ON trx.marchandise_id = ali.alimentaire_id
INNER JOIN organisme org ON org.organisme_id = trx.donneur_id
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
INNER JOIN utilisateur util ON util.utilisateur_id = org.utilisateur_contact  
WHERE ali.marchandise_statut = 3
AND  trx.marchandise_id in (SELECT DISTINCT marchandise_id FROM transaction)
AND   trx.date_reservation IS NULL  
GROUP BY typali.description_type_aliment,
    ali.nom,
    ali.description_alimentaire,
    ali.quantite,
    marunit.description_marchandise_unite,
    ali.date_peremption,
    org.nom,
    adr.adresse_id,
    adr.no_civique,
    typrue.description_type_rue,
    adr.nom,
    adr.ville,
    adr.province,
    adr.code_postal,
    adr.pays,
    org.telephone,
    org.poste,
    util.prenom,
    util.nom,
    util.courriel; 

-- Fonction Liste des oranismes communautaires
/*
- Nom du receveur (organisme qui re�oit)
- Adresse du receveur
- Nom de la personne contact (pr�nom, nom)
- Num�ro de t�l�phone du receveur
- Courriel de l'organisme communautaire
*/
-- PA v�rifie si les champs que je mets conviennent � l'id�e d'objet que tu souhaites utilis�.
-- Avec les ajouts de PA (2016-01-25)
SELECT	org.nom, 
		adr.no_civique, 
		typrue.description_type_rue, 
		adr.nom, 
		adr.ville, 
		adr.province, 
		adr.code_postal, 
		adr.pays,
		util.prenom,
		util.nom,
		util.courriel,
		util.telephone,
		org.telephone,
		org.poste
	  	  
FROM organisme org
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
INNER JOIN utilisateur util ON util.utilisateur_id = org.utilisateur_contact
WHERE org.no_osbl IS NOT NULL;

-- Fonctionnali�s - requ�tes
-- Ajout marchandise (d�j� cr��e par PA), fichier alimentaire.php, fonction: ajoutalimentaire()
-- Chaque valeur correspondant au champ de la table a besoin d'�tre mis dans les parent�ses (VALUES) avec les apostrophes
-- si c'est un champ d'un ou plusieurs caract�res ou de date
-- Requ�te qui fonctionne bien, rien � redire.

INSERT INTO alimentaire (nom, description_alimentaire, quantite, marchandise_etat, marchandise_unite, valeur, marchandise_statut, type_alimentaire, date_peremption) 
												VALUES(:nom, :description_alimentaire, :quantite, :marchandise_etat, :marchandise_unite, :valeur, :marchandise_statut, :type_alimentaire, :date_peremption);
-- Test
INSERT INTO alimentaire (nom, description_alimentaire, quantite, marchandise_etat, marchandise_unite, valeur, marchandise_statut, type_alimentaire, date_peremption) 
				VALUES('Raisin rouge globe sans p�pins', 'Import� du P�rou', 3.00, 1, 2, 6, 3, 1, '2016-01-31 23:00:00' );
 
 -- La fonction ajout marchandise implique l'ajout d'une transaction, fichier alimentaire.php, fonction: ajoutalimentaire()
 -- REMPLACER les champs : donneur_id, :marchandise_id par des valeurs.
 -- Requ�te qui fonctionne bien, rien � redire.-- 
 
INSERT INTO transaction (donneur_id, marchandise_id, date_disponible, date_transaction)
			VALUES(:donneur_id, :marchandise_id,  NOW(), NOW());
 
 -- Test
INSERT INTO transaction (donneur_id, marchandise_id, date_disponible, date_transaction)
			VALUES(6, 73,  NOW(), NOW());			
 
-- Fonctionnali�s - requ�tes
-- Modification marchandise (d�j� cr��e par PA), fichier alimentaire.php, fonction: modifieralimentaire()
-- REMPLACER les variables PHP par des valeurs valides.-
-- Chaque valeur correspondant au champ de la table a besoin d'�tre mis avec les apostrophes
-- si c'est un champ d'un ou plusieurs caract�res ou de date
-- La requ�te ne fonctionne pas bien (manque une virgule apr�s :valeur, et le nom de la colonne description serait 
-- � remplacer par description_alimentaire
-- alignement du WHERE vis � vis le UPDATE.

UPDATE alimentaire SET nom = :nom, description = :description_alimentaire, quantite = :quantite,
								marchandise_etat = :marchandise_etat, marchandise_unite = :marchandise_unite, valeur = :valeur
								type_alimentaire = :type_alimentaire, date_peremption = :date_peremption
								WHERE alimentaire_id = :alimentaire_id;
-- Test
UPDATE alimentaire SET nom = 'Raisin rouge globe sans p�pins', description_alimentaire = 'Import� du P�rou', quantite = 4.00,
								marchandise_etat = 1, marchandise_unite = 2, valeur = 9,
								type_alimentaire = 1, date_peremption = '2016-01-31 23:00:00'
WHERE alimentaire_id = 73;		

-- Fonctionnali�s - requ�tes
-- Suppression marchandise (d�j� cr��e par PA), fichier alimentaire.php, fonction: cancelleraliment($id_alimentaire)
-- REMPLACER :id_alimentaire par un ID valide.
-- Requ�te parfaite.

UPDATE alimentaire SET marchandise_statut = 7 WHERE alimentaire_id = :id_alimentaire;

-- Test
UPDATE alimentaire SET marchandise_statut = 7 WHERE alimentaire_id = 73;

-- Fonctionnali�s - requ�tes
-- Collecte marchandise (d�j� cr��e par PA), fichier alimentaire.php, fonction: collecteralimentaire($id_alimentaire)
-- REMPLACER :id_alimentaire par un ID valide et la marchandise_statut = 4 (collect�). J'aurais cru que la valeur
-- soit mise comme dans le cas pr�c�dent. Elle est g�r�e par le code PHP par la suite.
-- Requ�te fonctionne avec les bonnes valeurs.

UPDATE alimentaire SET marchandise_statut = :marchandise_statut WHERE alimentaire_id = :id_alimentaire;	

-- Test 
UPDATE alimentaire SET marchandise_statut = 4 WHERE alimentaire_id = 73;

-- Fonctionnali�s - requ�tes
-- Collecte transaction
-- REMPLACER : transaction_id par le num�ro de transaction que l'on veut modifier le champ date_collecte
-- Nouvelle requ�te pour PA
-- � ajouter sans doute dans le fichier alimentaire.php o� il y a d�j� le marchandise_statut qui change avec la collecte.

UPDATE transaction SET 	date_collecte =  NOW()
WHERE transaction_id = :transaction_id;

-- Test
UPDATE transaction SET 	date_collecte =  NOW()
WHERE transaction_id = 39;

-- Fonctionnali�s - requ�tes
-- Ajout reservation (d�j� cr��e par PA), fichier reservation.php, fonction: reservationajout()
-- REMPLACER les valeurs : :donneur_id, :receveur_id, :marchandise_id, :date_disponible
-- Requ�te fonctionne seulement j'ai un avertissement, date_transaction :  Field 'date_transaction' doesn't have a default value
-- Lors de l'insertion la valeur est : 0000-00-00 00:00:00. Je ne sais pas si le PHP ajoute la valeur courante?
-- Une fa�on de r�gler l'avertissement c'est d'ajouter � l'insertion le champ : date_transaction et la valeur CURRENT_TIMESTAMP
-- Voir le 2e test et je n'ai aucun avertissement.

INSERT INTO transaction (donneur_id, receveur_id, marchandise_id, date_disponible, date_reservation)
									VALUES(:donneur_id, :receveur_id, :marchandise_id, :date_disponible,  CURRENT_TIMESTAMP);
	
-- Test
INSERT INTO transaction (donneur_id, receveur_id, marchandise_id, date_disponible, date_reservation)
									VALUES(6, NULL, 73, '2016-01-23 17:37:40',  CURRENT_TIMESTAMP);

-- 2e test
INSERT INTO transaction (donneur_id, receveur_id, marchandise_id, date_disponible, date_reservation, date_transaction)
									VALUES(6, NULL, 73, '2016-01-23 17:37:40',  CURRENT_TIMESTAMP, CURRENT_TIMESTAMP);

-- Fonctionnali�s - requ�tes
-- Ajout reservation (d�j� cr��e par PA), fichier reservation.php, fonction: reservationajout()	
-- Suite pour que la marchandise passe � un �tat de disponible � r�serv�, une mise � jour sur la table
-- alimentaire a lieu.
-- REMPLACER: :marchandise_statut par 2 (r�serve) et choisir un :id valide de la table alimenaire
-- D�placer le WHERE sur une autre ligne
-- Bonne requ�te.

UPDATE alimentaire SET marchandise_statut = :marchandise_statut WHERE alimentaire_id = :id;

-- Test
UPDATE alimentaire SET marchandise_statut = 2 WHERE alimentaire_id = 73;

-- Fonctionnali�s - requ�tes
-- Annulation reservation (d�j� cr��e par PA), fichier reservation.php, fonction: annulerreservation($marchandise_id)	
-- REMPLACER chaque variable par des valeurs valides dans la seconde ligne VALUES(). Requ�te similaire � l'ajout,
-- m�me commentaire. L'item choisi prendra aura une nouvelle date et heure de disponibilit�.

INSERT INTO transaction (donneur_id, receveur_id, marchandise_id, date_disponible, date_reservation)
											VALUES(:donneur_id, :receveur_id, :marchandise_id, :date_disponible, :date_reservation);

-- Du m�me coup, la marchandise sera � nouveau disponible.
-- REMPLACER: :marchandise_statut par 3 (disponible) et choisir un :id valide de la table alimenaire
-- M�me requ�te que plus haut

UPDATE alimentaire SET marchandise_statut = :marchandise_statut WHERE alimentaire_id = :id;

-- Liste des marchandises r�serv�es, ou liste de r�servations (Catherine)
-- 
/*  Liste � Catherine - Carte Trello
    Type alimentaire
    Nom
    Description
    Quantit�e
    Unit�
    Date de r�servation
    Date de p�remption
    Nom du donneur (entreprise qui donne)
    Adresse du donneur
    Num�ro de t�l�phone du donneur (s'il y a)
    Courriel du donneur (s'il y a)
*/
-- Avec les ajouts de PA (2016-01-25)
-- J'ai ajout� (2016-01-30) dans la condition du WHERE : AND date_reservation IS NOT NULL
-- Une autre condition a besoin d'�tre ajout�e qui r�f�re marchandise_id et date_transaction
-- Pour enlever la possibilit� d'avoir la m�me marchandise_id pour 2 usagers diff�rents, une sous-requ�te
-- est n�cessaire.

SELECT typali.description_type_aliment,
    ali.nom,
    ali.description_alimentaire,
    ali.quantite,
    marunit.description_marchandise_unite,
    ali.date_peremption,
    org.nom,
    adr.adresse_id,
    adr.no_civique,
    typrue.description_type_rue,
    adr.nom,
    adr.ville,
    adr.province,
    adr.code_postal,
    adr.pays,
    org.telephone,
    org.poste,
    util.prenom,
    util.nom,
    util.courriel
   
FROM type_aliment typali
INNER JOIN alimentaire ali ON ali.type_alimentaire = typali.aliment_id
INNER JOIN marchandise_unite marunit ON marunit.unite_id = ali.marchandise_unite
INNER JOIN transaction trx ON trx.marchandise_id = ali.alimentaire_id
INNER JOIN organisme org ON org.organisme_id = trx.donneur_id
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
INNER JOIN utilisateur util ON util.utilisateur_id = org.utilisateur_contact
WHERE ali.marchandise_statut = 2
AND trx.receveur_id = :receveur_id 
AND (trx.date_reservation, trx.marchandise_id) in
                                    (SELECT MAX(trx.date_reservation) as date_r�servation,
                                            trx.marchandise_id  
                                     FROM transaction trx
                                     WHERE trx.marchandise_id in (SELECT DISTINCT marchandise_id FROM transaction)
                                     AND trx.date_reservation IS NOT NULL  
                                     GROUP BY trx.marchandise_id)                                     
  ORDER BY typali.description_type_aliment, ali.nom, ali.description_alimentaire, ali.quantite;	

-- Test
SELECT typali.description_type_aliment,
    ali.nom,
    ali.description_alimentaire,
    ali.quantite,
    marunit.description_marchandise_unite,
    ali.date_peremption,
    org.nom,
    adr.adresse_id,
    adr.no_civique,
    typrue.description_type_rue,
    adr.nom,
    adr.ville,
    adr.province,
    adr.code_postal,
    adr.pays,
    org.telephone,
    org.poste,
    util.prenom,
    util.nom,
    util.courriel
   
FROM type_aliment typali
INNER JOIN alimentaire ali ON ali.type_alimentaire = typali.aliment_id
INNER JOIN marchandise_unite marunit ON marunit.unite_id = ali.marchandise_unite
INNER JOIN transaction trx ON trx.marchandise_id = ali.alimentaire_id
INNER JOIN organisme org ON org.organisme_id = trx.donneur_id
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
INNER JOIN utilisateur util ON util.utilisateur_id = org.utilisateur_contact
WHERE ali.marchandise_statut = 2
AND trx.receveur_id = 5 
AND (trx.date_reservation, trx.marchandise_id) in
                                    (SELECT MAX(trx.date_reservation) as date_r�servation,
                                            trx.marchandise_id  
                                     FROM transaction trx
                                     WHERE trx.marchandise_id in (SELECT DISTINCT marchandise_id FROM transaction)
                                     AND trx.date_reservation IS NOT NULL  
                                     GROUP BY trx.marchandise_id)                                     
  ORDER BY typali.description_type_aliment, ali.nom, ali.description_alimentaire, ali.quantite;	

-- Profil - requ�tes - information utilisateur
-- Avant de faire la modification sur le profil, il faut envoyer toute l'information sur le profil de l'utilisateur
-- Pour le utilisateur_id, REMPLACER utilisateur_id par une valeur valide.

SELECT 	utilisateur_id,
		mot_de_passe,
		nom,
		prenom,
		courriel,
		telephone,
		moyen_contact,
		organisme_id,
		derniere_connexion
FROM utilisateur
WHERE utilisateur_id = :utilisateur_id;

-- Test
SELECT 	utilisateur_id,
		mot_de_passe,
		nom,
		prenom,
		courriel,
		telephone,
		moyen_contact,
		organisme_id,
		derniere_connexion
FROM utilisateur
WHERE utilisateur_id = 5;

-- Modification profil � cr�er, fichier utilisateur.php, fonction: modifierutilisateur()
-- REMPLACER les variables PHP par des valeurs valides.
-- Je n'ai pas mis organisme_id, derniere_connexion, utilisateur_id car l'usager n'a pas � le faire.
-- Il manque le champ 'poste' pour rejoindre l'usager. Quelque chose qui aura lieu d'ajouter une fois mis.

UPDATE utilisateur SET 	mot_de_passe = :mot_de_passe, 
						nom = :nom,
						prenom = :prenom,
						courriel = :courriel, 
						telephone = :telephone, 
						moyen_contact = :moyen_contact					
WHERE utilisateur_id = :utilisateur_id;

-- Test
UPDATE utilisateur SET 	mot_de_passe = 'test', 
						nom = 'Calille',
						prenom = 'Sylvie',
						courriel = 'test@test.com', 
						telephone = '8195378851', 
						moyen_contact = 1					
WHERE utilisateur_id = 5;

-- Profil - requ�tes - information organisme
-- Avant de faire la modification sur le profil, il faut envoyer toute l'information sur le profil de l'organisme
-- Pour le organisme_id, REMPLACER organisme_id par une valeur valide.
-- Fonction existante par PA. Fichier : organisme.php, fonction: organismeid($id)
-- qui inclut trois requ�tes.

SELECT * FROM organisme WHERE organisme_id = :id;
SELECT * FROM utilisateur WHERE utilisateur_id = :id;
SELECT * FROM adresse INNER JOIN type_rue on adresse.type_rue = type_rue.type_rue_id WHERE adresse_id = :id;

-- Une autre requ�te pourrait �tre propos�e qui toucherait seulement l'organisme et l'adresse.

SELECT 	adr.adresse_id, 
		adr.no_civique, 
		typrue.description_type_rue,
		adr.type_rue,
		adr.nom,
		adr.app,
		adr.ville,
		adr.province,
		adr.code_postal,
		adr.pays,
		org.organisme_id,
		org.nom,
		org.adresse,
		org.telephone,
		org.poste,
		org.utilisateur_contact,
		org.no_entreprise,
		org.no_osbl
FROM organisme org
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
WHERE org.organisme_id = :org.organisme_id;

-- REMPLACER :org.organisme_id par une valeur.

SELECT   adr.adresse_id,
    adr.no_civique,
    typrue.description_type_rue,
	adr.type_rue,
    adr.nom,
    adr.app,
    adr.ville,
    adr.province,
    adr.code_postal,
    adr.pays,
    org.organisme_id,
    org.nom,
	org.adresse,
    org.telephone,
    org.poste,
    org.utilisateur_contact,
    org.no_entreprise,
    org.no_osbl
FROM organisme org
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
WHERE org.organisme_id = 4;

-- Modification profil � cr�er, 
-- REMPLACER les variables PHP par des valeurs valides.

UPDATE adresse SET 	no_civique = :no_civique,
					type_rue = :type_rue,
					nom = :nom,
					app = :app,
					ville = :ville,
					province = :province,
					code_postal = :code_postal,
					pays = :pays
						
WHERE adresse_id = :adresse_id; 

UPDATE organisme SET 	nom = :nom,
						telephone = :telephone,
						poste = :telephone,
						no_entreprise = :no_entreprise,
						no_osbl = :no_osbl
						
WHERE organisme_id = :organisme_id;

-- Test
UPDATE adresse SET 	no_civique = '543',
					type_rue = 2,
					nom = 'Talbot',
					app = NULL,
					ville = 'Chicoutimi',
					province = 'Qu�bec',
					code_postal = 'G7H4A4',
					pays = 'Canada'
						
WHERE adresse_id = 19; 

-- Test

UPDATE organisme SET 	nom = 'La Tabl�e �lisabeth Bruy�re',
						telephone = '8195374884',
						poste = NULL,
						no_entreprise = '1143475094',
						no_osbl = '119009199RR0001 '
						
WHERE organisme_id = 1;

-- Demande � PA
-- Avec sa correction sur la jointure touchant
-- INNER JOIN utilisateur util ON util.utilisateur_id = org.utilisateur_contact
-- remplac�e par :
SELECT 	adr.adresse_id, 
		adr.no_civique, 
		typrue.description_type_rue,
		adr.type_rue,
		adr.nom,
		adr.app,
		adr.ville,
		adr.province,
		adr.code_postal,
		adr.pays,
		util.utilisateur_id,
		util.mot_de_passe,
		util.nom,
		util.prenom,
		util.courriel,
		util.telephone,
		util.moyen_contact,
		util.organisme_id,
		util.derniere_connexion,
		org.organisme_id,
		org.nom,
		org.adresse,
		org.telephone,
		org.poste,
		org.utilisateur_contact,
		org.no_entreprise,
		org.no_osbl
FROM organisme org
INNER JOIN utilisateur util ON util.organisme_id = org.organisme_id
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
WHERE courriel = :courriel 
AND mot_de_passe = :mdp;

-- Test

SELECT 	adr.adresse_id, 
		adr.no_civique, 
		typrue.description_type_rue,
		adr.type_rue,
		adr.nom,
		adr.app,
		adr.ville,
		adr.province,
		adr.code_postal,
		adr.pays,
		util.utilisateur_id,
		util.mot_de_passe,
		util.nom,
		util.prenom,
		util.courriel,
		util.telephone,
		util.moyen_contact,
		util.organisme_id,
		util.derniere_connexion,
		org.organisme_id,
		org.nom,
		org.adresse,
		org.telephone,
		org.poste,
		org.utilisateur_contact,
		org.no_entreprise,
		org.no_osbl
FROM organisme org
INNER JOIN utilisateur util ON util.organisme_id = org.organisme_id
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
WHERE courriel = 'org1@1.ca' 
AND mot_de_passe = '123';

--					--
-- REQU�TE DE STATS --
--					--

-- Pour le receveur les marchandise re�ues
-- Le premier SELECT le receveur_id = :receveur_id
-- Donn�es des tables : transaction (tout), organisme (tout sauf adresse, utilisateur_contact)
-- alimentaire (valeur), type_aliment (description_type_aliment), adresse (tout sauf type_rue), 
-- type_rue (description_type_rue)
-- REMPLACER :receveur_id, :date_debut, :date_fin (dans le premier SELECT le ID joue le r�le de receveur
--	dans le second SELECT le ID joue le r�le de donneur)

SELECT	org.organisme_id,
		org.nom,
		org.telephone,
		org.poste,
		org.no_entreprise,
		org.no_osbl,
		trx.transaction_id,
		trx.receveur_id,
		trx.donneur_id,
		trx.marchandise_id,
		trx.date_collecte,
		trx.date_reservation,
		trx.date_disponible,
		trx.date_transaction,
		ali.valeur,
		typali.description_type_aliment,
		adr.adresse_id,
		adr.no_civique,
		typrue.description_type_rue,
		adr.nom,
		adr.app,
		adr.ville,
		adr.province,
		adr.code_postal,
		adr.pays
			
FROM organisme org
INNER JOIN transaction trx ON trx.receveur_id = org.organisme_id
INNER JOIN alimentaire ali ON ali.alimentaire_id = trx.marchandise_id
INNER JOIN type_aliment typali ON typali.aliment_id = ali.type_alimentaire
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
WHERE 	trx.receveur_id = :receveur_id
AND		trx.date_collecte BETWEEN :date_debut AND :date_fin
AND 	trx.date_collecte IS NOT NULL

UNION

SELECT	org.organisme_id,
		org.nom,
		org.telephone,
		org.poste,
		org.no_entreprise,
		org.no_osbl,
		trx.transaction_id,
		trx.receveur_id,
		trx.donneur_id,
		trx.marchandise_id,
		trx.date_collecte,
		trx.date_reservation,
		trx.date_disponible,
		trx.date_transaction,
		ali.valeur,
		typali.description_type_aliment,
		adr.adresse_id,
		adr.no_civique,
		typrue.description_type_rue,
		adr.nom,
		adr.app,
		adr.ville,
		adr.province,
		adr.code_postal,
		adr.pays
			
FROM organisme org
INNER JOIN transaction trx ON trx.donneur_id = org.organisme_id
INNER JOIN alimentaire ali ON ali.alimentaire_id = trx.marchandise_id
INNER JOIN type_aliment typali ON typali.aliment_id = ali.type_alimentaire
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
WHERE 	trx.donneur_id = :receveur_id
AND		trx.date_collecte BETWEEN :date_debut AND :date_fin
AND 	trx.date_collecte IS NOT NULL;

-- Test

SELECT    org.organisme_id,
        org.nom,
        org.telephone,
        org.poste,
        org.no_entreprise,
        org.no_osbl,
        trx.transaction_id,
        trx.receveur_id,
        trx.donneur_id,
        trx.marchandise_id,
        trx.date_collecte,
        trx.date_reservation,
        trx.date_disponible,
        trx.date_transaction,
        ali.valeur,
        typali.description_type_aliment,
        adr.adresse_id,
        adr.no_civique,
        typrue.description_type_rue,
        adr.nom,
        adr.app,
        adr.ville,
        adr.province,
        adr.code_postal,
        adr.pays
            
FROM organisme org
INNER JOIN transaction trx ON trx.receveur_id = org.organisme_id
INNER JOIN alimentaire ali ON ali.alimentaire_id = trx.marchandise_id
INNER JOIN type_aliment typali ON typali.aliment_id = ali.type_alimentaire
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
WHERE     trx.receveur_id = 4
AND        trx.date_collecte BETWEEN '2016-01-25 18:52:33' AND '2016-02-06 18:52:33'
AND     trx.date_collecte IS NOT NULL

UNION

SELECT  org.organisme_id,
    org.nom,
    org.telephone,
    org.poste,
    org.no_entreprise,
    org.no_osbl,
    trx.transaction_id,
    trx.receveur_id,
    trx.donneur_id,
    trx.marchandise_id,
    trx.date_collecte,
    trx.date_reservation,
    trx.date_disponible,
    trx.date_transaction,
    ali.valeur,
    typali.description_type_aliment,
    adr.adresse_id,
    adr.no_civique,
    typrue.description_type_rue,
    adr.nom,
    adr.app,
    adr.ville,
    adr.province,
    adr.code_postal,
    adr.pays
      
FROM organisme org
INNER JOIN transaction trx ON trx.donneur_id = org.organisme_id
INNER JOIN alimentaire ali ON ali.alimentaire_id = trx.marchandise_id
INNER JOIN type_aliment typali ON typali.aliment_id = ali.type_alimentaire
INNER JOIN adresse adr ON adr.adresse_id = org.adresse
INNER JOIN type_rue typrue ON typrue.type_rue_id = adr.type_rue
WHERE   trx.donneur_id = 4
AND     trx.date_collecte BETWEEN '2016-01-25 18:52:33' AND '2016-02-06 18:52:33'
AND   trx.date_collecte IS NOT NULL;
