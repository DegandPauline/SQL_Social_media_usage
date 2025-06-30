/*
🟢 Beginner Level

1. List all students who sleep less than 6 hours per night.

2. Find the 5 students with the highest social media addiction scores.

3. Count how many students use each social media platform.

4. Show students whose academic performance is affected and whose mental health score is below 5.

*/;

1.
SELECT
    student_id,
    sleep_hours_per_night
FROM socialmediausage
WHERE 
    sleep_hours_per_night < 6
ORDER BY 
    sleep_hours_per_night
-- There are 167 student in our sample tha sleep less than 6h
;

2.
SELECT
    student_id,
    addicted_score,
    most_used_platform
FROM socialmediausage
ORDER BY 
    addicted_score DESC
LIMIT 5
-- Instagram is the most represented app in this top
;

3.
SELECT
    most_used_platform,
    count(*) AS number,
    ROUND(COUNT(*) * 100.0 / SUM(COUNT(*)) OVER (), 1) AS percentage
FROM socialmediausage
GROUP BY 
    most_used_platform
ORDER BY 
    number DESC
--Instagram is by far the most popular social media
;

4.
SELECT  
    student_id,
    most_used_platform,
    Mental_Health_Score
FROM socialmediausage
WHERE
    affects_academic_performance = 'Yes' AND 
    mental_health_score < 5
-- There are 29 student in our sample whose academic performance are affected and with bad mental health score
;