CREATE TABLE regions (
    region_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE users (
    user_id SERIAL PRIMARY KEY,
    username VARCHAR(100) NOT NULL UNIQUE,
    perferred_region_id INT REFERENCES regions(region_id)
);

CREATE TABLE categories (
    category_id SERIAL PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
);

CREATE TABLE post (
    post_id SERIAL PRIMARY KEY,
    title VARCHAR(200) NOT NULL,
    body TEXT,
    user_id INT REFERENCES users(user_id),
    location VARCHAR(200),
    region_id INT REFERENCES regions(region_id)
);


INSERT INTO regions (name) VALUES
('SAN ANTONIO'),
('PHOENIX'),
('NEW YORK');

INSERT INTO users (username, preferred_region_id)
('Jonm61', 1),
('RavenWolf13', 3);

INSERT INTO categories (name) VALUES
('Housing'),
('Jobs'),
('For Sale');

INSERT INTO post (title, body, user_id, location, region_id) VALUES
('Apartment for Rent', '2 bed/2 bath in downtown SA', 1, 'Downtown' 1),
('Software Engineer Positon', 'Looking for full-stack devs in Seattle', 2, 'Capital Hill', 3);

INSERT INTO post_categories (post_id, category_id) VALUES
(1, 1), --APARTMENT --> HOUSING
(2, 2); --JOB POST --> JOBS

-- find all posts in San Antonio

SELECT p.title, u.username, r.name AS region_id
FROM posts p 
JOIN users u ON p.user_id = u.user_id
JOIN regions r ON p.region_id = r.region_id
WHERE r.name = 'San Antonio';

-- Find all categories for "Apartment for rent"

SELECT p.title, u.username, r.name AS region_id
FROM post p
JOIN post_categories pc ON p.post_id = pc.post_id 
JOIN categories c ON pc.category_id = c.category_id
WHERE p.title = 'Apartment for Rent';
