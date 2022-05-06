DROP TABLE IF EXISTS "binary";
CREATE TABLE "binary"(a INT, b DOUBLE);

INSERT INTO "binary"(a,b) (
  SELECT value, value * 0.5
  FROM generate_series(1,101)
);

SELECT * FROM "binary";
