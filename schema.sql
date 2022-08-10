/* Database schema to keep the structure of entire database. */

-- DAY-1
CREATE TABLE animals(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(100),
    date_of_birth DATE, 
    escape_attempts INT,
    neutered BOOLEAN,
    weight_kg DECIMAL,
    PRIMARY KEY(id)
);

--DAY-2

ALTER TABLE animals
ADD species VARCHAR(50);

--DAY-3

--Create a table named owners with the following columns(id, full_name, age)
-- Create a table named species with the following columns(id, name)
--Modify animals table

DROP TABLE IF EXISTS owners;
DROP TABLE IF EXISTS species;

CREATE TABLE owners(
    id INT GENERATED ALWAYS AS IDENTITY,
    full_name VARCHAR(50),
    age INT,
    PRIMARY KEY(id)
    
);

CREATE TABLE species(
    id INT GENERATED ALWAYS AS IDENTITY,
    name VARCHAR(50), 
    PRIMARY KEY(id)
);

-- Remove column species
ALTER TABLE animals DROP COLUMN species;

-- Add column species_id which is a foreign key referencing species table

ALTER TABLE animals ADD species_id INT;

ALTER TABLE animals
    ADD CONSTRAINT species_id
        FOREIGN KEY (species_id)
            REFERENCES species(id)

;
-- Add column owner_id which is a foreign key referencing the owners table

ALTER TABLE animals ADD owner_id INT;

ALTER TABLE animals
    ADD CONSTRAINT owner_id
        FOREIGN KEY (owner_id)
            REFERENCES owners(id)
;