/*
🔵 Advanced Level

1. Group students by age ranges (e.g., 18–20, 21–24) and compute the average mental health score per group.

2. Create a custom risk score: Addiction + Conflicts – Sleep Hours, and show the top 10 highest-risk students.

3. Rank students based on their addiction score using a window function (RANK()).

4. Analyze whether higher daily usage correlates with lower mental health scores (e.g., grouped by usage brackets).

5. Calculate the percentage of students whose academic performance is affected, broken down by age group.

*/;

1.
SELECT
    CASE
        WHEN age BETWEEN 18 AND 20 THEN '18-20'
        WHEN age > 20 THEN '21-24'
    END AS group_age,
    TO_CHAR(AVG(mental_health_score), 'FM999990.00') AS mental_health
FROM socialmediausage
GROUP BY 
    group_age
-- The older student get, the best is their mental health
;

2.
SELECT
    RANK () OVER (ORDER BY (addicted_score + Conflicts_over_social_media - sleep_hours_per_night) DESC) AS rank,
    student_id,
    (addicted_score + Conflicts_over_social_media - sleep_hours_per_night) AS risk_score,
    mental_health_score,
    most_used_platform
FROM socialmediausage
ORDER BY
    rank
LIMIT 10
-- Instagram and TikTok are the most represented in this top
;

3.
SELECT
    RANK () OVER (ORDER BY addicted_score DESC) AS rank,
    student_id,
    addicted_score,
    most_used_platform
FROM socialmediausage
ORDER BY 
    rank
LIMIT 10
-- Instagram and TikTok are the most represented in this top
;

4.
/* SELECT
    min (Avg_Daily_Usage_Hours),
    max(Avg_Daily_Usage_Hours)
FROM socialmediausage

1.5 and 8.5 -> 1-4,4-6,+6
*/
;

SELECT
    CASE
        WHEN Avg_Daily_Usage_Hours BETWEEN 1 AND 4 THEN '1h to 4h'
        WHEN Avg_Daily_Usage_Hours > 4 AND Avg_Daily_Usage_Hours <= 6 THEN '4h to 6h'
        WHEN Avg_Daily_Usage_Hours > 6 THEN 'over 6h'
    END AS hours,
    count(*) AS total_student,
    TO_CHAR(AVG(mental_health_score), 'FM999990.00') AS mental_health
    
FROM socialmediausage
GROUP BY 
    hours
ORDER BY
    hours
-- The less time they spend on social media, the better is their mental health
;

5.
SELECT
    CASE
        WHEN age BETWEEN 18 AND 20 THEN '18-20'
        WHEN age > 20 THEN '21-24'
    END AS group_age,
    ROUND(
        count(*) FILTER (WHERE affects_academic_performance = 'Yes') * 100 / count(*), 1 
    )AS Yes_percentage,
    ROUND(
        count(*) FILTER (WHERE affects_academic_performance = 'No') * 100 / count(*), 1
    ) AS No_percentage,
    TO_CHAR(
        INTERVAL '1 hour' * FLOOR(AVG(Avg_Daily_Usage_Hours)) +
        INTERVAL '1 minute' * ROUND((AVG(Avg_Daily_Usage_Hours) - FLOOR(AVG(Avg_Daily_Usage_Hours))) * 60),
        'hh24:MI') AS daily_hours
FROM socialmediausage
GROUP BY 
    group_age
ORDER BY
    group_age
-- For both age group, students feel like their social media use has an impact on their academic performance
;


