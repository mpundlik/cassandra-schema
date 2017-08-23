# Goals
- Create tools that generates SQL DDL scripts for Cassandra
- Use generated SQL DDL scripts in migration on of following migration tools:
  - https://github.com/mattes/migrate/
  - https://github.com/db-journey/journey


# Concept
- Developer writes GO structures with metadata (field tags & helper methods)
- SQL DDL scrips are generated from the GO structures
- Connectivity to existing schema is needed to generate alter statements but tool needs to work also for generating new schema

# Iterations

## Iteration 1
- Generating new schema (in this iteration there is no need to connect to existing cassandra schema because no alter statments are calulated yet)
- Primary Keys
- Default mapping for go types to cassandra types

## Iteration 2
- Indexes
- UDTs
- customizable mapping of go types to cassandra types using new GO structure field tags

## Iteration 3
- Alter table statements
