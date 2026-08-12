# Telco Customer Churn  Insights Report
**Q3 · 7,032 customers · California**

---

## Executive Summary

In Q3, the company lost **1,869 customers (26.6% churn rate)**, resulting in **$139K in monthly recurring revenue loss** and a seasonal estimate of **$3.68M**. Analysis of churn drivers reveals that the losses are not random  they are concentrated in specific contract types, service configurations, and customer profiles. Three targeted retention actions could prevent a meaningful portion of future churn with minimal operational cost.

---

## Finding 1  Contract Type is the Strongest Churn Predictor

### What the data shows
- **89% of all churned customers** had Month-to-Month contracts
- One-Year contract customers: ~9% churn rate
- Two-Year contract customers: ~3% churn rate
- Month-to-Month churn rate is approximately **30× higher** than Two-Year

### Why this happens
Month-to-Month contracts have no exit barrier. Customers can leave at any time without financial penalty, which means any negative experience  a competitor offer, a billing issue, a single bad support interaction  can immediately trigger churn. Long-term contract customers have already committed and are more likely to resolve issues before leaving.

### Business Impact
Month-to-Month churners account for **$2,490K** of total revenue lost in Q3  the single largest revenue driver in this analysis.

### Recommendation
**Priority 1: Contract Upgrade Campaign**
Target active Month-to-Month customers in the High Risk segment with a One-Year upgrade incentive (e.g., one month free, locked pricing, or a bundled discount). Even converting 20% of this segment to One-Year contracts would materially reduce churn exposure.

**Est. Impact: $248K (Q3)**
*Based on observed churn rate differential between M-to-M and One-Year contracts, applied to active High Risk M-to-M customers. Assumes 30% retention success rate.*

---

## Finding 2  Satisfaction Score is a Hard Threshold

### What the data shows
- Satisfaction Score ≤ 2: **100% churn rate** (no exceptions)
- Satisfaction Score = 3: mixed  43% churned, 57% stayed
- Satisfaction Score ≥ 4: **0% churn rate** (no exceptions)
- Average satisfaction score for churned customers: **1.74**

### Why this matters
Unlike most metrics that show gradual correlation with churn, satisfaction score behaves as a **binary threshold**. Scores 1 and 2 are not "at risk"  they are already decided. This means satisfaction surveys are not just a feedback tool; they are an **early churn detection signal** that can trigger proactive intervention before the customer formally cancels.

### Recommendation
Implement a satisfaction score monitoring process:
- Any customer who rates ≤ 2 should trigger an immediate outreach workflow
- Score = 3 customers should enter a nurture campaign (check-in call, offer review)
- This requires no new data collection  the signal already exists in the data

---

## Finding 3  Churn Risk Peaks Between Months 12–18

### What the data shows
- Average tenure of churned customers: **18 months**
- Average tenure of retained customers: **38 months** (53% longer)
- Churn distribution peaks in the 12–18 month tenure window
- After month 24, churn drops significantly

### Why this happens
The 12–18 month window likely coincides with the end of introductory pricing periods or the first contract renewal decision point. Customers who make it past 24 months have demonstrated loyalty and are significantly less likely to leave. The first two years are the highest-risk period.

### Recommendation
**Priority 3: Proactive Outreach at Month 15**
Identify all active customers approaching month 12–15 of tenure and initiate a proactive retention touchpoint  a check-in call, a loyalty offer, or a contract upgrade prompt. This is a predictable, repeatable intervention that targets the highest-risk window before the customer has made a decision.

**Est. Impact: $7K (Q3)**
*Based on active customers in the 12–18 month tenure window, observed churn rate for this group, and 30% retention success rate assumption.*

> Note: The relatively modest Q3 estimate reflects the small number of active customers currently in this window. The strategic value of this action is in its repeatability  every quarter a new cohort enters the 12–18 month window.

---

## Finding 4  Fiber Optic Churn is a Competitive Problem, Not a Service Problem

### What the data shows
- Fiber Optic has the highest churn rate: **~66%**
- Primary churn reason for Fiber Optic customers: **Competitor** (not Price or Dissatisfaction)
- Churned Fiber Optic customers had **lower avg monthly charges** than retained ones
- Senior Citizen proportion in Fiber Optic: 27% (same as DSL)

