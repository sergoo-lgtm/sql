<div align="center">

  <img src="https://capsule-render.vercel.app/api?type=rect&color=8A2BE2&height=200&section=header&text=SQL%20Level%202&fontSize=80&fontColor=ffffff&fontAlignY=50" width="100%" alt="SQL Level 2 Header" />

  <h3>🚀 Advanced SQL: Complex Joins, Window Functions & Analytics</h3>

  <p>
    <img src="https://img.shields.io/badge/Level-Advanced%20Architecture-8A2BE2?style=for-the-badge&logo=google-cloud&logoColor=white" />
    <img src="https://img.shields.io/badge/Skills-OLAP%20%26%20Reporting-success?style=for-the-badge&logo=google-analytics&logoColor=white" />
    <img src="https://img.shields.io/badge/Database-PostgreSQL%20%2F%20SQL%20Server-0064a5?style=for-the-badge&logo=postgresql&logoColor=white" />
  </p>

</div>

---

## 🚀 The Engineering Shift
Welcome to the **Deep Dive**. While Level 1 was about *talking* to the database, Level 2 is about *making the database work for you*.

In this module, I move beyond simple data retrieval to solve complex business logic involving **Temporal Analysis**, **Ranking Algorithms**, and **Full-Scale Database Design**.

> *"Data without context is just noise. Advanced SQL is the filter."*

---

## 🧠 Technical Arsenal (Concepts Mastered)

I have structured this level to cover the most critical tools for a Backend/Data Engineer:

| 📂 Module | 🛠️ Engineering Concept | 💡 Application |
| :--- | :--- | :--- |
| **`01-multiple-tables`** | **Complex Joins** | `SELF JOIN` for hierarchy (Manager/Employee), `CROSS JOIN` for matrix generation. |
| **02-Subqueries** | **Nested Logic** | Correlated Subqueries & CTEs for isolating complex logic steps. |
| **03-Set-Operations** | **Data Merging** | `UNION`, `INTERSECT`, `EXCEPT` for comparing datasets (e.g., Finding missing inventory). |
| **04-Advanced-Aggregates**| **Conditional Analytics** | `CASE WHEN` inside `SUM()`/`COUNT()` for pivot-table like reports. |
| **05-Window-Functions** | **OLAP Powerhouse** | `ROW_NUMBER`, `RANK`, `DENSE_RANK`, `LEAD/LAG` for Time-Series Analysis. |
| **06-Case-Studies** | **System Design** | End-to-End database creation (Hospital, E-Commerce, Rentals). |

---

## 🏗️ Featured Systems (Case Studies)

This isn't just theory. I built complete schemas mimicking real-world software backends.

### 🏥 [Hospital Management System](./06-sql-Practice-case-studies/Project%20-%20Hospital%20Management%20System.sql)
*A healthcare workflow system managing Patients, Doctors, and Treatments.*
* **Key Tech:** `ON DELETE CASCADE` for data integrity, `RANK()` for doctor performance, Relational Integrity.
* **Scenario:** Tracking patient history across multiple specializations.

### 🛒 [E-Commerce Order System](./06-sql-Practice-case-studies/E-Commerce-Order-Management-System-project.sql)
*A full-scale sales backend tracking the lifecycle of an order.*
* **Key Tech:** Revenue Analysis, `HAVING` clauses for high-value customers, Product Ranking.
* **Scenario:** Calculating monthly revenue growth and shipping logistics.

### 🏠 [Happy Haven Rentals](./06-sql-Practice-case-studies/Happy-Haven-House-Rental-App.sql)
*An Airbnb-style booking platform.*
* **Key Tech:** Complex Filtering (Properties with specific amenities), Date Range overlaps for bookings.
* **Scenario:** "Find users who made >1 payment and booked in July 2023".

---

## ⚡ "Senior" Code Highlights

A showcase of the most complex logic implementations in this repository.

### 1️⃣ Time-Series Analysis (Moving Averages)
Using `Window Functions` to calculate running totals and moving averages without external code.
```sql
-- Calculating a 3-Row Moving Average for Salaries
SELECT 
    employee_id, 
    salary,
    AVG(salary) OVER (
        PARTITION BY department 
        ORDER BY employee_id 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) AS moving_avg_3
FROM employees;
