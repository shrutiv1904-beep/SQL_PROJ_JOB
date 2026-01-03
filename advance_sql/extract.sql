SELECT
   c.name AS company_name,
   COUNT(j.job_id) AS insured_job_count
FROM
   job_postings_fact j
JOIN
   company_dim c
   ON j.company_id = c.company_id
WHERE
   j.job_health_insurance IS TRUE
   AND EXTRACT(YEAR FROM j.job_posted_date) = 2023
   AND EXTRACT(QUARTER FROM j.job_posted_date) = 2
GROUP BY
   c.name
ORDER BY
   insured_job_count DESC;