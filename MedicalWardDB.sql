-- Create the database
CREATE DATABASE MedicalWardDB;
USE MedicalWardDB;

-- Table: Ward
CREATE TABLE Ward (
    ward_id INT AUTO_INCREMENT PRIMARY KEY,
    ward_name VARCHAR(20) UNIQUE NOT NULL
);

-- Table: Doctor
CREATE TABLE Doctor (
    doctor_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL
);

-- Table: Shift (assume 8hr shifts, 5 days a week to make 40hrs)
CREATE TABLE Shift (
    shift_id INT AUTO_INCREMENT PRIMARY KEY,
    shift_day ENUM('Monday', 'Tuesday', 'Wednesday', 'Thursday', 'Friday') NOT NULL,
    start_time TIME NOT NULL,
    end_time TIME NOT NULL
);

-- Table: DoctorShift (many-to-many between doctor and shift)
CREATE TABLE DoctorShift (
    doctor_id INT,
    shift_id INT,
    PRIMARY KEY (doctor_id, shift_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id),
    FOREIGN KEY (shift_id) REFERENCES Shift(shift_id)
);

-- Table: Patient
CREATE TABLE Patient (
    patient_id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    gender ENUM('Male', 'Female') NOT NULL,
    dob DATE NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    phone VARCHAR(20) UNIQUE NOT NULL,
    ward_id INT,
    FOREIGN KEY (ward_id) REFERENCES Ward(ward_id)
);

-- Table: Appointment (clinic day: Thursday only)
CREATE TABLE Appointment (
    appointment_id INT AUTO_INCREMENT PRIMARY KEY,
    patient_id INT,
    doctor_id INT,
    appointment_datetime DATETIME NOT NULL,
    purpose VARCHAR(100),
    FOREIGN KEY (patient_id) REFERENCES Patient(patient_id),
    FOREIGN KEY (doctor_id) REFERENCES Doctor(doctor_id)
);

-- Insert Wards
INSERT INTO Ward (ward_name) VALUES ('Male'), ('Female');

-- Insert Doctors
INSERT INTO Doctor (name, gender, email, phone) VALUES
('John Karani', 'Male', 'jkarani@hospital.org', '0712345678'),
('Grace Mukami', 'Female', 'gmukami@hospital.org', '0723456789'),
('Martin Wafula', 'Male', 'mwafula@hospital.org', '0734567890');

-- Insert Shifts (Assuming 8-hour day shifts)
INSERT INTO Shift (shift_day, start_time, end_time) VALUES
('Monday', '08:00:00', '16:00:00'),
('Tuesday', '08:00:00', '16:00:00'),
('Wednesday', '08:00:00', '16:00:00'),
('Thursday', '08:00:00', '16:00:00'),
('Friday', '08:00:00', '16:00:00');

-- Assign Doctors to Shifts (alternate doctors)
INSERT INTO DoctorShift (doctor_id, shift_id) VALUES
(1, 1), -- John - Monday
(2, 2), -- Grace - Tuesday
(3, 3), -- Martin - Wednesday
(1, 4), -- John - Thursday
(2, 5); -- Grace - Friday

-- Insert Patients 
INSERT INTO Patient (name, gender, dob, email, phone, ward_id) VALUES
('Michael Otieno', 'Male', '1985-04-12', 'motieno@example.com', '0701002003', 1),
('Beatrice Wanjiku', 'Female', '1992-08-25', 'bwanjiku@example.com', '0712003004', 2),
('Kevin Mwangi', 'Male', '2000-03-11', 'kmwangi@example.com', '0723004005', 1),
('Sarah Njeri', 'Female', '1996-12-01', 'snjeri@example.com', '0734005006', 2);

-- Insert Thursday Appointments (for Thursday clinic)
INSERT INTO Appointment (patient_id, doctor_id, appointment_datetime, purpose) VALUES
(1, 1, '2025-05-15 09:00:00', 'Hypertension Review'),
(2, 2, '2025-05-15 10:30:00', 'Diabetes Management'),
(3, 3, '2025-05-15 13:00:00', 'General Checkup'),
(4, 1, '2025-05-15 14:30:00', 'Follow-up on Labs');
