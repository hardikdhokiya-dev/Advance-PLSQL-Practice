Common Oracle Error Codes (Must Remember)

---

### 🔴 Trigger & Execution Errors

**ORA-04088**

> Error during execution of a trigger
> 👉 Root cause is inside the trigger (not this error itself)

**ORA-06512**

> Shows line number / call stack
> 👉 Helps locate where error occurred

---

### 🔴 Data Errors

**ORA-01400**

> Cannot insert NULL into column
> 👉 Column defined as NOT NULL

**ORA-01403**

> No data found
> 👉 `SELECT INTO` returned 0 rows

**ORA-01422**

> Exact fetch returns more than requested rows
> 👉 `SELECT INTO` returned multiple rows

---

### 🔴 Constraint Errors

**ORA-00001**

> Unique constraint violated
> 👉 Duplicate value in PK/Unique column

**ORA-02290**

> Check constraint violated

**ORA-02291**

> Parent key not found
> 👉 Foreign key issue (insert child without parent)

**ORA-02292**

> Child record found
> 👉 Cannot delete parent (FK exists)

---

### 🔴 Numeric / Value Errors

**ORA-06502**

> Numeric or value error
> 👉 Common causes:

* Data type mismatch
* String too large
* Invalid conversion

---

### 🔴 Cursor / SQL Errors

**ORA-00904**

> Invalid identifier
> 👉 Wrong column name

**ORA-00942**

> Table or view does not exist

**ORA-00933**

> SQL command not properly ended

---

### 🔴 Trigger-Specific (VERY IMPORTANT)

**ORA-04091**

> Mutating table error
> 👉 Cannot query/update same table in row-level trigger

---

### 🔴 Transaction Errors

**ORA-01013**

> User requested cancel

**ORA-00054**

> Resource busy (table locked)

---

### 🔴 Conversion Errors

**ORA-01722**

> Invalid number
> 👉 Trying to convert string → number

---

## 🧠 Memory Trick

* **014xx** → Data issues
* **022xx** → Constraints
* **040xx** → Triggers
* **065xx** → PL/SQL runtime
* **009xx** → SQL syntax/structure

---

## 🔥 Top 10 MUST Remember (Interview Focus)

1. ORA-01403 → No data found
2. ORA-01422 → Too many rows
3. ORA-01400 → Cannot insert NULL
4. ORA-00001 → Unique constraint
5. ORA-06502 → Numeric/value error
6. ORA-00904 → Invalid identifier
7. ORA-00942 → Table not found
8. ORA-04088 → Trigger error
9. ORA-04091 → Mutating table
10. ORA-06512 → Line reference

---

## ⚡ Golden Rule

> ORA-04088 & ORA-06512 are NOT root causes — always look above them for the real error.

---
