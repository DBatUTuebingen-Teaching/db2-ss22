
CREATE TABLE skewed (
 sort        INTEGER NOT NULL,
 category    INTEGER NOT NULL,
 interesting BOOLEAN NOT NULL
);

INSERT INTO skewed
 SELECT i AS sort, i % 1000 AS category, i > 50000 AS interesting
 FROM   generate_series(1, 1000000) i;

CREATE INDEX skewed_category ON skewed (category);
ANALYZE skewed;