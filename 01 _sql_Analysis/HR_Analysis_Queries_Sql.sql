create database hrproject;
use hrproject;
select * from hr_data;
-- EMPLOYEE COUNT
SELECT SUM(employee_count) AS Employee_Count
FROM hr_data;
-- ATTRITION COUNT
SELECT COUNT(attrition) AS Attrition_Count
FROM hr_data
WHERE attrition = 'Yes';
-- ATTRITION RATE
SELECT 
ROUND(
    (
        CAST(
            (SELECT COUNT(attrition) 
             FROM hr_data 
             WHERE attrition = 'Yes') AS FLOAT
        ) 
        / SUM(employee_count)
    ) * 100, 2
) AS Attrition_Rate
FROM hr_data;
-- AVERAGE AGE
SELECT ROUND(AVG(age), 0) AS Average_Age
FROM hr_data;
-- ACTIVE EMPLOYEES
SELECT 
SUM(employee_count) - 
(
    SELECT COUNT(attrition)
    FROM hr_data
    WHERE attrition = 'Yes'
) AS Active_Employee
FROM hr_data;
-- ATTRITION BY GENDER
SELECT 
    gender,
    COUNT(attrition) AS attrition_count
FROM hr_data
WHERE attrition = 'Yes'
GROUP BY gender
ORDER BY COUNT(attrition) DESC;
-- DEPARTMENT WISE ATTRITION
SELECT 
    department,
    COUNT(attrition) AS attrition_count,
    ROUND(
        (
            CAST(COUNT(attrition) AS FLOAT) /
            (
                SELECT COUNT(attrition)
                FROM hr_data
                WHERE attrition = 'Yes'
            )
        ) * 100, 2
    ) AS pct
FROM hr_data
WHERE attrition = 'Yes'
GROUP BY department
ORDER BY COUNT(attrition) DESC;
-- NUMBER OF EMPLOYEES BY AGE GROUP 
SELECT 
    age,
    SUM(employee_count) AS employee_count
FROM hr_data
GROUP BY age
ORDER BY age;
-- EDUCATION FIELD WISE ATTRITION 
SELECT 
    education_field,
    COUNT(attrition) AS attrition_count
FROM hr_data
WHERE attrition = 'Yes'
GROUP BY education_field
ORDER BY COUNT(attrition) DESC;
-- ATTRITION RATE BY GENDER FOR DIFFERENT AGE GROUP 
SELECT 
    age_band,
    gender,
    COUNT(attrition) AS attrition,
    ROUND(
        (
            CAST(COUNT(attrition) AS FLOAT) /
            (
                SELECT COUNT(attrition)
                FROM hr_data
                WHERE attrition = 'Yes'
            )
        ) * 100, 2
    ) AS pct
FROM hr_data
WHERE attrition = 'Yes'
GROUP BY age_band, gender
ORDER BY age_band, gender DESC;
-- JOB SATISFACTION RATING 
SELECT 
    job_role,
    SUM(CASE WHEN job_satisfaction = 1 THEN employee_count ELSE 0 END) AS `1`,
    SUM(CASE WHEN job_satisfaction = 2 THEN employee_count ELSE 0 END) AS `2`,
    SUM(CASE WHEN job_satisfaction = 3 THEN employee_count ELSE 0 END) AS `3`,
    SUM(CASE WHEN job_satisfaction = 4 THEN employee_count ELSE 0 END) AS `4`
FROM hr_data
GROUP BY job_role
ORDER BY job_role;