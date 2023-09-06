# Materializations Overview

## View
**Use it**
- You want a lightweight representation
- You don’t reuse data too often

**Don’t use it**
- You read from the same model several times


## Table
**Use it**
- You read from this model repeatedly

**Don’t use it**
- Building single-use models
- Your model is populated incrementally 


## Incremental (table appends)
**Use it**
- Fact tables
- Appends to tables

**Don’t use it**
- You want to update historical records


## Ephemeral (CTEs)
**Use it**
- You merely want an alias to your date

**Don’t use it**
- You read from the same model several times