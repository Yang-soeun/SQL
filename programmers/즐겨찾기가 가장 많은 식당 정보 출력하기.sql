SELECT A.FOOD_TYPE, A.REST_ID, A.REST_NAME, A.FAVORITES
FROM REST_INFO A
WHERE (A.FOOD_TYPE, A.FAVORITES) IN (
    SELECT B.FOOD_TYPE, MAX(B.FAVORITES)
    FROM REST_INFO B
    GROUP BY B.FOOD_TYPE
)
ORDER BY A.FOOD_TYPE DESC
