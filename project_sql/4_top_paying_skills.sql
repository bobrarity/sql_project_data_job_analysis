/*
Answer: What are the top skills based on salary?
- Look at the average salary associated with each skill for Data Analyst positions
- Focuses on roles with specified salaries, regardless of location
- Why? It reveals how different skills impact salary levels for Data Analysts and 
    helps identify the most financially rewarding skills to acquire or improve
*/

SELECT
    s.skills AS skill,
    ROUND(AVG(jp.salary_year_avg), 2) AS avg_salary
FROM job_postings_fact as jp
INNER JOIN skills_job_dim AS stj
    ON jp.job_id = stj.job_id
INNER JOIN skills_dim AS s
    ON stj.skill_id = s.skill_id
WHERE
    jp.job_title_short = 'Data Analyst'
    AND
    jp.salary_year_avg IS NOT NULL
GROUP BY
    s.skills
ORDER BY
    avg_salary DESC
LIMIT 10

/*
- 🔧 Specialized skills pay more — niche tools like SVN, Solidity, and Couchbase command top salaries.
- 💸 Blockchain, DevOps, and ML automation are especially lucrative fields.
- 🧠 Roles requiring deep technical expertise (e.g. Golang, MXNet) offer premium compensation.
- 📉 Common tools (like SQL, Python) are in high demand, but rare skills often bring higher pay.
- 🎯 Focusing on emerging or underused technologies can be a smart career move.
*/
