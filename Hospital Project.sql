CREATE TABLE Hospital_Data (
    Hospital_Name VARCHAR(100),
    Location VARCHAR(100),
    Department VARCHAR(100),
    Doctors_Count INT,
    Patients_Count INT,
    Admission_Date DATE,
	Discharge_Date DATE,
    Medical_Expenses NUMERIC(10, 2)
);

SELECT * FROM Hospital_Data

-- Import Data into Hospital Table
SET datestyle = 'DMY';
COPY  Hospital_Data(Hospital_Name, Location, Department, Doctors_Count, Patients_Count,Admission_Date,Discharge_Date, Medical_Expenses ) 
FROM 'C:/Swati C/SQL/CSV/Hospital_Data.csv'  DELIMITER ',' 
CSV HEADER;

--1. Total Number of Patients
--Write an SQL query to find the total number of patients across all hospitals.
SELECT SUM(patients_count) AS total_patients
FROM Hospital_Data

--2. Average Number of Doctors per Hospital
-- Retrieve the average count of doctors available in each hospital. 
SELECT hospital_name, AVG(doctors_count) AS avg_doctors
FROM hospital_data
GROUP BY hospital_name

--3. Top 3 Departments with the Highest Number of Patients
-- Find the top 3 hospital departments that have the highest number of patients. 
SELECT department, SUM(patients_count) AS total_patients
FROM Hospital_Data
GROUP BY  department
ORDER BY total_patients DESC LIMIT 3

--4. Hospital with the Maximum Medical Expenses 
-- Identify the hospital that recorded the highest medical expenses. 
SELECT hospital_name, SUM(medical_expenses) AS total_medi_expenses
FROM Hospital_Data
GROUP BY hospital_name
ORDER BY hospital_name DESC LIMIT 1

--5. Daily Average Medical Expenses
-- Calculate the average medical expenses per day for each hospital. 
SELECT hospital_name, AVG(medical_expenses/ 
						  NULLIF ((discharge_date - admission_date),0)) AS avg_daily_expenses
FROM Hospital_Data
GROUP BY Hospital_name

--6. Longest Hospital Stay
-- Find the patient with the longest stay by calculating the difference between 
SELECT hospital_name, department, (discharge_date - admission_date) AS stay_duration
FROM hospital_data
ORDER BY stay_duration DESC

--7. Total Patients Treated Per City
-- Count the total number of patients treated in each city. 
SELECT location AS city, SUM(patients_count) AS total_patients_treated
FROM hospital_data
GROUP BY location
ORDER BY total_patients_treated DESC

--8. Average Length of Stay Per Department
-- Calculate the average number of days patients spend in each department.
SELECT department, AVG(discharge_date - admission_date) AS avg_stay_days
FROM Hospital_Data
GROUP BY department

--9.Identify the Department with the Lowest Number of Patients
-- Find the department with the least number of patients. 
SELECT department, SUM(patients_count) AS total_count
FROM hospital_data
GROUP BY department 
ORDER BY total_count LIMIT 3

--10. Monthly Medical Expenses Report 
-- Group the data by month and calculate the total medical expenses for each month.
SELECT TO_CHAR(admission_date, 'YYYY-MM') AS month,
SUM(medical_expenses) AS total_expenses
FROM Hospital_Data
GROUP BY month
ORDER BY month






