SELECT name,
       SUM(amount) AS balance
FROM users
JOIN transactions
ON transactions.account=users.account
GROUP BY name
HAVING SUM(amount)>10000;