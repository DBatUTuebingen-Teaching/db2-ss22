DROP TABLE IF EXISTS one CASCADE;
DROP TABLE IF EXISTS many;

CREATE TABLE one  (a int NOT NULL,
                   b text,
                   c int);
CREATE TABLE many (a int NOT NULL,
                   b text,
                   c int NOT NULL);

INSERT INTO one(a,b,c)
  SELECT i, left(md5(i::text), 16), random() * (100 + 1)    -- 1:100 relationship
  FROM   generate_series(1, 10000) AS i;

INSERT INTO many(a,b,c)
  SELECT o.a, right(md5(o.a::text), 16), i
  FROM   one AS o, LATERAL generate_series(0, o.c - 1) AS i;

-- ALTER TABLE one ADD CONSTRAINT one_a PRIMARY KEY (a);

-- ALTER TABLE many ADD CONSTRAINT many_a_c PRIMARY KEY (a,c);

ANALYZE one;
ANALYZE many;


DROP TABLE IF EXISTS many_skewed;
CREATE TABLE many_skewed AS 
SELECT 42 AS a, m.b, m.c 
FROM   many AS m; 

CREATE INDEX many_skewed_a_c ON many_skewed (a,c);
ANALYZE many_skewed;

/*
EXPLAIN (ANALYZE, VERBOSE, BUFFERS)
  SELECT *
  FROM   one AS o, many AS m
  WHERE  o.a = m.a
;
*/
