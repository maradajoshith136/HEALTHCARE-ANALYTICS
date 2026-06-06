create database Axon_Healthcare;
use Axon_Healthcare;

select*from patient_2;
select*from doctor_2;
select*from treatment_2;
select*from visit_2;
select*from lab_test_2;


##### KPI ####

## 1. Data Count Validation

-- Ensure record counts match between the database and Power BI reports.
SELECT COUNT(*) FROM patient_2;
SELECT COUNT(*) FROM visit_2;
SELECT COUNT(*) FROM treatment_2;
SELECT COUNT(*) FROM lab_test_2;


## 2. Data Completeness Check

-- Identify missing or null values in key columns.
SELECT * FROM patient_2 WHERE "First Name" IS NULL OR "Last Name" IS NULL;
SELECT * FROM visit_2 WHERE "Visit Type" IS NULL OR "Visit Date" IS NULL;
SELECT * FROM treatment_2 WHERE "Treatment_Name" IS NULL OR "Status" IS NULL;
SELECT * FROM lab_test_2 WHERE "TestName" IS NULL OR "Result" IS NULL;


## 3. Data Consistency Check

-- Ensure data relationships are consistent across tables
SELECT v.visit_ID, v.patient_ID, p.patient_ID
FROM visit_2 v
LEFT JOIN patient_2 p ON v.patient_ID = p.patient_ID
WHERE p.patient_ID IS NULL;  -- Should return 0 rows

SELECT t.treatment_ID, t.visit_ID, v.visit_ID
FROM treatment_2 t
LEFT JOIN visit_2 v ON t.visit_ID = v.visit_ID
WHERE v.visit_ID IS NULL;  -- Should return 0 rows


## 4. Duplicate Records Check

-- Identify duplicate entries in key tables.
SELECT patient_ID, COUNT(*)
FROM patient_2
GROUP BY patient_ID
HAVING COUNT(*) > 1;



SELECT visit_ID, COUNT(*)
FROM visit_2
GROUP BY visit_ID
HAVING COUNT(*) > 1;


## 5. Dashboard Aggregation Check

-- Compare sum or average values between SQL and Power BI.
SELECT SUM(treatment_Cost) FROM treatment_2;  -- Compare with Power BI total cost

SELECT AVG(age) FROM patient_2;  -- Compare with Power BI average age


## 6. Performance Testing (Query Execution Time)

-- Check query performance and optimize if needed.
SELECT * FROM visit_2 WHERE visit_Date BETWEEN '2023-01-01' AND '2023-12-31';


## 7.Average age of patient 
SELECT floor((AVG(age))) AS average_age FROM patient_2;



## 8. Top 5 Diagnosis condition

SELECT diagnosis, COUNT(*) AS total_cases
FROM visit_2
GROUP BY diagnosis
ORDER BY total_cases DESC
LIMIT 5;


## 10. Top 5 most expensive treatment

SELECT treatment_type, count(treatment_type) as total_number_of_treatment, avg(treatment_cost) AS Average_total_treatment_cost
FROM treatment_2
GROUP BY treatment_type
ORDER BY treatment_type DESC
LIMIT 5;


## 11. Average treatment cost 

SELECT AVG(treatment_Cost) AS average_treatment_cost FROM treatment_2;


## 12. Average treatment cost by type

SELECT visit_id,
AVG(treatment_cost) AS avg_treatment_cost
FROM treatment_2
GROUP BY visit_id;


## 13. Total count of test as per the Lab Results

SELECT lr.test_name,
(COUNT(CASE WHEN lr.test_Result = 'abnormal' THEN 1 END)) AS Abnormal_cases,
(COUNT(CASE WHEN lr.test_Result = 'normal' THEN 1 END)) AS normal_cases,
(COUNT(CASE WHEN lr.test_Result = 'Pending' THEN 1 END)) AS Pending_cases
FROM lab_test_2 lr
JOIN visit_2 p ON lr.visit_ID = p.visit_ID
GROUP BY lr.test_name
ORDER BY Abnormal_cases, normal_cases, Pending_cases DESC;



## 14 Total count of patient as per the blood group, chronic condition and allergies 

SELECT chronic_Conditions,
       allergies,
       SUM(CASE WHEN blood_Type = 'A+' THEN 1 ELSE 0 END) AS A_Positive,
       SUM(CASE WHEN blood_Type = 'A-' THEN 1 ELSE 0 END) AS A_Negative,
       SUM(CASE WHEN blood_Type = 'B+' THEN 1 ELSE 0 END) AS B_Positive,
       SUM(CASE WHEN blood_Type = 'B-' THEN 1 ELSE 0 END) AS B_Negative,
       SUM(CASE WHEN blood_Type = 'AB+' THEN 1 ELSE 0 END) AS AB_Positive,
       SUM(CASE WHEN blood_Type = 'AB-' THEN 1 ELSE 0 END) AS AB_Negative,
       SUM(CASE WHEN blood_Type = 'O+' THEN 1 ELSE 0 END) AS O_Positive,
       SUM(CASE WHEN blood_Type = 'O-' THEN 1 ELSE 0 END) AS O_Negative
