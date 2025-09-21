CREATE TABLE doctors (
    doctor_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    specialty VARCHAR(100)
);

CREATE TABLE patients (
    patient_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL, 
    date_of_birth DATE
);

CREATE TABLE diseases (
    diseases_id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    description TEXT
);

CREATE TABLE visits (
    visit_id SERIAL PRIMARY KEY,
    doctor_id INT REFERENCES doctors()
)