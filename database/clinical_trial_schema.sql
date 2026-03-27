-- Clinical Trial Management System (CTMS) Database Schema
-- Version: 1.1 (Optimized & Cleaned)

-- 1. Applicant Table
CREATE TABLE IF NOT EXISTS Applicant ( 
    Applicant_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Org_Name VARCHAR(100),
    Email VARCHAR(100), 
    Ph_no VARCHAR(20),
    Address TEXT, 
    Registration_Date DATE,
    Country VARCHAR(50)
);

-- 2. Clinical_Investigation Table
CREATE TABLE IF NOT EXISTS Clinical_Investigation ( 
    Study_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title VARCHAR(200), 
    Phase VARCHAR(10), 
    Status VARCHAR(50),
    Start_Date DATE, 
    End_Date DATE, 
    Applicant_ID INT,
    FOREIGN KEY (Applicant_ID) REFERENCES Applicant(Applicant_ID)
);

-- 3. Investigational_Site Table
CREATE TABLE IF NOT EXISTS Investigational_Site ( 
    Site_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Site_Name VARCHAR(100), 
    Country VARCHAR(50),
    City VARCHAR(50), 
    Study_ID INT,
    FOREIGN KEY (Study_ID) REFERENCES Clinical_Investigation(Study_ID)
);

-- 4. Subject Table
CREATE TABLE IF NOT EXISTS Subject ( 
    Subject_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Disease TEXT, 
    Study_ID INT,
    FOREIGN KEY (Study_ID) REFERENCES Clinical_Investigation(Study_ID)
);

-- Sample Data
-- Using OR IGNORE to prevent duplicate errors on sync
INSERT OR IGNORE INTO Applicant (Applicant_ID, Org_Name, Email, Ph_no, Address, Registration_Date, Country) 
VALUES (1, 'Sun Pharma', 'info@sunpharma.in', '919876543210', 'Mumbai', '2023-01-10', 'India');

INSERT OR IGNORE INTO Applicant (Applicant_ID, Org_Name, Email, Ph_no, Address, Registration_Date, Country) 
VALUES (2, 'Cipla Healthcare', 'contact@cipla.com', '919888777666', 'Pune', '2023-03-15', 'India');

INSERT OR IGNORE INTO Clinical_Investigation (Study_ID, Title, Phase, Status, Start_Date, End_Date, Applicant_ID) 
VALUES (101, 'Vaccine Efficacy Study', 'Phase III', 'Ongoing', '2024-01-01', '2025-01-01', 1);

INSERT OR IGNORE INTO Clinical_Investigation (Study_ID, Title, Phase, Status, Start_Date, End_Date, Applicant_ID) 
VALUES (102, 'Diabetes Drug Trial', 'Phase II', 'Pending', '2024-02-15', '2024-12-15', 2);

INSERT OR IGNORE INTO Investigational_Site (Site_ID, Site_Name, Country, City, Study_ID) 
VALUES (201, 'Apollo Hospital', 'India', 'Delhi', 101);

INSERT OR IGNORE INTO Investigational_Site (Site_ID, Site_Name, Country, City, Study_ID) 
VALUES (202, 'Lilavati Hospital', 'India', 'Mumbai', 102);

INSERT OR IGNORE INTO Subject (Subject_ID, Name, Gender, Disease, Study_ID) 
VALUES (501, 'Amitabh Bachchan', 'Male', 'None', 101);

INSERT OR IGNORE INTO Subject (Subject_ID, Name, Gender, Disease, Study_ID) 
VALUES (502, 'Deepika Padukone', 'Female', 'Diabetes', 102);

-- Auto-Persisted at Runtime
-- Clinical Trial Management System (CTMS) Database Schema
-- Version: 1.1 (Optimized & Cleaned)

-- 1. Applicant Table
CREATE TABLE IF NOT EXISTS Applicant ( 
    Applicant_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Org_Name VARCHAR(100),
    Email VARCHAR(100), 
    Ph_no VARCHAR(20),
    Address TEXT, 
    Registration_Date DATE,
    Country VARCHAR(50)
);

-- 2. Clinical_Investigation Table
CREATE TABLE IF NOT EXISTS Clinical_Investigation ( 
    Study_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title VARCHAR(200), 
    Phase VARCHAR(10), 
    Status VARCHAR(50),
    Start_Date DATE, 
    End_Date DATE, 
    Applicant_ID INT,
    FOREIGN KEY (Applicant_ID) REFERENCES Applicant(Applicant_ID)
);

-- 3. Investigational_Site Table
CREATE TABLE IF NOT EXISTS Investigational_Site ( 
    Site_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Site_Name VARCHAR(100), 
    Country VARCHAR(50),
    City VARCHAR(50), 
    Study_ID INT,
    FOREIGN KEY (Study_ID) REFERENCES Clinical_Investigation(Study_ID)
);

