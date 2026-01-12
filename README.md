# Biergarten SQL Server - Architecture Overview

This solution is a monolith-oriented Web API with a layered structure. The current focus is a SQL Server-backed data layer with stored procedures and a repository-based DAL.

## High-level projects

- `WebAPI/` - ASP.NET Core API endpoints (controllers) and application entrypoint.
- `BusinessLayer/` - Intended home for domain/business logic (currently minimal).
- `DataAccessLayer/` - Repository implementations, entities (POCOs), and SQL helpers.
- `DataLayer/` - Database schema, seed scripts, and data sources.
- `WebCrawler/` - Separate crawler executable.
- `DALTests/` - Data access tests.

## Data access architecture

- **Entities (POCOs)** live in `DataAccessLayer/Entities/`.
- **Repositories** live in `DataAccessLayer/Repositories/` and implement interfaces like `IUserAccountRepository`.
- **SQL execution** lives in `DataAccessLayer/Sql/`.
- **Stored procedures** for CRUD live under `DataAccessLayer/Sql/crud/` and are invoked by repositories.

Example flow:

```
WebAPI Controller -> IUserAccountRepository -> UserAccountRepository -> stored procedure
```

The repositories are currently responsible for:
- Opening connections using `DB_CONNECTION_STRING`
- Executing stored procedures
- Mapping result sets to POCOs

## Database schema and seed

- `DataLayer/schema.sql` contains the database schema definitions.
- `DataLayer/seed/SeedDB.cs` provides seeding and stored procedure/function loading.
- Stored procedure scripts are organized under `DataAccessLayer/Sql/crud/` (UserAccount and related).

## Key conventions

- **Environment variables**: `DB_CONNECTION_STRING` is required for DAL and seed tooling.
- **Stored procedures**: CRUD operations use `usp_*` procedures.
- **Rowversion** columns are represented as `byte[]` in entities (e.g., `Timer`).

## Suggested dependency direction

```
WebAPI -> BusinessLayer -> DataAccessLayer -> SQL Server
                         -> DataLayer (schema/seed/scripts)
```

Keep business logic in `BusinessLayer` and avoid direct SQL or ADO code outside `DataAccessLayer`.
