-- 1. Disable foreign key checks for safe import
SET FOREIGN_KEY_CHECKS = 0;

-- 2. Clear all tables (in correct order)
-- DELETE FROM LabTest;
-- DELETE FROM Treatment;
-- DELETE FROM Visit;
-- DELETE FROM Doctor;
-- DELETE FROM Patients;

-- 3. Import the CSV files (update the file paths!)

LOAD DATA LOCAL INFILE 'C:/Excelr/Project/Patient Healthcare (5)/Patient Healthcare/Data/CSV Files/patients.csv'
INTO TABLE Patients
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Excelr/Project/Patient Healthcare (5)/Patient Healthcare/Data/CSV Files/doctor.csv'
INTO TABLE Doctor
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Excelr/Project/Patient Healthcare (5)/Patient Healthcare/Data/CSV Files/visit.csv'
INTO TABLE Visit
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Excelr/Project/Patient Healthcare (5)/Patient Healthcare/Data/CSV Files/treatment.csv'
INTO TABLE Treatment
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

LOAD DATA LOCAL INFILE 'C:/Excelr/Project/Patient Healthcare (5)/Patient Healthcare/Data/CSV Files/labtest.csv'
INTO TABLE LabTest
FIELDS TERMINATED BY ','
ENCLOSED BY '"'
LINES TERMINATED BY '\n'
IGNORE 1 ROWS;

-- 4. Turn FK checks back ON
SET FOREIGN_KEY_CHECKS = 1;

-- Done
SELECT "✔ All tables imported successfully" AS Status;



