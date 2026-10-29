# SQL Data Types — Revision Notes

**Database:** PostgreSQL

A data type defines what kind of value a column can store.

## 1. Numeric Data Types

| Data Type | Purpose | Example |
|---|---|---|
| `SMALLINT` | Small-range whole numbers | `age SMALLINT` |
| `INTEGER` / `INT` | Whole numbers | `quantity INT` |
| `BIGINT` | Large-range whole numbers | `population BIGINT` |
| `NUMERIC(p, s)` | Exact decimal values | `price NUMERIC(10, 2)` |
| `DECIMAL(p, s)` | Equivalent to `NUMERIC` in PostgreSQL | `salary DECIMAL(12, 2)` |
| `REAL` | Approximate floating-point number | `temperature REAL` |
| `DOUBLE PRECISION` | Approximate floating-point number with greater precision than `REAL` | `measurement DOUBLE PRECISION` |
| `SERIAL` | Auto-incrementing integer sequence shorthand | `student_id SERIAL` |

In `NUMERIC(p, s)`, `p` is the maximum number of digits and `s` is the number of digits after the decimal point.

Example:
```sql
CREATE TABLE products (
    product_id SERIAL PRIMARY KEY,
    quantity INT,
    price NUMERIC(10, 2)
);
```

## 2. Character and Text Types

| Data Type | Purpose |
|---|---|
| `CHAR(n)` | Fixed-length character string; shorter values are padded with spaces |
| `VARCHAR(n)` | Variable-length string with a maximum length |
| `TEXT` | Variable-length text without a declared length limit |

Example:
```sql
CREATE TABLE users (
    username VARCHAR(50),
    country_code CHAR(2),
    biography TEXT
);
```

Use `VARCHAR` or `TEXT` for most ordinary text. Use `CHAR(n)` when a fixed-width value is appropriate.

## 3. Date and Time Types

| Data Type | Purpose | Example |
|---|---|---|
| `DATE` | Date only | `'2026-10-27'` |
| `TIME` | Time of day | `'14:30:00'` |
| `TIMESTAMP` | Date and time without time-zone awareness | `'2026-10-27 14:30:00'` |
| `TIMESTAMPTZ` | Timestamp with time-zone-aware handling | `'2026-10-27 14:30:00+05:30'` |
| `INTERVAL` | Duration or amount of time | `INTERVAL '2 days'` |

Example:
```sql
CREATE TABLE events (
    event_id SERIAL PRIMARY KEY,
    event_date DATE,
    start_time TIME,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);
```

PostgreSQL stores `TIMESTAMPTZ` instants internally and displays them according to the session time zone.

## 4. Boolean Type

`BOOLEAN` stores `TRUE`, `FALSE`, or `NULL` (unknown).

```sql
CREATE TABLE attendance (
    student_id INT,
    is_present BOOLEAN DEFAULT FALSE
);
```

## 5. Other Useful PostgreSQL Types

| Data Type | Purpose |
|---|---|
| `UUID` | Universally unique identifier |
| `JSON` | Stores JSON text and validates JSON syntax |
| `JSONB` | Stores JSON in a decomposed binary format, often useful for querying |
| `BYTEA` | Binary data |
| `ARRAY` | Stores values of the same element type in an array |

Example:
```sql
CREATE TABLE app_events (
    event_id UUID,
    details JSONB
);
```

## 6. Choosing a Suitable Data Type

- Use `INT` for counts and ordinary whole-number IDs.
- Use `NUMERIC(precision, scale)` for exact values such as prices and financial amounts.
- Use `VARCHAR(n)` or `TEXT` for names and descriptions.
- Use `DATE` for a date without a time.
- Use `TIMESTAMP` or `TIMESTAMPTZ` for date-and-time values, choosing based on time-zone requirements.
- Use `BOOLEAN` for true/false states.
- Use `SERIAL` for a convenient auto-incrementing integer column in PostgreSQL; identity columns are the modern SQL-standard alternative.

## 7. Identity Column Example

```sql
CREATE TABLE employees (
    employee_id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    employee_name VARCHAR(100) NOT NULL
);
```

## 8. Quick Revision

- `INT`: whole number.
- `NUMERIC(10, 2)`: exact decimal with up to 10 total digits, 2 after the decimal.
- `VARCHAR(100)`: variable-length text up to 100 characters.
- `CHAR(8)`: fixed-length text of 8 characters, padded when shorter.
- `DATE`: date only.
- `TIMESTAMP`: date and time without time-zone awareness.
- `BOOLEAN`: `TRUE`, `FALSE`, or `NULL`.
