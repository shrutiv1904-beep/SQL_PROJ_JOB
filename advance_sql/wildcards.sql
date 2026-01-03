SELECT
	job_id,
  	job_title,
   	job_title_short,
   	salary_year_avg
FROM
	job_postings_fact
WHERE
	job_title LIKE '%Analyst%'
