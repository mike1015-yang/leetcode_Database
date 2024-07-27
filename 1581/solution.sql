WITH no_transaction AS (SELECT transaction_id,
                               visits.visit_id,
                               customer_id
                          FROM transactions
                         RIGHT JOIN visits
                            ON transactions.visit_id=visits.visit_id
                         WHERE transaction_id IS NULL)
SELECT customer_id,
       COUNT(customer_id) AS count_no_trans
FROM no_transaction
GROUP BY customer_id
ORDER BY count_no_trans DESC;
