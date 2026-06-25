# Advance PL/SQL Practice

Welcome to the **Advance PL/SQL Practice** repository. This project serves as a comprehensive, structured code playground designed to master advanced database programming, procedural logic, and performance tuning inside the Oracle Database ecosystem.

It features complete hands-on scripts moving from foundational programming to complex, enterprise-ready database architecture blocks, supported by official sample schemas.

---

## Repository Architecture & Core Modules

The codebase is organized into dedicated directories targeting distinct PL/SQL technical requirements:

*   **`Variables` / `Reading`** – Foundational block structure, lexical scoping, and scalar variable assignments.
*   **`Loops`** – Control flows including basic, `WHILE`, and optimized `FOR` loop variations.
*   **`Composite Data Type`** – Working with collections (Associative Arrays, Nested Tables, and Varrays) and record structures.
*   **`Cursors`** – Explicit and implicit cursor mechanics, bulk fetching data parameters, and cursor variables (`SYS_REFCURSOR`).
*   **`Exceptions`** – Building custom, user-defined exception handlers and tracking error propagation paths.
*   **`Procedure & Functions`** – Modular subprogram development with precise parameter mapping (`IN`, `OUT`, `IN OUT`, `NOCOPY`).
*   **`Package`** – Grouping logically related subprograms to enforce global state tracking and code encapsulation.
*   **`Triggers`** – Automated table audit patterns, row-level manipulation tracking, and database system event triggers.
*   **`DynamicSQL`** – Compiling native queries dynamically using `EXECUTE IMMEDIATE` with secure bind variables to defend against SQL Injection.
*   **`Debugging`** – Tools and strategies for profiling database runtime application flaws.

---

## Included Environments & Reference Material

*   **`db-sample-schemas-23.3`**: Contains official Oracle database mock schemas (e.g., Human Resources, Order Entry) to execute and test scripts against live relational data sets.
*   **`PLSQL.pdf`**: Direct conceptual reference text mapping the theoretical implementations of the advanced procedural modules practiced here.

---

## Getting Started Locally

### 1. Clone the Repository
```bash
git clone https://github.com
cd Advance-PLSQL-Practice
```

### 2. Setting Up Your Workspace
1. Pick a module folder (e.g., `Composite Data Type` or `DynamicSQL`).
2. Deploy the schemas inside `db-sample-schemas-23.3` into your local pluggable database engine (Oracle 19c / 21c / 23ai).
3. Connect via your preferred SQL client (**Oracle SQL Developer**, **VS Code**, or **SQL*Plus**) to run individual `.sql` scripts.

---

## 📝 Best Practices Followed
*   **Bulk Processing**: Leveraging `BULK COLLECT` and `FORALL` statements to limit database context-switching overhead.
*   **Secure Scope Coding**: Utilizing explicitly defined parameter scopes and strictly avoiding global state vulnerabilities inside dynamic inputs.
*   **Clean Structuring**: Dividing operations clearly into separate `Declaration`, `Execution`, and `Exception` blocks.
