SELECT m.member_name, r.review_text, TO_CHAR(r.review_date, 'YYYY-MM-DD')
FROM member_profile m, rest_review r
WHERE m.member_id = r.member_id
AND m.member_id = (
    SELECT member_id
    FROM (
        SELECT member_id
        FROM rest_review
        GROUP BY member_id
        ORDER BY COUNT(*) DESC
    )
    WHERE ROWNUM = 1
)
ORDER BY r.review_date, r.review_text;
