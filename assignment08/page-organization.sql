DROP TABLE ternary;
CREATE TABLE ternary (
    a   int,
    b   text,
    c   numeric(3,2)
);

INSERT INTO ternary(a,b,c)
    SELECT i, md5(i::text), sin(i) AS c
    FROM   generate_series(1,1000000) AS i
    ORDER BY i, c;

-- Auxiliary function: extract page p from RID (p,_)
DROP FUNCTION IF EXISTS page_of(tid);
CREATE FUNCTION page_of(rid tid) RETURNS bigint AS
$$
  SELECT (rid::text::point)[0]::bigint;
$$
LANGUAGE SQL;

SELECT *
FROM   ternary AS i
WHERE  i.a < 4242;


SELECT *
FROM   ternary AS i
WHERE  i.c = 0.42