-- 4. Subject Table
CREATE TABLE IF NOT EXISTS Subject ( 
    Subject_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Disease TEXT, 
    Study_ID INT,
    FOREIGN KEY (Study_ID) REFERENCES Clinical_Investigation(Study_ID)
);

-- Sample Data
-- Using OR IGNORE to prevent duplicate errors on sync
INSERT OR IGNORE INTO Applicant (Applicant_ID, Org_Name, Email, Ph_no, Address, Registration_Date, Country) 
VALUES (1, 'Sun Pharma', 'info@sunpharma.in', '919876543210', 'Mumbai', '2023-01-10', 'India');

INSERT OR IGNORE INTO Applicant (Applicant_ID, Org_Name, Email, Ph_no, Address, Registration_Date, Country) 
VALUES (2, 'Cipla Healthcare', 'contact@cipla.com', '919888777666', 'Pune', '2023-03-15', 'India');

INSERT OR IGNORE INTO Clinical_Investigation (Study_ID, Title, Phase, Status, Start_Date, End_Date, Applicant_ID) 
VALUES (101, 'Vaccine Efficacy Study', 'Phase III', 'Ongoing', '2024-01-01', '2025-01-01', 1);

INSERT OR IGNORE INTO Clinical_Investigation (Study_ID, Title, Phase, Status, Start_Date, End_Date, Applicant_ID) 
VALUES (102, 'Diabetes Drug Trial', 'Phase II', 'Pending', '2024-02-15', '2024-12-15', 2);

INSERT OR IGNORE INTO Investigational_Site (Site_ID, Site_Name, Country, City, Study_ID) 
VALUES (201, 'Apollo Hospital', 'India', 'Delhi', 101);

INSERT OR IGNORE INTO Investigational_Site (Site_ID, Site_Name, Country, City, Study_ID) 
VALUES (202, 'Lilavati Hospital', 'India', 'Mumbai', 102);

INSERT OR IGNORE INTO Subject (Subject_ID, Name, Gender, Disease, Study_ID) 
VALUES (501, 'Amitabh Bachchan', 'Male', 'None', 101);

INSERT OR IGNORE INTO Subject (Subject_ID, Name, Gender, Disease, Study_ID) 
VALUES (502, 'Deepika Padukone', 'Female', 'Diabetes', 102);
;

-- Auto-Persisted at Runtime
-- Clinical Trial Management System (CTMS) Database Schema
-- Version: 1.1 (Optimized & Cleaned)

-- 1. Applicant Table
CREATE TABLE IF NOT EXISTS Applicant ( 
    Applicant_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Org_Name VARCHAR(100),
    Email VARCHAR(100), 
    Ph_no VARCHAR(20),
    Address TEXT, 
    Registration_Date DATE,
    Country VARCHAR(50)
);

-- 2. Clinical_Investigation Table
CREATE TABLE IF NOT EXISTS Clinical_Investigation ( 
    Study_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title VARCHAR(200), 
    Phase VARCHAR(10), 
    Status VARCHAR(50),
    Start_Date DATE, 
    End_Date DATE, 
    Applicant_ID INT,
    FOREIGN KEY (Applicant_ID) REFERENCES Applicant(Applicant_ID)
);

-- 3. Investigational_Site Table
CREATE TABLE IF NOT EXISTS Investigational_Site ( 
    Site_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Site_Name VARCHAR(100), 
    Country VARCHAR(50),
    City VARCHAR(50), 
    Study_ID INT,
    FOREIGN KEY (Study_ID) REFERENCES Clinical_Investigation(Study_ID)
);

-- 4. Subject Table
CREATE TABLE IF NOT EXISTS Subject ( 
    Subject_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Disease TEXT, 
    Study_ID INT,
    FOREIGN KEY (Study_ID) REFERENCES Clinical_Investigation(Study_ID)
);

-- Sample Data
-- Using OR IGNORE to prevent duplicate errors on sync
INSERT OR IGNORE INTO Applicant (Applicant_ID, Org_Name, Email, Ph_no, Address, Registration_Date, Country) 
VALUES (1, 'Sun Pharma', 'info@sunpharma.in', '919876543210', 'Mumbai', '2023-01-10', 'India');

INSERT OR IGNORE INTO Applicant (Applicant_ID, Org_Name, Email, Ph_no, Address, Registration_Date, Country) 
VALUES (2, 'Cipla Healthcare', 'contact@cipla.com', '919888777666', 'Pune', '2023-03-15', 'India');

INSERT OR IGNORE INTO Clinical_Investigation (Study_ID, Title, Phase, Status, Start_Date, End_Date, Applicant_ID) 
VALUES (101, 'Vaccine Efficacy Study', 'Phase III', 'Ongoing', '2024-01-01', '2025-01-01', 1);

