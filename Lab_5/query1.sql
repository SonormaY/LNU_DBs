--Get cities, for which there are no streets, sorted ascending by name. 
--Scheme of result data set: id | name

SELECT city.id, city.name
FROM city
WHERE NOT EXISTS (
	SELECT street.idS
	FROM street
	WHERE street.city_id == city.id
)
ORDER BY city.name ASC
