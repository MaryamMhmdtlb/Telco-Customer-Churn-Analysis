# Telco Customer Churn Analysis

**End-to-end BI & Retention Experimentation Project | MySQL · Power BI · DAX · A/B Testing**

---

## Business Problem

A telecom company serving **7,032 customers in California** experienced **26.6% customer churn in Q3**, resulting in approximately **$139K in monthly recurring revenue loss**.

The goal of this project is to identify the key drivers of churn, segment customers by risk level, quantify the financial impact of churn, and evaluate whether retention offers can **causally reduce churn** through controlled experimentation.

---

## Project Architecture

```text
IBM Telco Dataset (5 tables)
        │
        ▼
   MySQL Database
   ├── Data Cleaning & Encoding
   ├── Exploratory SQL Analysis
   ├── Analytical SQL Views
   └── JOIN across Demographics · Location · Services · Status
        │
        ▼
   Power BI Dashboard
   ├── Star Schema Model
   ├── 15+ DAX Measures
   ├── Interactive Slicers
   ├── Drill-through & Bookmarks
   └── Churn & Revenue Risk Analysis
        │
        ▼
   Retention Offer Analysis
   ├── None vs Offers A–E
   ├── Churn Rate Comparison
   └── A/B Test Significance Analysis
```

---

## Dataset

