DROP TABLE IF EXISTS lineitems;
CREATE TABLE lineitems (
    l_orderkey          INTEGER          NOT NULL,
    l_partkey           INTEGER          NOT NULL,
    l_suppkey           INTEGER          NOT NULL,
    l_linenumber        INTEGER          NOT NULL,
    l_quantity          DOUBLE PRECISION NOT NULL,
    l_extendedprice     DOUBLE PRECISION NOT NULL,
    l_discount          DOUBLE PRECISION NOT NULL,
    l_tax               DOUBLE PRECISION NOT NULL,
    l_returnflag        CHAR(1)          NOT NULL,
    l_linestatus        CHAR(1)          NOT NULL,
    l_shipdate          DATE             NOT NULL,
    l_commitdate        DATE             NOT NULL,
    l_receiptdate       DATE             NOT NULL,
    l_shipinstruct      CHARACTER(25)    NOT NULL,
    l_shipmode          CHARACTER(10)    NOT NULL,
    l_comment           VARCHAR(44)      NOT NULL
);

\COPY lineitems FROM 'lineitems.csv' WITH (FORMAT csv, DELIMITER '|')


DROP TABLE IF EXISTS customers;
CREATE TABLE customers (
    customerName        VARCHAR(255)     NOT NULL,
    billingData         VARCHAR(255)     NOT NULL,
    phone               VARCHAR(100)     NOT NULL,
    contactFirstname    VARCHAR(255)     NOT NULL,
    contactLastname     VARCHAR(255)     NOT NULL,
    contactMail         VARCHAR(255)     NOT NULL,
    address             VARCHAR(255)     NOT NULL,
    city                VARCHAR(255)     NOT NULL,
    zip                 VARCHAR(10)      NOT NULL,
    country             VARCHAR(100)     NOT NULL,
    region              VARCHAR(50)      NOT NULL,
    notes               TEXT             NOT NULL,
    debitLimit          VARCHAR(100)     NOT NULL
);

\COPY customers FROM 'customers.csv' WITH (FORMAT csv, DELIMITER '|');

VACUUM ANALYZE;