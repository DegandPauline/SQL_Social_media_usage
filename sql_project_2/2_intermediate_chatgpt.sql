/*
🟡 Intermediate Level

1. Calculate the average mental health score per country.

2. Find the average daily usage time per gender.

3. Rank platforms by average daily usage hours.

4. Compare the average addiction score between students in a relationship vs. single.

5. List the top 3 countries with the lowest average mental health scores.
*/;

1.
SELECT
    TO_CHAR(AVG (Mental_Health_Score), 'FM999990.00') as mental_health,
    Country
FROM socialmediausage
GROUP BY
    country
ORDER BY
    AVG (Mental_Health_Score) DESC
-- There doesn't seem to be a corralation between different continent
;

2.
SELECT 
    gender,
    TO_CHAR(AVG (Avg_Daily_Usage_Hours), 'FM999990.00') AS daily_hours,
    TO_CHAR(
        INTERVAL '1 hour' * FLOOR(AVG(Avg_Daily_Usage_Hours)) +
        INTERVAL '1 minute' * ROUND((AVG(Avg_Daily_Usage_Hours) - FLOOR(AVG(Avg_Daily_Usage_Hours))) * 60),
        'HH24:MI'
    ) AS daily_hours_formatted
FROM socialmediausage
GROUP BY 
    gender
-- Female use social media a bit more but only 10 minutes
;

3.
SELECT
    RANK () OVER (ORDER BY AVG(Avg_Daily_Usage_Hours) DESC) AS Rank,
    most_used_platform,
    TO_CHAR(AVG (Avg_Daily_Usage_Hours), 'FM999990.00') AS daily_hours,    
    TO_CHAR(
        INTERVAL '1 hour' * FLOOR(AVG(Avg_Daily_Usage_Hours)) +
        INTERVAL '1 minute' * ROUND((AVG(Avg_Daily_Usage_Hours) - FLOOR(AVG(Avg_Daily_Usage_Hours))) * 60),
        'HH24:MI'
    ) AS daily_hours_formatted
FROM socialmediausage
GROUP BY
    most_used_platform
-- WhatsApp is the most used platform
;

4.
SELECT
    relationship_status,
    TO_CHAR(AVG (addicted_score), 'FM999990.00') AS addiction,
    count(*) AS total_student
FROM socialmediausage
WHERE
    relationship_status IN ('In Relationship', 'Single')
GROUP BY
    relationship_status
-- The level of addiction doesn't seem to be influenced by the relationship status
;

5.
SELECT
    Country,
    TO_CHAR(AVG (mental_health_score), 'FM999990.00') AS mental_health
FROM socialmediausage
GROUP BY 
    country
ORDER BY 
    AVG (mental_health_score)
LIMIT 3
-- Czech Republic has the lowest result
;