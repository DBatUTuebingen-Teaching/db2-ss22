DROP TABLE unary;
CREATE TABLE unary (a INTEGER PRIMARY KEY);

ALTER INDEX unary_pkey RENAME TO unary_a;

INSERT INTO unary (
	SELECT i
	FROM generate_series(1,1000000) i
);

ANALYZE unary;

\set n 64

SELECT u.a
FROM unary AS u
WHERE u.a - 1 = :n;

SELECT u.a
FROM unary AS u
WHERE (u.a::double precision)^2 = :n;

SELECT u.a
FROM unary AS u
WHERE u.a % :n = 1;

SELECT u.a
FROM unary AS u
WHERE :n / u.a = 1;