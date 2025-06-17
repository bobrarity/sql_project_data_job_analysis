/*
Answer: What are the most optimal skills to learn (aka it’s in high demand and a high-paying skill)?
- Identify skills in high demand and associated with high average salaries for Data Analyst roles
- Concentrates on remote positions with specified salaries
- Why? Targets skills that offer job security (high demand) and financial benefits (high salaries), 
    offering strategic insights for career development in data analysis
*/

WITH skills_demand AS (
    SELECT
        s.skill_id,
        s.skills AS skill,
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
        jp.salary_year_avg IS NOT NULL
        AND
        jp.job_work_from_home IS TRUE
    GROUP BY
        s.skill_id
), average_salary AS (    
    SELECT
        s.skill_id,
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
        AND
        jp.job_work_from_home IS TRUE
    GROUP BY
        s.skill_id
), by_skill_count_first AS (
    SELECT
        sd.skill_id,
        sd.skill,
        sd.skill_count,
        ast.avg_salary
    FROM
        skills_demand AS sd
    INNER JOIN average_salary AS ast
        ON sd.skill_id = ast.skill_id
    ORDER BY
        skill_count DESC, 
        avg_salary DESC
    LIMIT 25
), by_avg_salary_first AS (
    SELECT
        sd.skill_id,
        sd.skill,
        sd.skill_count,
        ast.avg_salary
    FROM
        skills_demand AS sd
    INNER JOIN average_salary AS ast
        ON sd.skill_id = ast.skill_id
    WHERE
        skill_count > 10
    ORDER BY
        avg_salary DESC,
        skill_count DESC
    LIMIT 25
), combined_skills AS ( -- both CTEs inner joined by skill_id
    SELECT
        sd.skill_id,
        sd.skill,
        sd.skill_count,
        ast.avg_salary
    FROM
        skills_demand AS sd
    INNER JOIN average_salary AS ast
        ON sd.skill_id = ast.skill_id
    WHERE
        sd.skill_count > 10  -- More common skills
    ORDER BY
        sd.skill_count DESC, 
        ast.avg_salary DESC
    LIMIT 25
)

/*
SELECT
    *
FROM
    --combined_skills
    --by_skill_count_first
    by_avg_salary_first
*/

-- Concise query
SELECT
    s.skill_id,
    s.skills AS skill,
    COUNT(stj.job_id) AS skill_count,
    ROUND(AVG(jp.salary_year_avg), 2) AS avg_salary
FROM
    job_postings_fact AS jp
INNER JOIN skills_job_dim AS stj
    ON jp.job_id = stj.job_id
INNER JOIN skills_dim AS s
    ON stj.skill_id = s.skill_id
WHERE
    jp.job_title_short = 'Data Analyst'
    AND
    jp.salary_year_avg IS NOT NULL
    AND
    jp.job_work_from_home IS TRUE
GROUP BY
    s.skill_id
HAVING
    COUNT(stj.job_id) > 10
ORDER BY
    avg_salary DESC,
    skill_count DESC