* **Source:** IBM Telco Customer Churn (5-table version)
* **Size:** 7,032 customers · Q3 fiscal quarter · California
* **Tables:** Demographics, Location, Population, Services, Status
* **Link:** [Kaggle — ylchang/telco-customer-churn-1113](https://www.kaggle.com/datasets/ylchang/telco-customer-churn-1113)

---

## Key Findings

### 1. Churn is concentrated in a specific contract type

**89% of churned customers had Month-to-Month contracts**, while Two-Year contract customers had only **3% churn rate**.

Contract type is therefore strongly associated with churn and represents an important segment for retention analysis.

---

### 2. Satisfaction score shows a strong threshold effect

Customers with satisfaction score ≤ 2 had a **100% observed churn rate**, while customers with score ≥ 4 had **0% observed churn**.

Score 3 was the only mixed group, making satisfaction score a potentially useful signal for identifying customers requiring further investigation.

---

### 3. Churned customers leave earlier

Average tenure among churned customers was approximately **18 months**, compared with **38 months** for retained customers — a gap of around **53%**.

This indicates that early-tenure customers represent an important population for retention analysis and experimentation.

---

### 4. Fiber Optic customers show particularly high churn

Fiber Optic customers exhibited the highest observed churn rate, with **Competitor** being a major reported churn category.

This suggests that competitive pressure may be an important factor for this segment, although observational churn reasons do not by themselves establish causality.

---

### 5. Retention offers require experimental validation

Initial observational analysis suggested substantial differences in churn rates between customers receiving different offers.

However, observed differences can be influenced by **customer selection and pre-existing risk differences**. Therefore, an A/B testing analysis was performed to distinguish statistically supported offer effects from simple correlations.

---

## A/B Test: Retention Offers

### Experiment Setup

Customers receiving **no offer** were compared with customers receiving one of five retention offers:

```text
Control
   │
   └── No Offer

Treatment Groups
   ├── Offer A
   ├── Offer B
   ├── Offer C
   ├── Offer D
   └── Offer E
```

The objective was to determine whether each offer was associated with a **statistically significant reduction in churn**, rather than selecting an offer based only on its observed churn rate.

### Results

| Offer | A/B Test Result             | Interpretation                                                                     |
| ----- | --------------------------- | ---------------------------------------------------------------------------------- |
| **A** | Significant churn reduction | Evidence supports an effect of the offer                                           |
| **B** | Significant churn reduction | Evidence supports an effect of the offer                                           |
| **C** | Not significant             | No statistically supported churn reduction                                         |
| **D** | Not significant             | No statistically supported churn reduction                                         |
| **E** | Higher observed churn       | Likely affected by selection bias; not evidence that the offer causes higher churn |

### Key Experimental Finding

**Offers A and B showed statistically significant churn reduction compared with the no-offer group.**

Offers C and D did not show a statistically significant effect.

Offer E was associated with higher observed churn. However, this result should **not be interpreted as evidence that Offer E causes higher churn**. Offer E was predominantly assigned to newer customers, whose average tenure was approximately **6 months** and who already had higher inherent churn risk.

This is an example of **selection bias/confounding in observational offer assignment** and demonstrates why comparing raw churn rates alone can lead to misleading conclusions.

---

## From Correlation to Experimentation

The project initially identified Offer A as a promising retention intervention based on observed churn differences.

The subsequent A/B testing analysis refined this conclusion:

```text
Initial Observational Analysis
        │
        ▼
Large churn differences across offers
        │
        ▼
A/B Test
        │
        ├── Offer A → Significant reduction
        ├── Offer B → Significant reduction
        ├── Offer C → No significant effect
        ├── Offer D → No significant effect
        └── Offer E → Higher observed churn
                         │
                         ▼
                  Selection Bias
```

The analysis therefore moves beyond **"Which offer has the lowest churn?"** toward the more appropriate business question:

> **"Which retention offers provide evidence of reducing churn when compared with a no-offer control?"**

---

## Dashboard Pages

| Page       | Focus                         | Key Visuals                                                                           |
| ---------- | ----------------------------- | ------------------------------------------------------------------------------------- |
| Overview   | Churn drivers & distribution  | KPI cards, Offer vs Churn Rate, Satisfaction threshold chart, Churn Category          |
| Customers  | Segment-level analysis        | Contract type, Internet type, Service adoption, Demographics, Tenure distribution     |
| Risk       | Risk segmentation & geography | Risk KPI cards, High Risk profile, Geographic map, Risk vs CLTV scatter               |
| Revenue    | Financial impact & actions    | Revenue lost, CLTV at Risk, Potential Saving, Actionable recommendations              |
| Experiment | Retention offer effectiveness | Control vs Treatment, Offer-level churn, Statistical significance, Experiment results |

---

## SQL Views

| View                    | Purpose                                  |
| ----------------------- | ---------------------------------------- |
| `vw_churn_by_service`   | Churn rate by internet and phone service |
| `vw_high_value_churned` | High CLTV customers who churned          |

---

## Key DAX Measures

```dax
-- Churn Rate
Churn Rate % = 
    DIVIDE(
        CALCULATE(
            COUNTROWS(telco_customer_churn_status),
            telco_customer_churn_status[Churn Label] = "Yes"
        ),
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
        SUMX(
            telco_customer_churn_services,
            telco_customer_churn_services[Monthly Charge]
        ),
        telco_customer_churn_status[Churn Label] = "Yes"
    )

-- Risk Category
Risk Category = 
    IF(
        [Churn Score] >= 75,
        "High Risk",
        IF(
            [Churn Score] >= 50,
            "Medium Risk",
            "Low Risk"
        )
    )
```

---

## Business Implications

The combined BI and experimentation analysis provides several actionable insights:

| Finding                                                       | Business Implication                                                               |
| ------------------------------------------------------------- | ---------------------------------------------------------------------------------- |
| Month-to-Month customers have substantially higher churn      | Prioritize flexible-contract customers for retention programs                      |
| Churn is concentrated among earlier-tenure customers          | Consider proactive interventions during early customer lifecycle                   |
| Offers A and B show statistically significant churn reduction | These offers provide evidence for further controlled testing and potential scaling |
| Offers C and D show no significant effect                     | Further investment should be evaluated against alternative interventions           |
| Offer E is concentrated among newer customers                 | Raw churn comparisons should account for customer selection and baseline risk      |

> **Important:** Statistical significance indicates evidence of a difference in the analyzed sample; it does not automatically establish long-term business ROI. Cost of the offer, incremental revenue retained, customer lifetime value, and scalability should also be evaluated before deployment.

---

## Project Structure

```text
telco-churn-analysis/
├── sql/
│   ├── 01_setup_and_cleaning.sql
│   ├── 02_exploratory_analysis.sql
│   └── ...
│
├── powerbi/
│   └── telco_churn_analysis.pbix
│
├── experimentation/
│   └── ab_test_analysis.*
│
└── README.md
```

---

## Tools & Skills

`MySQL` `Power BI` `DAX` `Power Query` `Star Schema` `SQL Views` `Data Cleaning` `EDA` `A/B Testing` `Statistical Significance` `Selection Bias` `Business Intelligence` `Data Storytelling` `Retention Analytics`

---

## Project Evolution

This project was initially developed as a **customer churn and retention BI analysis**.

Following the initial analysis, a controlled **A/B testing stage** was added to evaluate retention offers against a no-offer control group.

This extension improved the project from:

**Descriptive Analytics → Risk Segmentation → Retention Recommendations → Experimental Validation**

The final analysis distinguishes between **observed correlations and statistically supported treatment effects**, providing a more rigorous foundation for retention decisions.

---

## Author

**Maryam Mohammadtalebi**
[mohammadtalebi.maryam@gmail.com](mailto:mohammadtalebi.maryam@gmail.com)
