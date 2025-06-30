-- Average mental health score among male and female
SELECT
    TO_CHAR(AVG (Mental_Health_Score), 'FM999990.00') as mental_health,
    gender
FROM socialmediausage
GROUP BY
    gender;

-- Average mental health score of student based on their favorite platform ?
SELECT
    TO_CHAR(AVG (Mental_Health_Score), 'FM999990.00') as mental_health,
    most_used_platform
FROM socialmediausage
GROUP BY
    most_used_platform
ORDER BY
    mental_health;

-- Average mental health score based on the country
SELECT
    TO_CHAR(AVG (Mental_Health_Score), 'FM999990.00') as mental_health,
    country
FROM socialmediausage
GROUP BY
    country
ORDER BY
    mental_health;

-- Average mental health score among group age
SELECT
  CASE 
    WHEN Age BETWEEN 18 AND 20 THEN '18-20'
    WHEN Age BETWEEN 21 AND 24 THEN '21-24'
  END AS Age_Group,
  TO_CHAR(AVG (Mental_Health_Score), 'FM999990.00') as mental_health
FROM SocialMediaUsage
GROUP BY
    Age_Group;
