SELECT * 
FROM   skewed
WHERE  interesting AND category = 42
ORDER BY sort
LIMIT  20;