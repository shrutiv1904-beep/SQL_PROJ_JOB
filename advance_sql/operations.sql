SELECT
	activity_id,
 	hours_spent,
  	(hours_spent % 8) AS extra_hours
FROM
	invoices_fact
WHERE
	(hours_spent BETWEEN 8 AND 16) AND
   	extra_hours > 0
ORDER BY
	hours_spent
