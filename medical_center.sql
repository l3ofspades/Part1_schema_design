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
    doctor_id INT REFERENCES doctors(doctor_id),
    patient_id INT REFERENCES patients(patient_id),
    visit_date DATE NOT NULL 
);

CREATE TABLE visit_diseases (
    visit_id INT REFERENCES visits(visit_id),
    disease_id INT REFERENCES diseases(disease_id),
    PRIMARY KEY (visit_id, disease_id)
);

INSERT INTO doctors (name, specialty) VALUES
('Dr. Jane', 'Cardiology'),
('Dr. Smith', 'Pediatrics');

INSERT INTO patients(name, date_of_birth) VALUES
('Jonathan Martinez', '10-13-1989'),
('Kurt Russell', '03-17-1951');

INSERT INTO diseases (name, date_of_birth) VALUES
('Hypertension', 'High blood pressure'),
('Flu', 'Influenza virus');

INSERT INTO visits (doctor_id, patient_id, visit_date) VALUES
(1, 1, '09-15-2025'),
(2, 2, '09-16-2025');

INSERT INTO visit_diseases (visit_id, disease_id) VALUES 
(1, 1),
(2, 2);

--Which patients did Dr. Jain see?
SELECT p.name AS patient, dis.name AS disease_id
FROM visits v
JOIN doctors d ON v.doctor_id = d.doctor_id 
JOIN patients p ON v.patient_id = p.patient_id
WHERE d.name = 'Dr Jain';

--Which diseases has Jonathan been diagnosed with?
SELECT p.name AS patient, dis.name AS disease
FROM visits v 
JOIN patients p ON v.patient_id = p.patient_id
JOIN visit_diseases vd ON v.visit_id = vd.visit_id
JOIN diseases dis ON vd.disease_id = dis.disease_id 
WHERE p.name = 'Jonathan Martinez';


