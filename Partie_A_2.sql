CREATE INDEX idx_cmd_statut_date_montant
  ON commandes (statut, date_commande, montant_total);


EXPLAIN ANALYZE
SELECT id, client_id, date_commande, montant_total
FROM commandes
WHERE statut = 'LIVREE'
  AND date_commande >= '2026-01-01'
  AND date_commande <  '2027-01-01'
ORDER BY montant_total DESC
LIMIT 10;


avant (pas SARGable )

Limit
Coût : 72.21..74.16
Lignes : 10
Temps : 8.53 ms
Buffers : 14 hit / 4 read
LIMIT 10

Sort
Coût : 72.21..74.16
Lignes : 39
Temps : 8.53 ms
Buffers : 14 hit / 4 read
Tri sur montant_total DESC

Seq Scan
sur commandes
Coût : 0..68.7
Lignes : 39
Temps : 8.08 ms
Buffers : 14 hit / 4 read
Filtre : statut = LIVREE AND YEAR ( date_commande ) = 2026)


après :

Limit
Coût : 15..16.95
Lignes : 10
Temps : 0.83 ms
Buffers : 4 hit / 0 read
LIMIT 10

Sort
Coût : 15..16.95
Lignes : 39
Temps : 0.83 ms
Buffers : 4 hit / 0 read
Tri sur montant_total DESC

Index Scan
sur commandes
via idx_commandes_livrees_sans_statut
Accès optimisé
Coût : 0.15..11.49
Lignes : 39
Temps : 0.38 ms
Buffers : 4 hit / 0 read
Filtre : statut = LIVREE AND date_commande >= 2026-01-01 AND date_commande < 2027-01-01

-- Donc on voit bien qu'après on a moins de coût en utilisant moins de temps -> optimisé

-- Le partition pruning est une technique d'optimisation de bases de données qui consiste à ignorer automatiquement les partitions inutiles lors de l'exécution d'une requête,
-- réduisant ainsi considérablement le volume de données lues et le temps de réponse.