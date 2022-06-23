DROP TABLE indexed;
CREATE TABLE indexed (a INT PRIMARY KEY, b TEXT, c NUMERIC(3,2));

INSERT INTO indexed (SELECT i, md5(i::text), sin(i) FROM generate_series(1,1000000) AS i); 

DROP FUNCTION data_to_numeric(text);
CREATE FUNCTION data_to_numeric(data text) 
RETURNS numeric AS
$$
	SELECT SUM((get_byte(decode(a.v, 'hex'), 0) :: bigint) * (2^(8*(a.i - 1))) :: bigint)                         
	FROM unnest(string_to_array(data :: text, ' ')) WITH ORDINALITY AS a(v,i);    
$$ LANGUAGE SQL;