--
-- SSB DDL for PostgreSQL(Simple Version)
--
-- Author: @nuko_yokohama
--
-- Description
--   This script file registers the five tables and indexes specified in SSB in PostgreSQL.
--   This script file is verified with PostgreSQL 11.
--
-- Reference documents
--   Star Schema Benchmark Revision 3, June 5, 2009
--   (https://www.cs.umb.edu/~poneil/StarSchemaB.PDF)
--
-- Implementation concept
-- * "ssb-dbgen" data generater based.
-- * Table names and column names are in lowercase.
-- * Integer values map to integer types.
-- * Fixed Text data is CHAR(n).
-- * Variable Length Text data is TEXT.

DROP TABLE IF EXISTS lineorder, date, part, supplier, customer CASCADE;
--
-- customer
--
CREATE TABLE customer (
  c_custkey    INTEGER  PRIMARY KEY,
  c_name       TEXT,
  c_address    TEXT,
  c_city       CHAR(10),
  c_nation     CHAR(15),
  c_region     CHAR(12),
  c_phone      CHAR(15),
  c_mktsegment CHAR(10),
  dummy        TEXT -- dbgen last delimiter
);

--
-- date
--
CREATE TABLE date (
  d_datekey          DATE PRIMARY KEY,
  d_date             CHAR(18),
  d_dayofweek        CHAR(9),
  d_month            CHAR(9),
  d_year             INTEGER,
  d_yearmonthnum     INTEGER,
  d_yearmonth        CHAR(7),
  d_daynuminweek     INTEGER,
  d_daynuminmonth    INTEGER,
  d_daynuminyear     INTEGER,
  d_monthnuminyear   INTEGER,
  d_weeknuminyear    INTEGER,
  d_sellingseason    TEXT,
  d_lastdayinweekfl  CHAR(1),
  d_lastdayinmonthfl CHAR(1),
  d_holidayfl        CHAR(1),
  d_weekdayfl        CHAR(1),
  dummy              TEXT -- dbgen last delimiter
);

--
-- part
--
CREATE TABLE part (
  p_partkey   INTEGER PRIMARY KEY,
  p_name      TEXT,
  p_mfgr      CHAR(6),
  p_category  CHAR(7),
  p_brand1    CHAR(9),
  p_color     CHAR(11),
  p_type      TEXT,
  p_size      INTEGER,
  p_container CHAR(10),
  dummy       TEXT  -- dbgen last delimiter
);

--
-- supplier
--
CREATE TABLE supplier (
  s_suppkey INTEGER PRIMARY KEY,
  s_name    CHAR(25),
  s_address TEXT,
  s_city    CHAR(10),
  s_nation  CHAR(15),
  s_region  CHAR(12),
  s_phone   CHAR(15),
  dummy            TEXT -- dbgen last delimiter
);

--
-- lineorder
--
CREATE TABLE lineorder (
  lo_orderkey      BIGINT, -- Consider SF 300+
  lo_linenumber    INTEGER,
  lo_custkey       INTEGER, -- FK to C_CUSTKEY
  lo_partkey       INTEGER, -- FK to P_PARTKEY
  lo_suppkey       INTEGER, -- FK to S_SUPPKEY
  lo_orderdate     DATE,    -- FK to D_DATEKEY
  lo_orderpriority CHAR(15),
  lo_shippriority  CHAR(1),
  lo_quantity      INTEGER,
  lo_extendedprice NUMERIC,
  lo_ordtotalprice NUMERIC,
  lo_discount      NUMERIC,
  lo_revenue       NUMERIC,
  lo_supplycost    NUMERIC,
  lo_tax           NUMERIC,
  lo_commitdate    DATE, -- FK to D_DATEKEY
  lo_shipmod       CHAR(10), 
  dummy            TEXT, -- dbgen last delimiter
  CONSTRAINT lo_pkey  PRIMARY KEY(lo_orderkey, lo_linenumber),
  FOREIGN KEY (lo_custkey)  REFERENCES customer (c_custkey),
  FOREIGN KEY (lo_partkey)  REFERENCES part (p_partkey),
  FOREIGN KEY (lo_suppkey)  REFERENCES supplier (s_suppkey),
  FOREIGN KEY (lo_orderdate)  REFERENCES date (d_datekey)
);


