SELECT
    ROUND(AVG(j.salary_year_avg), 2) AS average_salary,
    COUNT(j.job_id) AS job_count,
    s.skills
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
    s.skills
ORDER BY
    average_salary DESC
LIMIT 10;