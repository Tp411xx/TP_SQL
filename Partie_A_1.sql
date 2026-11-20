EXPLAIN ANALYZE
SELECT id, client_id, date_commande, montant_total
FROM commandes
WHERE statut = 'LIVREE' AND YEAR(date_commande) = 2026
ORDER BY montant_total DESC
LIMIT 10;

-- 1. Seq Scan complet sur `commandes` : `YEAR()` appliqué à la colonne rend le prédicat non SARGable,
-- donc aucun index B-Tree ne peut servir (cours, Module 1, piège 1). 
-- Le temps croît avec la taille de la table, en O(N).


-- 2. Sort sur `montant_total DESC` : aucun index ne fournit l'ordre,
-- donc le moteur doit trier toutes les lignes retenues par le filtre avant de livrer les 10 premières.