WITH RECURSIVE organigramme AS (

  -- 1. Ancrage : la CTO (aucun manager), niveau 1
  SELECT id, nom, poste, 1 AS niveau, nom::text AS chemin
  FROM employes
  WHERE manager_id IS NULL
  UNION ALL

  -- 2. Récursion : on descend d'un étage à chaque tour
  SELECT e.id, e.nom, e.poste, o.niveau + 1 AS niveau, o.chemin || ' > ' || e.nom AS chemin
  FROM employes e
  JOIN organigramme o ON e.manager_id = o.id
  WHERE o.niveau < 20 
)

SELECT id, nom, poste, niveau, chemin
FROM organigramme
ORDER BY niveau ASC, id ASC;