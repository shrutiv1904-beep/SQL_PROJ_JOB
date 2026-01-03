SELECT
   	job_title_short AS title,
   	job_location AS location,
   	job_posted_date AT TIME ZONE 'UTC' AT TIME ZONE 'EST' AS date_time -- will convert UTC time zone to EST time zone
FROM
  	job_postings_fact;