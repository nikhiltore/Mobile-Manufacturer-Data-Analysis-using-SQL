**📱 Mobile Manufacturer Data Analysis – SQL:**
This project is an advanced SQL analytical case study focused on understanding customer behavior, sales trends, and manufacturer performance in the mobile phone market.
Using a star-schema–based dataset (Fact + Dimension tables), the project answers 10 real-world business questions using optimized SQL queries.

**📁 Project Overview:**
**The dataset follows a data warehouse design:**
•	FACT_TRANSACTIONS – Sales transactions (quantity, price, date, model, customer, location)
•	DIM_CUSTOMER – Customer details
•	DIM_LOCATION – State, country, zipcode
•	DIM_MODEL – Mobile phone model details & pricing
•	DIM_MANUFACTURER – Manufacturer details
**Business Goals**
•	Analyze manufacturer performance
•	Track sales trends across states, years, and models
•	Identify customer purchasing behavior
•	Evaluate price patterns across models
•	Compare sales performance over time

**🛠️ Tech Stack:**
•	SQL Server (T-SQL)
•	Joins, window functions, grouping sets
•	CTEs, subqueries, EXCEPT/INTERSECT
•	Aggregations, ranking & ordering
•	Data warehousing (Fact–Dimension model)

**📂 SQL File Included:**
Mobile Manufacturer Data Analysis.sql
Contains solutions for:
•	State-level sales analysis
•	Manufacturer ranking
•	Model-level transaction breakdown
•	Year-wise performance analytics
•	Customer spending trends
•	Advanced logic using INTERSECT, EXCEPT, LAG

**🧩 Key Business Questions Answered:**
1️⃣ States with customers who purchased phones since 2005
Identifies geographic spread of customers over 18+ years.
2️⃣ US State buying the most Samsung phones
Finds highest Samsung demand by location.
3️⃣ Number of transactions per model per zipcode per state
Breakdown of model demand geographically.
4️⃣ Cheapest cellphone model
Returns model name with minimum price.
5️⃣ Average price by model for top 5 manufacturers (based on sales)
Ranks high-performing manufacturers by revenue.
6️⃣ Customers in 2009 with avg spend > ₹500
High-value customer identification.
7️⃣ Models appearing in the Top 5 across 2008, 2009, and 2010
Detects consistently high-selling models across 3 years.
8️⃣ Manufacturer with 2nd highest sales in 2009 & 2010
Finds second-best manufacturers by revenue.
9️⃣ Manufacturers who sold in 2010 but not in 2009
Year-on-year performance expansion.
🔟 Top 100 customers – avg spend, avg qty, and % change YoY
Uses window functions (LAG) to compute growth trends.

**📈 Skills Demonstrated:**
✔ Advanced joins across fact & dimension tables
✔ Market & customer segmentation analysis
✔ Identifying consistent top performers (INTERSECT)
✔ Finding missing values between years (EXCEPT)
✔ Ranking manufacturers by revenue
✔ Using window functions for YoY change
✔ Analytical SQL suited for BI & data engineering roles

**🧠 Project Outcomes:**
This SQL project showcases strong capabilities in:
•	Data warehousing & fact-dimension analysis
•	Complex business problem solving
•	Query optimization and structured approach
•	Real-world telecom/mobile domain analytics

