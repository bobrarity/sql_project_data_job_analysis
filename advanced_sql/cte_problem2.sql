WITH first_quarter AS (
    SELECT *
    FROM january_jobs

    UNION ALL

    SELECT *
    FROM february_jobs

    UNION ALL

    SELECT *
    FROM march_jobs
    )

SELECT
    job_location,
    job_via,
    job_posted_date::DATE,
    salary_year_avg
FROM first_quarter
WHERE
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg > 70000
ORDER BY
    salary_year_avg DESC;