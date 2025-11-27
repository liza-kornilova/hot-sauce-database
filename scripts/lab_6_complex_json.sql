USE hot_sauce_shop;

SELECT
    JSON_OBJECT(
        'client_name', CONCAT(c.first_name, ' ', c.last_name),
        'client_email', c.email,
        'orders_history', CONCAT('[',
            GROUP_CONCAT(
                JSON_OBJECT(
                    'order_id', o.order_id,
                    'status', o.status,
                    'date', o.order_date
                )
            ),
        ']')
    ) AS client_full_data
FROM
    customers AS c
JOIN
    orders AS o ON c.customer_id = o.customer_id
WHERE
    c.customer_id = 1
GROUP BY
    c.customer_id;