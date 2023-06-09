/*Queries that provide answers to the questions from all projects.*/

SELECT * FROM animals WHERE name LIKE '%mon';
SELECT name FROM animals WHERE date_of_birth BETWEEN '2016-01-01' AND '2019-12-31';
SELECT name FROM animals WHERE neutered=TRUE and escape_attempts < 3;
SELECT date_of_birth FROM animals WHERE name='Agumon' OR name='Pikachu';
SELECT name, escape_attempts FROM animals WHERE weight_kg > 10.5;
SELECT *  FROM animals WHERE neutered=TRUE;
SELECT *  FROM animals WHERE name !='Gabumon';
SELECT * FROM animals WHERE weight_kg >= 10.4 AND weight_kg <= 17.3;

BEGIN;
UPDATE animals set species ='unspecified';
ROLLBACK;

BEGIN; 
UPDATE animals set species ='digimon' WHERE name like '%mon';
UPDATE animals set species ='pokemon' WHERE species IS NULL;
COMMIT;

BEGIN; 
DELETE FROM animals;
ROLLBACK;

BEGIN; 
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT born_after_2022; 
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK to born_after_2022;
UPDATE animals SET weight_kg = weight_kg * -1 WHERE weight_kg < 0;
COMMIT;

SELECT COUNT(*) as number_of_animals FROM animals;
SELECT COUNT(*) as never_tried_escape FROM animals WHERE escape_attempts = 0;
SELECT AVG(weight_kg) AS average_weight FROM animals;
SELECT name FROM animals WHERE escape_attempts = (SELECT MAX(escape_attempts) FROM animals);
SELECT name FROM animals WHERE neutered = TRUE;
SELECT name FROM animals WHERE neutered = FALSE;
SELECT species,MAX(weight_kg) as max_weight, MIN(weight_kg) AS min_weight FROM animals GROUP BY species;
SELECT species,AVG(escape_attempts) as avg_escape_attempts FROM animals WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31' GROUP BY species;

SELECT COUNT(*) FROM animals AS a JOIN owners AS o ON  o.id = a.owner_id WHERE o.full_name ='Melody Pond';
SELECT a.* FROM animals AS a JOIN species AS s ON  s.id = a.species_id WHERE s.name ='Pokemon';
SELECT o.*,COUNT(a.id) AS animal_number FROM owners AS o LEFT JOIN animals AS a ON  o.id = a.owner_id GROUP BY o.id ORDER BY o.id ASC; 
SELECT s.*,COUNT(a.id) AS animal_number FROM species AS s LEFT JOIN animals AS a ON  s.id = a.species_id GROUP BY s.id ORDER BY s.id ASC; 
SELECT a.* FROM animals AS a JOIN species AS s ON  s.id = a.species_id WHERE s.name ='Digimon' AND a.owner_id = (SELECT id FROM owners WHERE full_name ='Jennifer Orwell');
SELECT a.* FROM animals AS a JOIN owners AS o ON  o.id = a.owner_id WHERE o.full_name ='Dean Winchester' AND a.escape_attempts =0;
SELECT o.*,COUNT(a.id) AS animal_number FROM owners AS o LEFT JOIN animals AS a ON  o.id = a.owner_id GROUP BY o.id ORDER BY animal_number DESC LIMIT 1; 
