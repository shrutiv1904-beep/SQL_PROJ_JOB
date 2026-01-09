WITH job_skills AS (
    SELECT
        sj.skill_id,
        COUNT(*) AS skill_count
    FROM
        skills_job_dim AS sj 
    INNER JOIN
        job_postings_fact AS j
        ON sj.job_id = j.job_id
    WHERE
        j.job_work_from_home = 'TRUE' AND
        j.job_title_short = 'Data Analyst'
    GROUP BY
        sj.skill_id
)

SELECT
    s.skill_id,
    s.skills,
    skill_count
FROM
    job_skills
INNER JOIN
        skills_dim AS s
        ON job_skills.skill_id = s.skill_id
ORDER BY
    skill_count DESC
LIMIT 10;

-- OR ANOTHER QUERY 

SELECT
    skills,
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
    job_postings_fact.job_work_from_home = 'TRUE' AND
    job_postings_fact.job_title_short = 'Data Analyst'
GROUP BY
    skills
ORDER BY
    count DESC
LIMIT
    5