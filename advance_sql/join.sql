SELECT
	job_postings.job_id,
   	job_postings.job_title_short,
   	job_postings.company_id,
   	company.company_id,
   	company.name
FROM
	job_postings_fact AS job_postings
RIGHT JOIN company_dim AS company  -- here we made a right join on table company_dim
	ON job_postings.company_id = company.company_id