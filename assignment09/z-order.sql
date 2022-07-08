-- A two dimensional space
DROP TABLE points;
CREATE TABLE points (x INT, y INT);

-- Populate space with points
INSERT INTO points
(SELECT x, y
 FROM   generate_series(0,99) x,  generate_series(0,99) y);

-- Create primary key index
CREATE UNIQUE INDEX points_x_y ON points USING btree (x,y);


-- Compute the Z-Order Value of two 8-bit numbers
CREATE OR REPLACE FUNCTION z_order_value(x INT, y INT)
    RETURNS INT AS $$
DECLARE
    z bit varying := '';
BEGIN
    FOR i IN 0..7 LOOP
        z := (x >> i) :: bit(1) || (y >> i) :: bit(1) || z;
    END LOOP;
    RETURN z :: bit(16) :: INT;
END
$$ LANGUAGE PLPGSQL IMMUTABLE;

CREATE INDEX points_z_value_x_y ON points USING btree (z_order_value(x,y)); 
ANALYZE;