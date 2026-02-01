<div align="center">
  
  <img src="https://capsule-render.vercel.app/api?type=waving&color=gradient&customColorList=0f4c81,20B2AA&height=300&section=header&text=SQL%20Level%201&fontSize=80&fontColor=ffffff&animation=fadeIn&fontAlignY=35&desc=The%20Foundation%20%26%20Basic%20Queries&descAlignY=60&descAlign=50" width="100%" alt="SQL Level 1 Header" />

  <a href="https://git.io/typing-svg">
    <img src="https://readme-typing-svg.herokuapp.com?font=Fira+Code&weight=600&size=25&pause=1000&color=FCA311&center=true&vCenter=true&width=600&lines=Mastering+SELECT+Statement;Data+Definition+(DDL);Data+Manipulation+(DML);Building+Real+Business+Databases+🚀" alt="Typing SVG" />
  </a>

  <p>
    <img src="https://img.shields.io/badge/Focus-Fundamentals-0f4c81?style=for-the-badge&logo=codeforces&logoColor=white" />
    <img src="https://img.shields.io/badge/Database-SQLite%20%2F%20Postgres-orange?style=for-the-badge&logo=postgresql&logoColor=white" />
    <img src="https://img.shields.io/badge/Code-Clean%20%26%20Structured-success?style=for-the-badge&logo=geeksforgeeks&logoColor=white" />
  </p>
</div>

---

## 🚧 Introduction

Welcome to the **Ground Zero** of my Data Engineering journey. This module isn't just about syntax; it's about understanding the **Relational Model**. Here, I learned how to talk to the database, ask the right questions, and structure data to solve actual business problems.

> *"Before you can analyze Big Data, you must master the Small Data."*

---

## 📂 Module Breakdown

This level is structured to take you from writing a simple `SELECT` to building complete database systems.

| 📁 Directory | 🧠 Core Concepts | 🛠️ Applied Skills |
| :--- | :--- | :--- |
| **`01-queries`** | **The Grammar** | `WHERE`, `BETWEEN`, `LIKE`, `IS NULL`, Logical Operators. |
| **`02-functions`** | **The Logic** | `GROUP BY`, `HAVING`, Date Math (`JULIANDAY`, `STRFTIME`), Aggregates (`SUM`, `AVG`). |
| **`03-practice-projects`** | **The Systems** | Full DDL/DML implementation, Constraints, Foreign Keys, Business Logic. |

---

## 🏆 Featured Projects (Real-World Simulations)

I applied the concepts to build two distinct systems. These aren't just tables; they are simulations of real-world operations.

### 🛒 [1. Retail Store Management System](./03-practice-projects/Retail-Store-Management-System-project.sql)
*A backend simulation for a retail business handling Inventory, Customers, and Sales.*

* **⚡ Key Features Implemented:**
    * **Inventory Control:** Track stock levels and automatically flag out-of-stock items.
    * **Dynamic Pricing:** Bulk updates for price changes (e.g., *Increasing Electronics prices by 10%*).
    * **Sales Analytics:** Calculate total revenue, average spending per customer, and monthly trends.
    * **Data Cleaning:** Removing inactive customers and old orders to maintain DB health.

### 🎓 [2. School Database System](./03-practice-projects/School-Database-Project.sql)
*A comprehensive system for an educational institution tracking Students, Faculty, and Grades.*

* **⚡ Key Features Implemented:**
    * **Relational Integrity:** Linking `Students`, `Courses`, and `Faculty` seamlessly.
    * **Academic Tracking:** Calculating average marks per department and identifying outstanding fees.
    * **Scenario Handling:** Managing "Savepoints" for salary updates and rolling back transactions (TCL).
    * **Grade Analysis:** Filtering students based on performance metrics using complex `WHERE` clauses.

---

## 💡 Technical Highlights (The "Senior" Details)

Here are some specific SQL capabilities demonstrated in the code files:

### 1️⃣ Advanced Date Handling
Handling time isn't just about dates; it's about intervals and formatting.
```sql
-- Calculating the difference in days between dates
SELECT JULIANDAY('2024-12-25') - JULIANDAY('2023-09-24') AS Days_Difference;

-- Formatting timestamps for reports
SELECT STRFTIME('%Y-%m-%d %H:%M:%S', '2023-04-20 13:40:23', '+10 days');
