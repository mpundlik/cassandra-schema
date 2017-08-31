# Goals
- Create tools that generates SQL DDL scripts for Cassandra according to [design](LLD.md)
- Use generated SQL DDL scripts during upgrade procedure with one of following migration tools:
  - https://github.com/mattes/migrate/
  - https://github.com/db-journey/journey


# Concept
- Developer writes GO structures with metadata (field tags & helper methods)
- SQL DDL scrips are generated from the GO structures
- Connectivity to existing schema is needed to generate alter statements but tool needs to work also without connecitivity (then it generates new schema with tables, UDTs etc.)

# Iterations

## Iteration 1 - struct -> DDL
- Generating new schema (in this iteration there is no need to connect to existing cassandra schema because no alter statments are calulated yet)
- Primary Keys
- Default mapping for go types to cassandra types

## Iteration 2 - struct -> DDL
- Indexes
- UDTs
- customizable mapping of go types to cassandra types using new GO structure field tags

## Iteration 3 - diff DDLs
- Alter table/type statements

## Iteration 4 - integration & doc
- shocase how all four tools work together during upgrade procedure (deploying new version of microservice)
- describe everything in documentation with example/tutorial
