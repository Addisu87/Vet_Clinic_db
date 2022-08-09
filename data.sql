/* Populate database with sample data. */
-- DAY 1 - Create animals table.

INSERT INTO animals (
  name, 
  date_of_birth,
  escape_attempts,
  neutered,
  weight_kg
  ) 
VALUES ('Agumon', '2020-02-03', 0, true, 10.23),
 ('Gabumon', '2018-11-15', 2, true, 8),
 ('Pikachu', '2021-01-07', 1, false, 15.04),
 ('Devimon', '2017-05-12', 5, true, 11);

-- DAY 2 - Query and Update animals table.
INSERT INTO animals (
    name,
    date_of_birth,
    escape_attempts,
    neutered,
    weight_kg
  )
VALUES ('Charmander', '2020-02-08', 0, false, -11),
  ('Plantmon', '2021-11-15', 2, true, -5.7),
  ('Squirtle', '1993-04-02', 3, false, -12.13),
  ('Angemon', '2005-06-12', 1, true, -45),
  ('Boarmon', '2005-06-07', 7,  false, 20.4),
  ('Blossom', '1998-10-13', 3, true, 17),
  ('Ditto', '2022-05-14', 4, true, 22);

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