# Low Level Design

Tools:
* struct-to-ddl (GO struct -> DDL Create if not exists...)
* export-to-ddl (DB schema -> DDL Create if not exists...)
* diff-ddl (DDL1 vs. DDL2 -> ALTER table/type...)

## struct-to-ddl
DDL generater from go struct (enriched with metadata: tags, methods)

Input:
* go struct

Output
* DDL file (CREATE IF NOT EXISTS table/type...)

Specification:
* implement cassandra dialect for [kayac/ddl-maker](https://github.com/kayac/ddl-maker) - possibly prepare pull request 
* struct-to-ddl will be called from golang project where go struct resides
* go struct contains
   * fields tags:
     * "ddl:" for specifying field types
     * "pk:" for primary keys (single column or composite)
   * methods for
     * schema (keyspace) name
     * table name
     * indexes ...

## db-export-to-ddl
DB schema export tool that is able to generate DDL from existing DB schema (keyspace).

Input:
* Cassandra database endpoint
* schemas

Output
* DDL file (CREATE IF NOT EXISTS table/type...)

Specification:
* export schema using 
  * existing command line tools
    * Alternative 1: cqlsh https://medium.com/@adriagalin/import-and-export-keyspace-or-schema-in-cassandra-a7aa23c7092c
    * Alternative 2: cassandra-cli https://dzone.com/articles/dumpingloading-schema
  * custom implemenation (only if above is not really, really sufficient)
    * Alternative 3: write new one using gocql
  
Alternative 1: 
```
cqlsh -e "DESCRIBE KEYSPACE test" > /your/path/test.cql
```
  
Alternative 2:
```
echo -e "use your_keyspace;\r\n show schema;\n" | bin/cassandra-cli -h localhost > mySchema.cdl
```

## diff-ddl
Diff tool that is able to calculate ALTER statements from two DDL scripts.

Input:
* DDL 1 (output from struct-to-ddl)
* DDL 2 (output from db-export-to-ddl)

Output:
* DDL file (ALTER table/type...)

https://github.com/goccmack/gocc
