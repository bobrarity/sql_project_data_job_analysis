SELECT
    EXTRACT(MONTH FROM job_posted_date) AS month,
    COUNT(job_id) AS job_count
FROM
    job_postings_fact
WHERE job_title_short = 'Data Analyst'
GROUP BY
    month
ORDER BY
    job_count DESC;  


CREATE TABLE january_jobs AS
    SELECT * FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 1;

CREATE TABLE february_jobs AS
    SELECT * FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 2;

CREATE TABLE march_jobs AS
    SELECT * FROM job_postings_fact
    WHERE EXTRACT(MONTH FROM job_posted_date) = 3;

SELECT * FROM january_jobs
LIMIT 20;