INSERT OR IGNORE INTO Clinical_Investigation (Study_ID, Title, Phase, Status, Start_Date, End_Date, Applicant_ID) 
VALUES (102, 'Diabetes Drug Trial', 'Phase II', 'Pending', '2024-02-15', '2024-12-15', 2);

INSERT OR IGNORE INTO Investigational_Site (Site_ID, Site_Name, Country, City, Study_ID) 
VALUES (201, 'Apollo Hospital', 'India', 'Delhi', 101);

INSERT OR IGNORE INTO Investigational_Site (Site_ID, Site_Name, Country, City, Study_ID) 
VALUES (202, 'Lilavati Hospital', 'India', 'Mumbai', 102);

INSERT OR IGNORE INTO Subject (Subject_ID, Name, Gender, Disease, Study_ID) 
VALUES (501, 'Amitabh Bachchan', 'Male', 'None', 101);

INSERT OR IGNORE INTO Subject (Subject_ID, Name, Gender, Disease, Study_ID) 
VALUES (502, 'Deepika Padukone', 'Female', 'Diabetes', 102);

-- Auto-Persisted at Runtime
-- Clinical Trial Management System (CTMS) Database Schema
-- Version: 1.1 (Optimized & Cleaned)

-- 1. Applicant Table
CREATE TABLE IF NOT EXISTS Applicant ( 
    Applicant_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Org_Name VARCHAR(100),
    Email VARCHAR(100), 
    Ph_no VARCHAR(20),
    Address TEXT, 
    Registration_Date DATE,
    Country VARCHAR(50)
);

-- 2. Clinical_Investigation Table
CREATE TABLE IF NOT EXISTS Clinical_Investigation ( 
    Study_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Title VARCHAR(200), 
    Phase VARCHAR(10), 
    Status VARCHAR(50),
    Start_Date DATE, 
    End_Date DATE, 
    Applicant_ID INT,
    FOREIGN KEY (Applicant_ID) REFERENCES Applicant(Applicant_ID)
);

-- 3. Investigational_Site Table
CREATE TABLE IF NOT EXISTS Investigational_Site ( 
    Site_ID INTEGER PRIMARY KEY AUTOINCREMENT,
    Site_Name VARCHAR(100), 
    Country VARCHAR(50),
    City VARCHAR(50), 
    Study_ID INT,
    FOREIGN KEY (Study_ID) REFERENCES Clinical_Investigation(Study_ID)
);

-- 4. Subject Table
CREATE TABLE IF NOT EXISTS Subject ( 
    Subject_ID INTEGER PRIMARY KEY AUTOINCREMENT, 
    Name VARCHAR(100),
    Gender VARCHAR(10),
    Disease TEXT, 
    Study_ID INT,
    FOREIGN KEY (Study_ID) REFERENCES Clinical_Investigation(Study_ID)
);

-- Sample Data
-- Using OR IGNORE to prevent duplicate errors on sync
INSERT OR IGNORE INTO Applicant (Applicant_ID, Org_Name, Email, Ph_no, Address, Registration_Date, Country) 
VALUES (1, 'Sun Pharma', 'info@sunpharma.in', '919876543210', 'Mumbai', '2023-01-10', 'India');

INSERT OR IGNORE INTO Applicant (Applicant_ID, Org_Name, Email, Ph_no, Address, Registration_Date, Country) 
VALUES (2, 'Cipla Healthcare', 'contact@cipla.com', '919888777666', 'Pune', '2023-03-15', 'India');

INSERT OR IGNORE INTO Clinical_Investigation (Study_ID, Title, Phase, Status, Start_Date, End_Date, Applicant_ID) 
VALUES (101, 'Vaccine Efficacy Study', 'Phase III', 'Ongoing', '2024-01-01', '2025-01-01', 1);

INSERT OR IGNORE INTO Clinical_Investigation (Study_ID, Title, Phase, Status, Start_Date, End_Date, Applicant_ID) 
VALUES (102, 'Diabetes Drug Trial', 'Phase II', 'Pending', '2024-02-15', '2024-12-15', 2);

INSERT OR IGNORE INTO Investigational_Site (Site_ID, Site_Name, Country, City, Study_ID) 
VALUES (201, 'Apollo Hospital', 'India', 'Delhi', 101);

INSERT OR IGNORE INTO Investigational_Site (Site_ID, Site_Name, Country, City, Study_ID) 
VALUES (202, 'Lilavati Hospital', 'India', 'Mumbai', 102);

INSERT OR IGNORE INTO Subject (Subject_ID, Name, Gender, Disease, Study_ID) 
VALUES (501, 'Amitabh Bachchan', 'Male', 'None', 101);

INSERT OR IGNORE INTO Subject (Subject_ID, Name, Gender, Disease, Study_ID) 
VALUES (502, 'Deepika Padukone', 'Female', 'Diabetes', 102);
;
;

-- Auto-Persisted at Runtime
DELETE FROM Applicant WHERE Applicant_ID = '1';
