-- create table orders with the TPC-H schema (without key constraints)
DROP TABLE IF EXISTS orders_tmp;
CREATE TEMP TABLE orders_tmp(
  o_orderkey       integer not null,
  o_custkey        integer not null,
  o_orderstatus    char(1) not null,
  o_totalprice     DECIMAL(15,2) not null,
  o_orderdate      DATE not null,
  o_orderpriority  char(15) not null,
  o_clerk          char(15) not null,
  o_shippriority   integer not null,
  o_comment        varchar(79) not null,
  o_fill           char(1000) not null
);

-- Copy data for table orders from file.
-- on your machine.
\copy orders_tmp from 'orders.tbl' with (format csv, delimiter '|');

DROP TABLE IF EXISTS orders;
CREATE TABLE orders AS
    SELECT 
          row_number() OVER () AS o_orderkey,
          o_custkey        ,
          o_orderstatus    ,
          o_totalprice     ,
          o_orderdate      ,
          o_orderpriority  ,
          o_clerk          ,
          o_shippriority   ,
          o_comment        ,
          o_fill        
    FROM orders_tmp;


-- create an unclustered index on attribute o_orderkey.
CREATE INDEX orders_idx ON orders(o_orderkey);

VACUUM FULL;
ANALYZE;