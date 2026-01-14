# Biergarten SQL Server - Architecture Overview

This solution is a monolith-oriented Web API with a layered structure. The current focus is a SQL Server-backed data layer with stored procedures and a repository-based DAL.

## High-level projects

- `WebAPI/` - ASP.NET Core API endpoints (controllers) and application entrypoint.
- `BusinessLayer/` - Intended home for domain/business logic
- `DataAccessLayer/` - Repository implementations, entities (POCOs), and SQL helpers.
- `DataLayer/` - DbUp console app that applies embedded schema/functions/procedures.
- `DBSeed/` - Console app for seeding locations and test user data.
- `DALTests/` - Data access tests.

## Data access architecture

- **Entities (POCOs)** live in `DataAccessLayer/Entities/`.
- **Repositories** live in `DataAccessLayer/Repositories/` and implement interfaces like `IUserAccountRepository`.
- **SQL execution** lives in `DataAccessLayer/Sql/`.
- **Stored procedures** for CRUD live under `DataLayer/scripts/03-crud/` and are invoked by repositories.

Example flow:

```
WebAPI Controller -> UserService -> UserAccountRepository -> stored procedure
```

The repositories are currently responsible for:
- Opening connections using `DB_CONNECTION_STRING`
- Executing stored procedures
- Mapping result sets to POCOs

## Database schema and seed tooling

- `DataLayer/scripts/01-schema/schema.sql` contains the database schema definitions.
- `DataLayer/scripts/02-functions/` holds application functions.
- `DataLayer/scripts/03-crud/` holds CRUD stored procedures.
- `DataLayer/Program.cs` runs DbUp to apply embedded scripts to the database.
- `DBSeed/Program.cs` runs the location and user seeders using `DB_CONNECTION_STRING`.

## Key conventions

- **Environment variables**: `DB_CONNECTION_STRING` is required for DAL and seed tooling.
- **Stored procedures**: CRUD operations use `usp_*` procedures.

## Suggested dependency direction

```
WebAPI -> BusinessLayer -> DataAccessLayer -> SQL Server
                         -> DataLayer (schema/seed/scripts)
```

Keep business logic in `BusinessLayer` and avoid direct SQL or ADO code outside `DataAccessLayer`.
