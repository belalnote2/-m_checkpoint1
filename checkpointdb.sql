DROP TABLE IF EXISTS items;
DROP TABLE IF EXISTS contacts;
DROP TABLE IF EXISTS contact_types;
DROP TABLE IF EXISTS contact_categories;

CREATE TABLE contact_categories (
    id SERIAL PRIMARY KEY,
    contact_category VARCHAR(255) NOT NULL
);

CREATE TABLE contact_types (
    id SERIAL PRIMARY KEY,
    contact_type VARCHAR(255) NOT NULL
);

CREATE TABLE contacts (
    id SERIAL PRIMARY KEY,
    first_name VARCHAR(255) NOT NULL,
    last_name VARCHAR(255) NOT NULL,
    title VARCHAR(255),
    organization VARCHAR(255)
);

CREATE TABLE items (
    contact VARCHAR(255) NOT NULL,
    contact_id INTEGER NOT NULL,
    contact_type_id INTEGER NOT NULL,
    contact_category_id INTEGER NOT NULL,
    CONSTRAINT fk_contact FOREIGN KEY (contact_id) REFERENCES contacts(id),
    CONSTRAINT fk_contact_type FOREIGN KEY (contact_type_id) REFERENCES contact_types(id),
    CONSTRAINT fk_contact_category FOREIGN KEY (contact_category_id) REFERENCES contact_categories(id),
    CONSTRAINT cpk_items PRIMARY KEY (contact_id, contact_type_id, contact_category_id)
);




-- Insert data into contact_categories table
INSERT INTO contact_categories (id, contact_category) VALUES
(1, 'Home'),
(2, 'Work'),
(3, 'Fax');

-- Insert data into contact_types table
INSERT INTO contact_types (id, contact_type) VALUES
(1, 'Email'),
(2, 'Phone'),
(3, 'Skype'),
(4, 'Instagram');

-- Insert data into contacts table
INSERT INTO contacts (id, first_name, last_name, title, organization) VALUES
(1, 'Erik', 'Eriksson', 'Teacher', 'Utbildning AB'),
(2, 'Anna', 'Sundh', NULL, NULL),
(3, 'Goran', 'Bregovic', 'Coach', 'Dalens IK'),
(4, 'Ann-Marie', 'Bergqvist', 'Cousin', NULL),
(5, 'Herman', 'Appelkvist', NULL, NULL);

-- Insert data into items table
INSERT INTO items (contact_id, contact_type_id, contact_category_id, contact) VALUES
(3, 2, 1, '011-12 33 45'),
(3, 1, 2, 'goran@infoab.se'),
(4, 2, 2, '010-88 55 44'),
(1, 1, 1, 'erik57@hotmail.com'),
(2, 4, 1, '@annapanna99'),
(2, 2, 1, '077-563578'),
(3, 2, 2, '070-156 22 78');



-- 1.5 Insert a new row into the contacts table with my own name
INSERT INTO contacts (id, first_name, last_name, title, organization) VALUES
(6, 'bel', 'abbd', 'Dataeng', 'Tech Solutions');

-- Insert a new contact into the items table for myself
INSERT INTO items (contact_id, contact_type_id, contact_category_id, contact) VALUES
(6, 1, 2, 'bel.abbd@techsolutions.com');


--1.6 unused contact Type
SELECT id, contact_type
FROM contact_types
WHERE id NOT IN (
    SELECT DISTINCT contact_type_id
    FROM items
);


--1.7 Create view 
CREATE VIEW view_contacts AS
SELECT 
    c.first_name,
    c.last_name,
    i.contact,
    ct.contact_type,
    cc.contact_category
FROM 
    contacts c
JOIN 
    items i ON c.id = i.contact_id
JOIN 
    contact_types ct ON i.contact_type_id = ct.id
JOIN 
    contact_categories cc ON i.contact_category_id = cc.id;

--1.8 Create list all query without id column
SELECT 
    c.first_name,
    c.last_name,
    c.title,
    c.organization,
    i.contact,
    ct.contact_type,
    cc.contact_category
FROM 
    contacts c
JOIN 
    items i ON c.id = i.contact_id
JOIN 
    contact_types ct ON i.contact_type_id = ct.id
JOIN 
    contact_categories cc ON i.contact_category_id = cc.id;


--1.9 we could use an additionel new primary key (id) for ITEM table: by that we 
--ensure the uniquness of the primary key So in case composit primary key of 
--(contact_id, contact_type_id,contact_category_id)  does repeat the additional promary key help in ensuring the
-- existanse of uniqe value to acces the data: id SERIAL PRIMARY KEY.