### What this means
The instinct might be to improve Fiber Optic service quality or bundle additional services. But the data tells a different story: customers are leaving because **a competitor made a better or cheaper offer**  not because they are unhappy with the service itself. The lower charges of churned customers suggest they were price-sensitive and found a better deal elsewhere.

### Recommendation
This finding requires a **competitive pricing response**, not a product improvement:
- Investigate which competitors are winning Fiber Optic customers and at what price points
- Consider a price-lock or loyalty rate for active Fiber Optic customers with tenure under 18 months (the highest-risk window)
- Avoid investing in service feature improvements until competitive pricing is addressed  the data does not support a service quality problem

---

## Finding 5  Offer A is the Most Effective Retention Tool Available

### What the data shows
- Offer A: **~7% churn rate**  lowest of all offers
- No Offer: **~27% churn rate**
- Offer E: **~53% churn rate**  highest, worse than no offer
- Difference between Offer A and No Offer: **20 percentage points**

### Important caveat
Correlation does not equal causation. Customers who received Offer A may have already been less likely to churn (selection bias). However, the magnitude of the difference (20pp) is large enough to warrant an expansion test.

### Recommendation
**Priority 2: Expand Offer A to High Risk Active Customers**
Run a controlled expansion of Offer A to a subset of High Risk active customers with no current offer. Measure churn rate over the next quarter to establish causal effect before full rollout. Simultaneously, investigate why Offer E is associated with higher churn  it may be attracting already-disengaged customers or creating pricing expectations that are not met.

**Est. Impact: $8K (Q3)**
*Based on active High Risk customers currently on No Offer, 20pp churn rate improvement assumption, and 30% retention success rate.*

---

## Finding 6  No-Internet Customers Have a Different Churn Profile

### What the data shows
- No-internet (phone-only) customers: **~6% churn rate** (lowest of all internet types)
- But their churn reasons are different: **Attitude** and **Price** dominate
- Competitor is less relevant  these customers are not being poached
- Senior Citizen proportion: only **3%** (much lower than other segments)

### What this means
This is a small, price-sensitive segment that churns when they feel mistreated or overcharged  not because a competitor approached them. Retention for this group is about **service quality and billing transparency**, not competitive pricing or contract incentives.

### Recommendation
Standard retention campaigns (contract upgrades, Offer E) are unlikely to be effective here. Instead:
- Ensure billing communications are clear and proactive for this segment
- Flag any support interactions with this segment for quality review
- This group is small enough that individual outreach may be cost-effective

---

## Summary Table

| Finding | Key Metric | Revenue Impact | Recommended Action |
|---------|-----------|---------------|-------------------|
| M-to-M contracts dominate churn | 89% of churned customers | $2,490K lost | Contract upgrade campaign |
| Satisfaction ≤ 2 = certain churn | 100% churn rate at score 1–2 | Unquantified early signal | Satisfaction-triggered outreach |
| Churn peaks at month 12–18 | Avg tenure churned: 18mo | $7K preventable (Q3) | Proactive outreach at month 15 |
| Fiber Optic churn = competition | ~66% churn rate | $1,694K lost to competitors | Competitive pricing response |
| Offer E most effective | 7% churn vs 27% no offer | $8K preventable (Q3) | Expand Offer E to High Risk |
| No-internet churn = service/price | Attitude + Price reasons | Low absolute impact | Billing clarity + support QA |

---

## Assumptions & Limitations

- All data is from a **single quarter (Q3)**. Seasonal patterns cannot be assessed.
- **Churn Score** is a pre-calculated IBM SPSS model score  not trained on this dataset. It is used as a proxy for risk segmentation, not as a validated predictive model.
- Est. Impact figures assume **30% retention success rate** for all actions  a conservative industry benchmark. Actual results depend on execution quality.
- **Correlation ≠ causation** applies throughout. Findings describe associations in the data; controlled experiments are needed to establish causal relationships before scaling any retention action.
- Revenue calculations use **Monthly Charge × 3 months** as the Q3 unit. Long-term LTV effects are not captured.

---

*Analysis by Maryam Mohammadtalebi · github.com/MaryamMhmdtlb*
