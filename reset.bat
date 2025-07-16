@echo off
setlocal

:: Paramètres de connexion
set PGUSER=postgres
:: NE PAS définir PGPASSWORD ici
set PGDATABASE=biblio
set PGPORT=5432
set PGHOST=localhost
:: Supprimer les données dans l'ordre de dépendance
echo Suppression des données...
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "DELETE FROM rendu;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "DELETE FROM reservation;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "DELETE FROM prolongement;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "DELETE FROM pret;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "DELETE FROM inscription;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "DELETE FROM exemplaire;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "DELETE FROM livre;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "DELETE FROM adherent;"

:: Réinitialisation des séquences
echo Réinitialisation des séquences...
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "ALTER SEQUENCE adherent_id_adherent_seq RESTART WITH 1;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "ALTER SEQUENCE livre_id_livre_seq RESTART WITH 1;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "ALTER SEQUENCE exemplaire_id_exemplaire_seq RESTART WITH 1;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "ALTER SEQUENCE pret_id_pret_seq RESTART WITH 1;"
psql -U %PGUSER% -d %PGDATABASE% -h %PGHOST% -p %PGPORT% -c "ALTER SEQUENCE reservation_id_reservation_seq RESTART WITH 1;"

echo Réinitialisation terminée avec succès.
pause
