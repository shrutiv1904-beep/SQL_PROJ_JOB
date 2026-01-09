-- delete later
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

