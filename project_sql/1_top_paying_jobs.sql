/*
Question: What are the top-paying data analyst jobs?
- Identify the top 10 highest-paying Data Analyst roles that are available remotely
- Focuses on job postings with specified salaries (remove nulls)
- BONUS: Include company names of top 10 roles
- Why? Highlight the top-paying opportunities for Data Analysts, offering insights into employment options and location flexibility.
*/

SELECT
    job_id,
    job_title,
    job_location,
    job_schedule_type,
    salary_year_avg,
    job_posted_date,
    name AS company_name
FROM
    job_postings_fact
LEFT JOIN company_dim
    ON job_postings_fact.company_id = company_dim.company_id
WHERE
    job_title_short = 'Data Analyst'
    AND
    salary_year_avg IS NOT NULL
    AND
    job_location = 'Anywhere'
ORDER BY 
    salary_year_avg DESC
LIMIT 10;

/*
Here's the breakdown of the top data analyst jobs in 2023:
- Salary Range: The top 10 roles offer between $184K and $650K, showing strong earning potential.
- Employers: High-paying jobs come from companies like SmartAsset, Meta, and AT&T—spanning multiple industries.
- Job Title Variety: Roles range from Data Analyst to Director of Analytics, highlighting the range of specializations in the field.
*/