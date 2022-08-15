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

--DAY-4
--Insert the following data for vets:
-- start a transaction
BEGIN;
INSERT INTO vets(name,age,date_of_graduation)
VALUES('William Tatcher', 45, '2000-04-23'), 
  ('Maisy Smith', 26, '2019-01-17'),
  ('Stephanie Mendez', 64, '1981-05-04'),
  ('Jack Harkness', 38, '2008-06-08')
;
COMMIT;

-- Insert the following data for specialties:
-- Vet William Tatcher is specialized in Pokemon.
-- Vet Stephanie Mendez is specialized in Digimon and Pokemon.
-- Vet Jack Harkness is specialized in Digimon.

BEGIN;
INSERT INTO specializations (vet_id, species_id)
VALUES (1, 1),
  (3, 1),
  (3, 2),
  (4, 2);
COMMIT;

--Insert the following data for visits:
BEGIN;
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES (1, 1, '2020-05-24'),
  (3, 1, '2020-07-22'),
  (4, 2, '2021-02-02'),
  (2, 3, '2020-01-05'),
  (2, 3, '2020-03-08'),
  (2, 3, '2020-05-14'),
  (3, 4, '2021-05-04'),
  (4, 5, '2021-02-24'),
  (2, 6, '2019-12-21'),
  (1, 6, '2020-08-10'),
  (2, 6, '2021-04-07'),
  (3, 7, '2019-09-29'),
  (4, 8, '2020-10-03'),
  (4, 8, '2020-11-04'),
  (2, 9, '2019-01-24'),
  (2, 9, '2019-05-15'),
  (2, 9, '2020-02-27'),
  (2, 9, '2020-08-03'),
  (3, 10, '2020-05-24'),
  (1, 10, '2021-01-11');
COMMIT;

-- Alternatively
BEGIN;
INSERT INTO visits (vet_id, animal_id, date_of_visit)
VALUES((SELECT id FROM vets WHERE name = 'William Tatcher'),(SELECT id FROM animals WHERE name = 'Agumon'), '2020-05-24'),
      ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM animals WHERE name = 'Agumon'), '2020-07-22'),
      ((SELECT id FROM vets WHERE name = 'Jack Harkness'),(SELECT id FROM animals WHERE name = 'Gabumon'), '2021-02-02'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'),(SELECT id FROM animals WHERE name = 'Pikachu'), '2020-01-05'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'),(SELECT id FROM animals WHERE name = 'Pikachu'), '2020-03-08'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'),(SELECT id FROM animals WHERE name = 'Pikachu'), '2020-05-14'),
      ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM animals WHERE name = 'Devimon'), '2021-05-04'),
      ((SELECT id FROM vets WHERE name = 'Jack Harkness'),(SELECT id FROM animals WHERE name = 'Charmander'), '2021-02-24'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'),(SELECT id FROM animals WHERE name = 'Plantmon'), '2019-12-21'),
      ((SELECT id FROM vets WHERE name = 'William Tatcher'),(SELECT id FROM animals WHERE name = 'Plantmon'), '2020-08-10'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'),(SELECT id FROM animals WHERE name = 'Plantmon'), '2021-04-07'),
      ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM animals WHERE name = 'Squirtle'), '2019-09-29'),
      ((SELECT id FROM vets WHERE name = 'Jack Harkness'),(SELECT id FROM animals WHERE name = 'Angemon'), '2020-10-03'),
      ((SELECT id FROM vets WHERE name = 'Jack Harkness'), (SELECT id FROM animals WHERE name = 'Angemon'), '2020-11-04'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'),(SELECT id FROM animals WHERE name = 'Boarmon'), '2019-01-24'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'), (SELECT id FROM animals WHERE name = 'Boarmon'),'2019-05-15'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'),(SELECT id FROM animals WHERE name = 'Boarmon'), '2020-02-27'),
      ((SELECT id FROM vets WHERE name = 'Maisy Smith'),(SELECT id FROM animals WHERE name = 'Boarmon'), '2020-08-03'),
      ((SELECT id FROM vets WHERE name = 'Stephanie Mendez'),(SELECT id FROM animals WHERE name = 'Blossom'), '2020-05-24'),
      ((SELECT id FROM vets WHERE name = 'William Tatcher'),(SELECT id FROM animals WHERE name = 'Blossom'), '2021-01-11');
COMMIT;


--DAY-5 (WEEK-2)

-- This will add 3.594.280 visits considering you have 10 animals, 4 vets, and it will use around ~87.000 timestamps (~4min approx.)
INSERT INTO visits (animal_id, vet_id, date_of_visit)
 SELECT * FROM (SELECT id FROM animals) animal_ids, 
 (SELECT id FROM vets) vets_ids, generate_series('1980-01-01'::timestamp, '2021-01-01', '4 hours') visit_timestamp;

-- This will add 2.500.000 owners with full_name = 'Owner <X>' and email = 'owner_<X>@email.com' (~2min approx.)
insert into owners (full_name, email)
select 'Owner ' || generate_series(1,2500000), 'owner_' || generate_series(1,2500000) || '@mail.com';


