-- voir les 2 tableaux dans Images en .png


-- **Cassandra** : modèle calqué sur `col_telemetrie` du cours, avec `partition_key = vehicule_id:date` et `clustering_key = heure` (28 800 points par véhicule et par jour).
-- **Redis** : clé de type `position:veh_042` avec un TTL court, accès en O(1) pour afficher la dernière position (classé AP/EL dans le cours).
-- **Neo4j** : le cours ne le classe pas dans PACELC ; en cluster il fonctionne avec un leader, d'où l'hypothèse CP / PC-EC. L'enjeu CAP est peu critique ici puisqu'une suggestion légèrement périmée reste acceptable.

-- ```
-- Véhicules (GPS, 1 point / 3 s) ──► Cassandra    historique des positions
--                             └──► Redis        dernière position (TTL court)
-- Fin de trajet ────────────────────► PostgreSQL   trajet, facture, paiement (transaction ACID)
-- Clients et itinéraires ───────────► Neo4j        relations CONNAIT, EMPRUNTE (suggestions)
-- ```

-- Chaque moteur est utilisé pour ce qu'il fait de mieux, au sein d'un même système d'information. Contrepartie : plus de moteurs à exploiter et à synchroniser.