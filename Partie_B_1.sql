-- 1FN : projets_liste contient plusieurs projets, donc on met une ligne par couple (employé, projet)

-- Dépendances fonctionnelles : Un employe_id donne le nom et le département, un projet donne son chef, et un chef donne son téléphone.

-- 2FN : une table des employés et une table des projets, plus une table affectations qui les relie.

-- 3FN : le téléphone dépend du chef, pas du projet. On crée donc une table chefs_projet.


--  departements(dept_id PK, dept_nom)
--  employes(employe_id PK, employe_nom, dept_id FK → departements)
--  chefs_projet(chef_id PK, chef_nom, chef_tel)
--  projets(projet_id PK, projet_nom, chef_id FK → chefs_projet)
--  affectations(employe_id FK → employes, projet_id FK → projets, PK(employe_id, projet_id))