DROP TABLE ternary;
CREATE TABLE ternary (a int NOT NULL, b text NOT NULL, c float);

INSERT INTO ternary(a, b, c)
  SELECT value, md5(value), log(value)
  FROM   generate_series(1, 10000001);