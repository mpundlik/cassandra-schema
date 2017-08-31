#Low Level Design

Tools:
* Cassandra DDL maker (GO struct -> DDL Create if not exists...)
 * reuse/fork/customize existing tool [kayac/ddl-maker](https://github.com/kayac/ddl-maker) - possibly prepare pull request
 * called from golang project where  (ideally using "go generate" directive)
 * go struct 
   * fields contain tags:
    * "ddl:" for specifying types, indexes ...
    * "pk:" for primary keys (single column or composite)
   * methods for
    * schema (keyspace) name
    * table name
* Cassandra DDL export
* Cassandra Diff DDL (DDL1 vs. DDL2 => ALTER ...)

