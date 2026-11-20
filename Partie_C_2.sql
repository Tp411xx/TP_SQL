-- Non-Repeatable Read

SELECT solde FROM comptes_bancaires WHERE id = 1;` → **15 000,00**`

UPDATE comptes_bancaires SET solde = solde - 100 WHERE id = 1;

SELECT solde FROM comptes_bancaires WHERE id = 1;` → **14 900,00**`  

-- Repeatable Read

SELECT solde FROM comptes_bancaires WHERE id = 1;` → **15 000,00**`

UPDATE comptes_bancaires SET solde = solde - 100 WHERE id = 1;

SELECT solde FROM comptes_bancaires WHERE id = 1;` → **15 000,00**`

SELECT solde FROM comptes_bancaires WHERE id = 1;` → **14 900,00**`


-- Principe du WAL: chaque modification est d'abord écrite dans le journal WAL, forcé sur disque (`fsync`), avant d'être appliquée aux pages de données.

-- Exemple : virement de 1 000 € du compte 1 (HexaTech, 15 000) vers le compte 2 (NovaLab, 8 400).

UPDATE comptes_bancaires SET solde = solde - 1000 WHERE id = 1;  -- débit
UPDATE comptes_bancaires SET solde = solde + 1000 WHERE id = 2;  -- crédit
COMMIT;

-- Entre le débit et le crédit, avant `COMMIT`.
-- La transaction est incomplète : ses modifications sont annulées (Rollback / Undo) 15 000 / 8 400 |
-- Après `COMMIT` acquitté, Le WAL déjà sur disque, est rejoué (Redo) | 14 000 / 9 400