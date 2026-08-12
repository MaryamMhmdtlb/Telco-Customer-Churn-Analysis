# Telco Customer Churn Analysis
**End-to-end BI project | MySQL · Power BI · DAX**

---

## Business Problem

A telecom company serving 7,032 customers in California lost **26.6% of its customer base in Q3**, resulting in $139K in monthly recurring revenue loss. The goal of this project is to identify the drivers of churn, segment customers by risk level, and quantify the financial impact  enabling data-driven retention decisions.

---

## Project Architecture

```
IBM Telco Dataset (5 tables)
        │
        ▼
   MySQL Database
   ├── Data Cleaning & Encoding
   ├── Analytical SQL Views (4 views)
   └── JOIN across Demographics · Location · Services · Status
        │
        ▼
   Power BI Dashboard (4 pages)
   ├── Star Schema Model
   ├── 15+ DAX Measures
   └── Interactive Slicers & Drill-through
```

---

## Dataset

- **Source:** IBM Telco Customer Churn (5-table version)
- **Size:** 7,032 customers · Q3 fiscal quarter · California
- **Tables:** Demographics, Location, Population, Services, Status
- **Link:** [Kaggle — ylchang/telco-customer-churn-1113](https://www.kaggle.com/datasets/ylchang/telco-customer-churn-1113)

---

## Key Findings

### 1. Churn is concentrated in a specific contract type
**89% of churned customers had Month-to-Month contracts**, while Two-Year contract customers had only 3% churn rate. This single variable is the strongest predictor of churn in the dataset.

### 2. Satisfaction score is a hard threshold, not a gradient
Customers with satisfaction score ≤ 2 **always churn** (100%). Customers with score ≥ 4 **never churn** (0%). Score 3 is the only mixed group — making this a clear early warning signal for retention teams.

### 3. Churned customers leave early
Average tenure of churned customers: **18 months** vs 38 months for retained — a 53% gap. Churn risk peaks between months 12–18, creating a predictable intervention window.

### 4. Fiber Optic churn is driven by competition, not dissatisfaction
Fiber Optic has the highest churn rate (~66%), but the primary reason is **Competitor** category, not Price or Attitude. Churned Fiber customers also had *lower* average charges than retained ones — suggesting competitors are winning on price.

### 5. Offer E is the most effective retention tool
Customers with Offer E had only **7% churn rate** vs 27% for customers with no offer — a 20-percentage-point difference. Expanding Offer E to High Risk active customers is the highest-ROI retention action available.

### 6. No-internet customers churn due to attitude and price
Customers without internet service (phone-only) cited **Attitude** and **Price** as top churn reasons  unlike internet customers who cite competitors. This segment likely skews older (Senior Citizen) and is more sensitive to service quality and billing.

---

## Dashboard Pages

| Page | Focus | Key Visuals |
|------|-------|-------------|
| Overview | Churn drivers & distribution | KPI cards, Offer vs Churn Rate, Satisfaction threshold chart, Churn Category |
| Customers | Segment-level analysis | Contract type, Internet type, Service adoption, Demographics, Tenure distribution |
| Risk | Risk segmentation & geography | Risk KPI cards, High Risk profile, Geographic map, Risk vs CLTV scatter |
| Revenue | Financial impact & actions | Revenue lost, CLTV at Risk, Potential Saving, Actionable recommendations table |

---

## SQL Views

| View | Purpose |
|------|---------|
| `vw_churn_by_service` | Churn rate by internet and phone service |
| `vw_high_value_churned` | High CLTV customers who churned |

---

## Key DAX Measures

```dax
-- Churn Rate
Churn Rate % = 
    DIVIDE(
        CALCULATE(COUNTROWS(telco_customer_churn_status),
                  telco_customer_churn_status[Churn Label] = "Yes"),
        COUNTROWS(telco_customer_churn_status)
    )

-- Tenure Gap Badge
Tenure Gap % = 
    DIVIDE(
        [Avg Tenure Churned] - [Avg Tenure Retained],
        [Avg Tenure Retained]
    )

-- Monthly Revenue Lost
Monthly Revenue Lost = 
    CALCULATE(
        SUMX(telco_customer_churn_services, 
             telco_customer_churn_services[Monthly Charge]),
        telco_customer_churn_status[Churn Label] = "Yes"
    )

-- Risk Category (Calculated Column)
Risk Category = 
    IF([Churn Score] >= 75, "High Risk",
    IF([Churn Score] >= 50, "Medium Risk", "Low Risk"))
```

---

## Actionable Recommendations

| Priority | Action | Target Segment | Est. Impact (Q3) |
|----------|--------|----------------|-----------------|
| 1 | Contract upgrade offer | Month-to-Month · High Risk | $248K |
| 2 | Expand Offer E | High Risk Active · No current offer | $8K |
| 3 | Proactive outreach at month 15 | Tenure 12–18 months · Active | $7K |

> **Assumptions:** Est. Impact based on observed churn rate differentials between segments. Retention success rate assumed at 30–50%. All figures are Q3 seasonal estimates, not annualized.

---

## Project Structure

```
telco-churn-analysis/
├── sql/
│   ├── 01_setup_and_cleaning.sql
│   ├── 02_encoding.sql
│   ├── 03_eda_queries.sql
│   └── 04_views.sql
├── powerbi/
│   └── telco_churn_analysis.pbix
├── docs/
│   └── insights_report.md
└── README.md
```

---

## Tools & Skills

`MySQL` `Power BI` `DAX` `Power Query` `Star Schema` `SQL Views` `Data Cleaning` `EDA` `Business Intelligence` `Data Storytelling`

---

## Author

**Maryam Mohammadtalebi**  
mohammadtalebi.maryam@gmail.com
