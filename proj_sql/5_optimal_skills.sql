WITH indemand_skills AS (
    SELECT
        skills_job_dim.skill_id,
        skills_dim.skills,
        COUNT(skills_job_dim.job_id) AS count
    FROM
        job_postings_fact
    INNER JOIN
        skills_job_dim
        ON job_postings_fact.job_id = skills_job_dim.job_id
    INNER JOIN
        skills_dim
        ON skills_job_dim.skill_id = skills_dim.skill_id
    WHERE
        job_postings_fact.salary_year_avg IS NOT NULL AND   
        job_postings_fact.job_title_short = 'Data Analyst'
    GROUP BY
        skills_job_dim.skill_id,
        skills_dim.skills
),

highpay AS (
    SELECT
        sj.skill_id,
        ROUND(AVG(j.salary_year_avg), 2) AS average_salary
    FROM
        job_postings_fact AS j
    INNER JOIN
        skills_job_dim AS sj
        ON j.job_id = sj.job_id
    INNER JOIN
        skills_dim AS s 
        ON sj.skill_id = s.skill_id
    WHERE
        j.job_title_short = 'Data Analyst' AND
        j.salary_year_avg IS NOT NULL
    GROUP BY
        sj.skill_id
    ORDER BY
        average_salary DESC
)

SELECT
    skills_demands.skill_id,   
    skills_demands.skills,
    skills_demands.count AS job_count,
    highpay.average_salary
FROM
    indemand_skills AS skills_demands
INNER JOIN
    highpay
    ON skills_demands.skill_id = highpay.skill_id
WHERE
    skills_demands.count >= 10
ORDER BY
    skills_demands.count DESC,
    highpay.average_salary DESC

-- ANOTHER QUERY

SELECT
    s.skills,
    COUNT(DISTINCT j.job_id) AS job_count,
    ROUND(AVG(j.salary_year_avg), 2) AS average_salary
FROM
    job_postings_fact AS j
INNER JOIN
    skills_job_dim AS sj
        ON j.job_id = sj.job_id
INNER JOIN
    skills_dim AS s 
        ON sj.skill_id = s.skill_id
WHERE
    j.job_title_short = 'Data Analyst'
    AND j.salary_year_avg IS NOT NULL
GROUP BY
    s.skills
HAVING
    COUNT(DISTINCT j.job_id) >= 10
ORDER BY
    average_salary DESC,
    job_count DESC
LIMIT 10;
