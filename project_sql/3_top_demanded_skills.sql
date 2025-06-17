/*
Question: What are the most in-demand skills for data analysts?
- Join job postings to inner join table similar to query 2
- Identify the top 5 in-demand skills for a data analyst.
- Focus on all job postings.
- Why? Retrieves the top 5 skills with the highest demand in the job market, 
    providing insights into the most valuable skills for job seekers.
*/

SELECT
    s.skills,
    COUNT(stj.job_id) AS skill_count
FROM
    job_postings_fact AS jp
INNER JOIN skills_job_dim AS stj
    ON jp.job_id = stj.job_id
INNER JOIN skills_dim AS s
    ON stj.skill_id = s.skill_id
WHERE
    jp.job_title_short = 'Data Analyst'
    AND
    jp.job_work_from_home IS TRUE
GROUP BY
    s.skills
ORDER BY
    skill_count DESC
LIMIT 5