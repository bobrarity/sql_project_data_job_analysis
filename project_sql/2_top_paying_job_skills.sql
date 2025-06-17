/*
Question: What skills are required for the top-paying data analyst jobs?
- Use the top 10 highest-paying Data Analyst jobs from first query
- Add the specific skills required for these roles
- Why? It provides a detailed look at which high-paying jobs demand certain skills, 
    helping job seekers understand which skills to develop that align with top salaries
*/

WITH top_paying_jobs AS (
    SELECT
        job_id,
        job_title,
        salary_year_avg,
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
    LIMIT 10
)

SELECT
    top_paying_jobs.*,
    skills.skills
FROM
     top_paying_jobs
INNER JOIN skills_job_dim AS skill_to_job
    ON top_paying_jobs.job_id = skill_to_job.job_id
INNER JOIN skills_dim AS skills
    ON skill_to_job.skill_id = skills.skill_id
ORDER BY 
    salary_year_avg DESC

/*
Top In-Demand Skills
1. SQL is the most required skill, appearing in more than 1 out of every 4 top-paying job listings.
2. Python follows closely, signaling its strong relevance in data-intensive roles.
3. Tableau highlights the importance of data visualization skills.
4. Tools like Snowflake, Pandas, and Excel indicate that top-paying positions still rely on practical data wrangling and analysis tools.
5. Go and NumPy suggest demand for backend performance and numerical computing in specific roles.

Skill Trends:
- The top-paying roles value a blend of data engineering (SQL, Snowflake), analysis (Excel, Tableau, Pandas), and programming (Python, R, Go).
- Familiarity with version control and DevOps tools (e.g., GitLab) also appears in multiple listings, hinting at production-level responsibilities.
*/