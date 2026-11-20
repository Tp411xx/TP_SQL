-- le piège est : 
SELECT id, nom FROM employes
WHERE id NOT IN (SELECT manager_id FROM employes);



-- La CTO a `manager_id = NULL`, donc la sous-requête renvoie une liste contenant un NULL. `id NOT IN (1, 2, 3, 4, 5, 7, NULL)` équivaut à `id <> 1 AND id <> 2 AND ... AND id <> NULL`, et toute comparaison avec NULL vaut UNKNOWN :

-- si l'`id` figure dans la liste (les managers 1, 2, 3, 4, 5, 7), un des termes est FALSE et le résultat est FALSE ;
-- sinon, tous les termes valent TRUE sauf `id <> NULL` qui vaut UNKNOWN, et le résultat est UNKNOWN.

--`WHERE` ne conserve que les lignes TRUE : aucune ligne n'est retournée.

-- correction fiable 
SELECT id, nom FROM employes
WHERE id NOT IN (SELECT manager_id FROM employes WHERE manager_id IS NOT NULL);