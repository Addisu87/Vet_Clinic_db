/*Queries that provide answers to the questions from all projects.*/

-- DAY-1
-- Find all animals whose name ends in "mon".
SELECT * FROM animals WHERE name LIKE '%mon%';

-- List the name of all animals born between 2016 and 2019.
SELECT * FROM animals WHERE date_of_birth BETWEEN '2016/01/01' AND '2019/12/31';

SELECT * FROM animals WHERE neutered = true AND escape_attempts < 3;

SELECT date_of_birth FROM animals WHERE name IN ('Agumon', 'Pikachu');

SELECT name, escape_attempts FROM animals WHERE Weight_kg > 10.5;

SELECT * FROM animals WHERE neutered = true;

SELECT * FROM animals WHERE NOT name = 'Gabumon';

SELECT * FROM animals WHERE Weight_kg BETWEEN 10.4 AND 17.3;

-- DAY 2

-- Inside a transaction update the animals table by setting the species column to unspecified.
-- Roll back the change and verify that the species columns went back to the state before the transaction.

BEGIN;
UPDATE animals 
SET species = 'unspecified';
TABLE animals;
ROLLBACK;
TABLE animals;

--Update the animals table by setting the species column to digimon for all animals that have a name ending in mon.
-- Update the animals table by setting the species column to pokemon for all animals that don't have species already set.
-- Commit the transaction.
BEGIN; 
UPDATE animals
SET species = 'digimon'
WHERE name LIKE '%mon%';
UPDATE animals 
SET species = 'pokemon'
WHERE species IS NULL;
TABLE animals;
COMMIT;

-- Delete all records in the animals table, then roll back the transaction.
BEGIN;
DELETE FROM animals;
TABLE animals;
ROLLBACK;
TABLE animals;

-- Delete all animals born after Jan 1st, 2022.
-- Create a savepoint for the transaction.
-- Update all animals' weight to be their weight multiplied by -1.
-- Rollback to the savepoint
-- Update all animals' weights that are negative to be their weight multiplied by -1.
-- Commit transaction

BEGIN;
DELETE FROM animals WHERE date_of_birth > '2022-01-01';
SAVEPOINT sp1;
UPDATE animals SET weight_kg = weight_kg * -1;
ROLLBACK TO sp1;
UPDATE animals SET weight_kg = weight_kg * -1
WHERE weight_kg < 0;
TABLE animals;
COMMIT;

-- How many animals are there?
SELECT COUNT(*)
FROM animals;
-- How many animals have never tried to escape?
SELECT COUNT(escape_attempts)
FROM animals
WHERE escape_attempts = 0;
-- What is the average weight of animals?
SELECT AVG(weight_kg)
FROM animals;
-- Who escapes the most, neutered or not neutered animals?
SELECT AVG(escape_attempts)
FROM animals
GROUP BY neutered;
-- What is the minimum and maximum weight of each type of animal?
SELECT species,
  MIN(weight_kg) as MIN_WEIGHT,
  MAX(weight_kg) as MAX_WEIGHT
FROM animals
GROUP BY species;
-- What is the average number of escape attempts per animal type of those born between 1990 and 2000?
SELECT species,
  AVG(escape_attempts) as Average_escape_attempts
FROM animals
WHERE date_of_birth BETWEEN '1990-01-01' AND '2000-12-31'
GROUP BY species;

--DAY-3
-- Write queries (using JOIN) to answer the following questions:

-- What animals belong to Melody Pond?
SELECT name as animal_name
FROM owners
  INNER JOIN animals ON owners.id = animals.owner_id
WHERE owners.id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Melody Pond'
);
 
-- List of all animals that are pokemon (their type is Pokemon).
SELECT animals.name FROM animals
INNER JOIN species ON animals.species_id = species.id
WHERE species.id = (
    SELECT id FROM species WHERE name = 'Pokemon'
);
-- List all owners and their animals, remember to include those that don't own any animal.
SELECT full_name as Pet_Owner, name as Animal_name
FROM owners
LEFT JOIN animals
ON owners.id = animals.owner_id;

-- How many animals are there per species?
SELECT species.name,
    COUNT(*) as Quantity
FROM animals
LEFT JOIN species 
ON animals.species_id = species.id
GROUP BY species.name;

-- List all Digimon owned by Jennifer Orwell.
SELECT animals.name as Pet
FROM animals
  INNER JOIN species ON animals.species_id = species.id
