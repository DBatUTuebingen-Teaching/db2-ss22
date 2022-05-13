DROP TABLE IF EXISTS documents;
CREATE TABLE documents(title CHAR(4) PRIMARY KEY, doc TEXT);
ALTER TABLE documents ALTER COLUMN doc SET STORAGE EXTERNAL;

INSERT INTO documents (
  SELECT  'doc' || ns.n, 
          repeat('Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.', 2)
  FROM generate_series(1,9) ns(n));

drop function if exists drop_toast_header(str bytea);
create or replace function drop_toast_header(str bytea)
returns bytea as
$$
DECLARE
    pos int;
BEGIN
    pos := position(E'\\x00' in str);
    WHILE pos>0 LOOP
      str := substring(str from pos+1);
      pos := position(E'\\x00' in str);
    END LOOP;
    RETURN str;
END
$$ LANGUAGE PLPGSQL;

drop function if exists convert(str bytea);
create or replace function convert(str bytea)
returns text as
$$
    SELECT convert_from(drop_toast_header(str),'UTF8');
$$ LANGUAGE SQL IMMUTABLE;