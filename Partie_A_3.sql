CREATE MATERIALIZED VIEW mv_synthese_segments AS
SELECT cl.segment, COUNT(co.id) AS nb_commandes, SUM(co.montant_total) AS ca_total
FROM clients cl
JOIN commandes co ON co.client_id = cl.id
GROUP BY cl.segment;

SELECT * FROM mv_synthese_segments;

-- test

INSERT INTO commandes (id, client_id, date_commande, statut, canal, montant_total)
VALUES (241, 1, '2026-11-19', 'LIVREE', 'web', 100);


-- bien obsolète
SELECT * FROM mv_synthese_segments;

-- mise a jour bien effectuée 
REFRESH MATERIALIZED VIEW mv_synthese_segments;
SELECT * FROM mv_synthese_segments;