WHERE species.id = (
    SELECT id
    FROM species
    WHERE name = 'Digimon'
  )
  AND animals.owner_id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Jennifer Orwell'
  );

-- List all animals owned by Dean Winchester that haven't tried to escape.
SELECT animals.name as Pet
FROM animals
  INNER JOIN owners ON animals.owner_id = owners.id
WHERE owners.id = (
    SELECT id
    FROM owners
    WHERE full_name = 'Dean Winchester'
  )
  AND animals.escape_attempts = 0;
  
-- Who owns the most animals?
SELECT full_name as Owner_Name,
    COUNT(full_name) total
FROM animals
  INNER JOIN owners ON animals.owner_id = owners.id
GROUP BY full_name
ORDER BY total DESC
LIMIT 1;

--DAY-4
--Who was the last animal seen by William Tatcher?
SELECT a.name,
  v.date_of_visit
FROM animals a
  INNER JOIN visits v ON a.id = v.animal_id
WHERE v.vet_id = (
    SELECT id
    FROM vets
    WHERE vets.name = 'William Tatcher'
  )
ORDER BY date_of_visit DESC
LIMIT 1;

-- How many different animals did Stephanie Mendez see?
SELECT COUNT(*) as viewed_by_Stephanie
FROM (
    SELECT DISTINCT a.name
    FROM animals a
      INNER JOIN visits v ON a.id = v.animal_id
    WHERE v.vet_id = (
        SELECT id
        FROM vets
        WHERE vets.name = 'Stephanie Mendez'
      )
  ) x;
-- List all vets and their specialties, including vets with no specialties.
SELECT vets.name as Vet_name,
  s.name as Specialized_in
FROM vets
  LEFT JOIN specializations sp ON vets.id = sp.vet_id
  LEFT JOIN species s ON sp.species_id = s.id;
-- List all animals that visited Stephanie Mendez between April 1st and August 30th, 2020.
SELECT a.name,
  v.date_of_visit
FROM animals a
  INNER JOIN visits v ON a.id = v.animal_id
WHERE v.vet_id = (
    SELECT id
    FROM vets ve
    WHERE ve.name = 'Stephanie Mendez'
  )
  AND v.date_of_visit BETWEEN '2020-04-01' AND '2020-08-30';
-- What animal has the most visits to vets?
SELECT a.name,
  COUNT(*)
FROM animals a
  INNER JOIN visits v ON a.id = v.animal_id
GROUP BY a.name
ORDER BY count DESC
LIMIT 1;
-- Who was Maisy Smith's first visit?
SELECT a.name,
  v.date_of_visit
FROM animals a
  INNER JOIN visits v ON a.id = v.animal_id
WHERE v.vet_id = (
    SELECT id
    FROM vets
    WHERE vets.name = 'Maisy Smith'
  )
ORDER BY date_of_visit ASC
LIMIT 1;

-- Details for most recent visit: animal information, vet information, and date of visit.
SELECT date_of_visit,
  ve.name as Vet,
  a.name as Animal
FROM visits v
  INNER JOIN animals a ON v.animal_id = a.id
  INNER JOIN vets ve ON v.vet_id = ve.id
ORDER BY date_of_visit DESC
LIMIT 1;
-- How many visits were with a vet that did not specialize in that animal's species?
SELECT COUNT(*)
FROM visits v
  JOIN vets ve ON v.vet_id = ve.id
  JOIN animals a ON v.animal_id = a.id
  LEFT JOIN specializations sp ON ve.id = sp.vet_id
WHERE ve.id != (
    SELECT id
    FROM vets
    WHERE name = 'Stephanie Mendez'
  )
  AND sp.species_id != a.species_id
  OR sp.species_id IS NULL;
-- What specialty should Maisy Smith consider getting? Look for the species she gets the most.
SELECT s.name as species,
  COUNT(*)
FROM visits v
  INNER JOIN vets ve ON v.vet_id = ve.id
  INNER JOIN animals a ON v.animal_id = a.id
  INNER JOIN species s ON a.species_id = s.id
WHERE vet_id = (
    SELECT id
    FROM vets
    WHERE vets.name = 'Maisy Smith'
  )
GROUP BY species
ORDER BY count DESC
LIMIT 1;


--DAY-5 (WEEK-2)

EXPLAIN ANALYZE SELECT COUNT(*) FROM visits where animal_id = 4;
EXPLAIN ANALYZE SELECT * FROM visits where vet_id = 2;
EXPLAIN ANALYZE SELECT * FROM owners where email = 'owner_18327@mail.com';