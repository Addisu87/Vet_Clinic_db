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

  -- DAY-3
  
  --Insert the following data into the owners table:
  BEGIN;
  INSERT INTO owners(full_name, age) 
  VALUES ('Sam Smith', 34), 
  ('Jennifer Orwell', 19),
  ('Bob', 45), 
  ('Melody Pond', 77),
  ('Dean Winchester', 14),
  ('Jodie Whittaker', 38)
  ; 
  TABLE owners;
  COMMIT;

  --Insert the following data into the species table:
  BEGIN;
  INSERT INTO species(name)
  VALUES ('Pokemon'), ('Digimon');
  TABLE species;
  COMMIT;

  -- Modify your inserted animals so it includes the species_id value:

  --If the name ends in "mon" it will be Digimon
  --All other animals are Pokemon
BEGIN; 
UPDATE animals
SET species_id = (
  SELECT id 
  FROM species
  WHERE name = 'Digimon'
  )
WHERE name LIKE '%mon%';


UPDATE animals 
SET species_id =(
  SELECT id 
  FROM species
  WHERE name = 'Pokemon'
  )
WHERE species_id IS NULL;
COMMIT;

-- Modify your inserted animals to include owner information (owner_id):

  -- Sam Smith owns Agumon.
BEGIN; 
UPDATE animals
SET owner_id = (
  SELECT id 
  FROM owners
  WHERE full_name = 'Sam Smith'
  )
WHERE name = 'Agumon';
TABLE animals;
COMMIT;

  -- Jennifer Orwell owns Gabumon and Pikachu.
BEGIN; 
UPDATE animals
SET owner_id = (
  SELECT id 
  FROM owners
  WHERE full_name = 'Jennifer Orwell'
  )
WHERE name = 'Gabumon' OR name = 'Pikachu';
TABLE animals;
COMMIT;

  -- Bob owns Devimon and Plantmon.
BEGIN; 
UPDATE animals
SET owner_id = (
  SELECT id 
  FROM owners
  WHERE full_name = 'Bob'
  )
WHERE name IN('Devimon', 'Plantmon');
TABLE animals;
COMMIT;

  -- Melody Pond owns Charmander, Squirtle, and Blossom.
BEGIN; 
UPDATE animals
SET owner_id = (
  SELECT id 
  FROM owners
  WHERE full_name = 'Melody Pond'
  )
WHERE name IN('Charmander','Squirtle','Blossom');
TABLE animals;
COMMIT;

  -- Dean Winchester owns Angemon and Boarmon.
BEGIN; 
UPDATE animals
SET owner_id = (
  SELECT id 
  FROM owners
  WHERE full_name = 'Dean Winchester'
  )
WHERE name IN('Angemon','Boarmon');
TABLE animals;
COMMIT;

