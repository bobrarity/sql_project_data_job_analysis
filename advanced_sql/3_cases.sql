SELECT
    COUNT(job_id) AS number_of_jobs,
    CASE
        WHEN job_location = 'Anywhere' THEN 'Remote'
        WHEN job_location = 'New York, NY' THEN 'Local'
        ELSE 'Onsite'
    END AS location_category
FROM
    job_postings_fact
WHERE
    job_title_short = 'Data Analyst'
GROUP BY
    location_category
LIMIT 30;

------ Problem

SELECT
    job_via,
    salary_year_avg,
    CASE
        WHEN salary_year_avg < 120000  THEN 'Low'
        WHEN salary_year_avg BETWEEN 120000 AND 240000 THEN 'Standard'
        WHEN salary_year_avg > 240000 THEN 'High'
        ELSE 'None'
    END AS salary_type
FROM
    job_postings_fact
WHERE
    salary_year_avg IS NOT NULL AND job_title_short = 'Data Analyst'
ORDER BY
    salary_year_avg DESC
LIMIT 1000;