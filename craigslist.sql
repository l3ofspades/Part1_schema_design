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
