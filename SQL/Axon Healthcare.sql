create database Axon;
use Axon;
CREATE TABLE Patients (
    `Patient ID` INT PRIMARY KEY,
    `Gender` VARCHAR(50),
    `DateOfBirth` DATE,
    `Age` INT,
    `Phone Number` VARCHAR(50),
    `Address` VARCHAR(255),
    `Blood Type` VARCHAR(10),
    `Emergency Contact` VARCHAR(50),
    `Insurance Provider` VARCHAR(150),
    `State` VARCHAR(100),
    `City` VARCHAR(100),
    `Country` VARCHAR(100),
    `Policy Number` VARCHAR(100),
    `Medical History` TEXT,
    `Race` VARCHAR(100),
    `Ethnicity` VARCHAR(100),
    `Marital Status` VARCHAR(50),
    `First Name` VARCHAR(100),
    `LastName` VARCHAR(100),
    `Emergency Contact.1` VARCHAR(50),
    `Chronic Conditions` TEXT,
    `Allergies` VARCHAR(255),
    `Contact Number` VARCHAR(50)
);


CREATE TABLE Doctor (
    `Doctor ID` INT PRIMARY KEY,
    `Doctor Name` VARCHAR(150),
    `Specialty` VARCHAR(100),
    `Phone Number` VARCHAR(50),
    `Years Of Experience` INT,
    `Hospital Affiliation` VARCHAR(200),
    `Hospital/Clinic` VARCHAR(200),
    `Email` VARCHAR(150)
);


CREATE TABLE Visit (
    `Visit ID` INT PRIMARY KEY,
    `Patient ID` INT,
    `Doctor ID` INT,
    `Visit Date` DATE,
    `Diagnosis` VARCHAR(255),
    `Follow Up Required` VARCHAR(100),
    `Visit Type` VARCHAR(100),
    `Visit Status` VARCHAR(100),
    `Diagnosis Code` VARCHAR(100),
    `Reason for Visit` VARCHAR(255),
    `Prescribed Medications` VARCHAR(255),

    FOREIGN KEY (`Patient ID`) REFERENCES Patients(`Patient ID`)
        ON DELETE CASCADE,

    FOREIGN KEY (`Doctor ID`) REFERENCES Doctor(`Doctor ID`)
        ON DELETE CASCADE
);

CREATE TABLE Treatment (
    `Treatment ID` INT PRIMARY KEY,
    `Visit ID` INT,
    `Medication Prescribed` VARCHAR(255),
    `Dosage` VARCHAR(255),
    `Instructions` VARCHAR(500),
    `Treatment Cost` DECIMAL(10,2),
    `Treatment Type` VARCHAR(255),
    `Treatment Name` VARCHAR(255),
    `Status` VARCHAR(100),
    `Cost` DECIMAL(10,2),
    `Outcome` VARCHAR(255),
    `Treatment Description` TEXT,

    FOREIGN KEY (`Visit ID`) REFERENCES Visit(`Visit ID`)
        ON DELETE CASCADE
);

CREATE TABLE LabTest (
    `Lab Result ID` INT PRIMARY KEY,
    `Visit ID` INT,
    `Test Name` VARCHAR(255),
    `Test Date` DATE,
    `Units` VARCHAR(100),
    `Comments` VARCHAR(500),
    `Test Result` VARCHAR(255),
    `Reference Range` VARCHAR(255),

    FOREIGN KEY (`Visit ID`) REFERENCES Visit(`Visit ID`)
        ON DELETE CASCADE
);

-- 1. Patient Overview Summary

CREATE TABLE Summary_Patient_Overview AS
SELECT 
    COUNT(*) AS Total_Patients,
    COUNT(DISTINCT `State`) AS Total_States,
    COUNT(DISTINCT `City`) AS Total_Cities,
    COUNT(DISTINCT `Country`) AS Total_Countries,
    COUNT(CASE WHEN `Gender`='Male' THEN 1 END) AS Male_Count,
    COUNT(CASE WHEN `Gender`='Female' THEN 1 END) AS Female_Count,
    AVG(Age) AS Average_Age
FROM Patients;

select * from Summary_Patient_Overview;

-- 2. Visit Summary (Per Diagnosis, Type, Status)

CREATE TABLE Summary_Visit_Analysis AS
SELECT 
    `Diagnosis`,
    `Visit Type`,
    `Visit Status`,
    COUNT(*) AS Total_Visits
FROM Visit
GROUP BY `Diagnosis`, `Visit Type`, `Visit Status`;

select * from Summary_Visit_Analysis;

-- 3. Doctor Performance Summary

CREATE TABLE Summary_Doctor_Performance AS
SELECT 
    d.`Doctor ID`,
    d.`Doctor Name`,
    d.`Specialty`,
    COUNT(v.`Visit ID`) AS Total_Visits,
    COUNT(DISTINCT v.`Patient ID`) AS Unique_Patients
FROM Doctor d
LEFT JOIN Visit v ON d.`Doctor ID` = v.`Doctor ID`
GROUP BY d.`Doctor ID`, d.`Doctor Name`, d.`Specialty`;

select * from Summary_Doctor_Performance;

-- 4. Treatment Effectiveness Summary

CREATE TABLE Summary_Treatment_Effectiveness AS
SELECT
    `Treatment Type`,
    `Treatment Name`,
    COUNT(*) AS Total_Treatments,
    COUNT(CASE WHEN `Outcome` = 'Success' THEN 1 END) AS Successful_Treatments,
    COUNT(CASE WHEN `Outcome` = 'Failure' THEN 1 END) AS Failed_Treatments,
    AVG(`Treatment Cost`) AS Avg_Treatment_Cost
FROM Treatment
GROUP BY `Treatment Type`, `Treatment Name`;

select * from Summary_Treatment_Effectiveness;

-- 5. Combined Patient Visit Summary Table

CREATE TABLE Summary_Patient_Visit_Details AS
SELECT 
    CONCAT(p.`First Name`, ' ', p.`LastName`) AS Patient_Name,
    p.`Gender`,
    p.`Age`,
    v.`Visit Date`,
    v.`Diagnosis`,
    v.`Visit Type`,
    v.`Visit Status`,
    t.`Treatment Name`,
    t.`Medication Prescribed`,
    lt.`Test Name`,
    lt.`Test Result`
FROM Patients p
LEFT JOIN Visit v ON p.`Patient ID` = v.`Patient ID`
LEFT JOIN Treatment t ON v.`Visit ID` = t.`Visit ID`
LEFT JOIN LabTest lt ON v.`Visit ID` = lt.`Visit ID`;

select * from Summary_Patient_Visit_Details;
