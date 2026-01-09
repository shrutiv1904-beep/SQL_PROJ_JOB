WITH top_pay_job AS (
    SELECT
        j.job_id,
        j.job_title,
        j.job_location,
        c.name,
        j.job_schedule_type,
        j.salary_year_avg,
        j.job_posted_date
    FROM
        job_postings_fact AS j
    LEFT JOIN
        company_dim AS c
        ON j.company_id = c.company_id
    WHERE
        j.job_location = 'Anywhere' AND
        j.job_title_short IN ('Data Analyst') AND
        j.salary_year_avg IS NOT NULL
    ORDER BY
        j.salary_year_avg DESC
    LIMIT 10
)

SELECT
    top_pay_job.job_id,
    top_pay_job.job_title,
    top_pay_job.name,
    top_pay_job.salary_year_avg,
    js.skills
FROM
    top_pay_job
INNER JOIN
    skills_job_dim AS skill_job
    ON top_pay_job.job_id = skill_job.job_id
INNER JOIN
    skills_dim AS js
    ON skill_job.skill_id = js.skill_id
WHERE
    js.skills IS NOT NULL
ORDER BY
    top_pay_job.salary_year_avg DESC
