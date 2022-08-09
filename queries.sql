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