FROM patient_2
GROUP BY chronic_Conditions, allergies;


## 15. Total count of pateint table with respect to their race, Ethnicity and age group 


SELECT race,
       ethnicity,
       SUM(CASE WHEN age BETWEEN 0 AND 18 THEN 1 ELSE 0 END) AS Age_0_18,
       SUM(CASE WHEN age BETWEEN 19 AND 35 THEN 1 ELSE 0 END) AS Age_19_35,
       SUM(CASE WHEN age BETWEEN 36 AND 60 THEN 1 ELSE 0 END) AS Age_36_60,
       SUM(CASE WHEN age >= 61 THEN 1 ELSE 0 END) AS Age_61_plus
FROM patient_2
GROUP BY race, ethnicity
ORDER BY race, ethnicity;


## 16. Names of top 5 doctor from each department with their years of experience 


WITH ranked_doctors AS (
    SELECT doctor_ID,
           doctor_name,
           specialty,
           years_of_experience,
           ROW_NUMBER() OVER (PARTITION BY specialty ORDER BY years_of_experience DESC) AS rank_in_dept
    FROM doctor_2
)
SELECT doctor_ID, doctor_name, specialty, years_of_experience
FROM ranked_doctors
WHERE rank_in_dept <= 5
ORDER BY specialty, rank_in_dept;


## 17. Count of all doctor in each department with regards to their years of experience 


WITH exp_groups AS (
    SELECT specialty,
           CASE 
           WHEN years_of_experience BETWEEN 0 AND 5 THEN 'Junior'
           WHEN years_of_experience BETWEEN 6 AND 10 THEN 'Mid-level'
           WHEN years_of_experience BETWEEN 11 AND 20 THEN 'Senior'
           ELSE 'Departmental_Specialist'
       END AS experience_group
    FROM doctor_2
)
SELECT experience_group,
       SUM(CASE WHEN specialty = 'Cardiology' THEN 1 ELSE 0 END) AS Cardiology,
       SUM(CASE WHEN specialty = 'Neurology' THEN 1 ELSE 0 END) AS Neurology,
       SUM(CASE WHEN specialty = 'General Medicine' THEN 1 ELSE 0 END) AS General_Medicine,
       SUM(CASE WHEN specialty = 'Neurology' THEN 1 ELSE 0 END) AS Orthopedics,
       SUM(CASE WHEN specialty = 'Pediatrics' THEN 1 ELSE 0 END) AS Pediatrics
FROM exp_groups
GROUP BY experience_group
ORDER BY experience_group;


## 18. Total follow-up rate patient as per city and state


SELECT p.state,
       p.city,
       SUM(CASE WHEN f.follow_up_required = 'Yes' THEN 1 ELSE 0 END) AS Yes_Count,
       SUM(CASE WHEN f.follow_up_required = 'No' THEN 1 ELSE 0 END) AS No_Count
FROM patient_2 p
JOIN visit_2 f ON p.patient_id = f.patient_id
GROUP BY p.state, p.city
ORDER BY p.state, p.city;


## 19. Count of Patient by Dosage, Instruction and Medication Prescribed


SELECT medication_Prescribed,
       instructions,
       SUM(CASE WHEN dosage = '10mg' THEN 1 ELSE 0 END) AS Dosage_10mg,
       SUM(CASE WHEN dosage = '50mg' THEN 1 ELSE 0 END) AS Dosage_50mg,
       SUM(CASE WHEN dosage = '20mg' THEN 1 ELSE 0 END) AS Dosage_20mg,
       SUM(CASE WHEN dosage = '5mg' THEN 1 ELSE 0 END) AS Dosage_5mg
FROM treatment_2
GROUP BY medication_Prescribed, instructions
ORDER BY medication_Prescribed, instructions;


## 20 Average cost of each treatment as per their outcome


SELECT treatment_Type,
       COALESCE(ROUND(AVG(CASE WHEN outcome = 'Successful' THEN cost END),0), 'NA') AS Successfull_cases,
       COALESCE(ROUND(AVG(CASE WHEN outcome = 'Ongoing' THEN cost END),0), 'NA') AS In_progress_cases,
	   COALESCE(ROUND(AVG(CASE WHEN outcome = 'Failed' THEN cost END),0), 'NA') AS Un_Successfull_cases
FROM treatment_2
GROUP BY treatment_Type
ORDER BY treatment_Type;


## 21 Treatment name and description as per their status 


SELECT treatment_Description,
       COALESCE(count(CASE WHEN treatment_Name = 'Antibiotic' THEN status END), 'NA') AS Chemotherapy,
       COALESCE(count(CASE WHEN treatment_Name = 'Ibuprofen' THEN status END), 'NA') AS Ibuprofen,
       COALESCE(count(CASE WHEN treatment_Name = 'Metformin' THEN status END), 'NA') AS Metformin,
       COALESCE(count(CASE WHEN treatment_Name = 'Metformin' THEN status END), 'NA') AS Metformin,
       COALESCE(count(CASE WHEN treatment_Name = 'Physical Therapy' THEN status END), 'NA') AS Physical_Therapy
FROM treatment_2
GROUP BY status, treatment_Description
ORDER BY status, treatment_Description ;