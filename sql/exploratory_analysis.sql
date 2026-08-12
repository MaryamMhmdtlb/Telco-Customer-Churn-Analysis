USE telco;



SELECT COUNT(DISTINCT CustomerID) AS total_customers
FROM telco_customer_churn;
SELECT DISTINCT(`Churn Reason`) AS churn_reason
FROM telco_customer_churn
;
-- ============================================
--  VAriables
-- ============================================
SET @churned_customers = (
    SELECT COUNT(*)
    FROM telco_customer_churn
    WHERE `Churn Label` = 'Yes'
);
SET @not_churned_customers = (
    SELECT COUNT(*)
    FROM telco_customer_churn
    WHERE `Churn Label` = 'No'
);

-- ============================================
--  Customer Status
-- ============================================


--- A fixed churn score threshold is not reliable, since about 25% of non-churn customers have scores above 65 (mean = 73, max = 80).
SELECT `Churn Label` AS churn_label , 
AVG(`Churn Score`) AS churn_score_avg, 
MIN(`Churn Score`) AS churn_score_min,
MAX(`Churn Score`) AS churn_score_max,
COUNT(*)/7064 AS churn_percent
FROM telco_customer_churn_status
GROUP BY `Churn Label`;

SELECT  
AVG(`Churn Score`) AS over65_churn_score_avg, 
COUNT(*)/@not_churned_customers AS over65_churn_score_percent
FROM telco_customer_churn_status
WHERE `Churn Label`='No' AND `Churn Score`>65;

--- Satisfaction score provides a clear churn threshold: customers with scores below 3 always churn, while those above 3 do not. Only a score of 3 includes both churned (429) and retained (2,236) customers.
SELECT `Churn Label` AS churn_label , 
AVG(`Satisfaction Score`) AS satisfaction_score_avg, 
MIN(`Satisfaction Score`) AS satisfaction_score_min,
MAX(`Satisfaction Score`) AS satisfaction_score_max
FROM telco_customer_churn_status
GROUP BY `Churn Label`;


SELECT  `Churn Label`,
COUNT(`Satisfaction Score`) AS satisfaction_score_count_3
FROM telco_customer_churn_status
WHERE `Satisfaction Score`=3
GROUP BY `Churn Label` ;

--- Database contain only third Quarter data
SELECT `Quarter`,SUM(`Churn Value`) AS quarterly_churn_value
FROM telco_customer_churn_status
GROUP BY  `Quarter`;

---  CLTV does not seem to be a strong predictor of customer churn, as its distribution is similar across both classes.
SELECT `Churn Label` AS churn_label , 
AVG(`CLTV`) AS cltv_score_avg, 
MIN(`CLTV`) AS cltv_score_min,
MAX(`CLTV`) AS cltv_score_max
FROM telco_customer_churn_status
GROUP BY `Churn Label`;

--- The main category for customers churn is "competitor", folllowed by "Attitude" is at the second place
SELECT `Churn Category` AS churn_category, COUNT(*)*100/@churned_customers AS churn_category_percent
FROM telco_customer_churn_status
WHERE `Churn Label`='Yes'
GROUP BY `Churn Category`
ORDER BY churn_category_percent DESC;

--- The 3 main reasons for customer churn, accounting for more than 45% of all churned customers are: "Competitor had better devices", "Competitor made better offer" and "Attitude of support person".
SELECT `Churn Reason` AS churn_reason, COUNT(*)*100/@churned_customers AS churn_reason_percent
FROM telco_customer_churn_status
WHERE `Churn Label`='Yes'
GROUP BY `Churn Reason`
ORDER BY churn_reason_percent DESC;

-- ============================================
--  Customer Services
-- ============================================


--- Almost each customer reffered 2 other customers on average, with a maximum of 11 referrals.
SELECT AVG(`Number of Referrals`) AS avg_referrals,
    MAX(`Number of Referrals`) AS max_referrals
FROM telco_customer_churn_services;

--- More than 50% of customers have no referrals.
SELECT `Number of Referrals` AS number_of_referrals, 
        COUNT(*)/(SELECT COUNT(*) FROM telco_customer_churn_services) AS referrals_percent
FROM telco_customer_churn_services
GROUP BY `Number of Referrals`
ORDER BY referrals_percent DESC;

--- More than half of customers in both groups did not receive any offer. Among customers who received an offer, Offer E is considerably more common in the churn group, while Offer B is more prevalent among retained customers.
SELECT
    fact.`Churn Label`,
    services.`Offer`,
    COUNT(*) /
    CASE
        WHEN fact.`Churn Label` = 'Yes' THEN @churned_customers
        ELSE @not_churned_customers
    END AS offer_percent
FROM telco_customer_churn_services AS services
JOIN telco_customer_churn AS fact
    ON services.CustomerID = fact.CustomerID
GROUP BY fact.`Churn Label`, services.`Offer`;

SELECT @churned_customer, @not_churned_customer;
--- There is no significant difference between churned and non-churned customers in terms of average monthly long-distance charges. However, the average tenure differs considerably: churned customers have an average tenure of 17 months, while non-churned customers have an average tenure of 37 months
SELECT fact.`Churn Label`, 
    AVG(`Avg Monthly Long Distance Charges`) AS avg_monthly_long_distance_charges,
    MAX(`Avg Monthly Long Distance Charges`) AS max_monthly_long_distance_charges,
    AVG(`Tenure in Months`) AS avg_tenure_in_months,
    MAX(`Tenure in Months`) AS max_tenure_in_months
FROM telco_customer_churn_services AS services
JOIN telco_customer_churn AS fact ON services.CustomerID = fact.CustomerID
GROUP BY fact.`Churn Label`;

--- Customers with Online Security and Device Protection are less likely to churn, while Phone Service and Multiple Lines show little difference.
SELECT  fact.`Churn Label`,
        SUM(services.`Multiple Lines Value`)/COUNT(*) AS multiple_lines_percent,
        SUM(services.`Phone Services Value`)/COUNT(*) AS phone_services_percent,
        SUM(services.`Online Security Value`)/COUNT(*) AS online_security_percent,
        SUM(services.`Internet Service Value`)/COUNT(*) AS internet_services_percent,
        SUM(services.`Device Protection Plan Value`)/COUNT(*) AS device_protection_percent
FROM telco_customer_churn_services AS services
JOIN telco_customer_churn AS fact ON services.CustomerID = fact.CustomerID
GROUP BY  fact.`Churn Label`;

--- Month-to-Month is the most common contract type among both, while One-Year and Two-Year contracts are much less common in churned customers. In contrast, non-churned customers show a more balanced distribution across the three contract types.
SELECT services.Contract, fact.`Churn Label`, COUNT(*)*100/@churned_customers AS contract_count
FROM telco_customer_churn_services AS services
JOIN telco_customer_churn AS fact ON services.CustomerID = fact.CustomerID
WHERE fact.`Churn Label` = 'Yes'
GROUP BY services.Contract, fact.`Churn Label`
UNION
SELECT services.Contract, fact.`Churn Label`, COUNT(*)*100/@not_churned_customers AS contract_count
FROM telco_customer_churn_services AS services
JOIN telco_customer_churn AS fact ON services.CustomerID = fact.CustomerID
WHERE fact.`Churn Label` = 'No'
GROUP BY services.Contract, fact.`Churn Label`;

--- The proportions are relatively similar across both groups.

SELECT  fact.`Churn Label`,
        SUM(services.`Streaming TV Value`)/@churned_customers AS stream_tv_count,
        SUM(services.`Streaming Movies Value`)/@churned_customers AS stream_movie_count,
        SUM(services.`Streaming Music Value`)/@churned_customers AS stream_music_count,
        SUM(services.`Unlimited Data Value`)/@churned_customers AS unlimited_data_count
FROM telco_customer_churn_services AS services
JOIN telco_customer_churn AS fact ON services.CustomerID = fact.CustomerID
WHERE  fact.`Churn Label` = 'Yes'
GROUP BY  fact.`Churn Label`
UNION
SELECT  fact.`Churn Label`,
        SUM(services.`Streaming TV Value`)/@not_churned_customers AS stream_tv_percent,
        SUM(services.`Streaming Movies Value`)/@not_churned_customers AS stream_movie_percent,
        SUM(services.`Streaming Music Value`)/@not_churned_customers AS stream_music_percent,
        SUM(services.`Unlimited Data Value`)/@not_churned_customers AS unlimited_data_percent
FROM telco_customer_churn_services AS services
JOIN telco_customer_churn AS fact ON services.CustomerID = fact.CustomerID
WHERE  fact.`Churn Label` = 'No'
GROUP BY  fact.`Churn Label`;

--- The order of payment methods is the same for both churned and non-churned customers. Bank Withdrawal is the most common payment method, followed by Credit Card, while Mailed Check is the least common. Although the counts differ because the two groups have different sizes, the overall ranking remains the same.
SELECT services.`Payment Method`, fact.`Churn Label`, COUNT(*)/@churned_customers AS payment_percent
FROM telco_customer_churn_services AS services
JOIN telco_customer_churn AS fact ON services.CustomerID = fact.CustomerID
WHERE fact.`Churn Label` = 'Yes'
GROUP BY services.`Payment Method`
UNION
SELECT services.`Payment Method`, fact.`Churn Label`, COUNT(*)/@not_churned_customers AS payment_percent
FROM telco_customer_churn_services AS services
JOIN telco_customer_churn AS fact ON services.CustomerID = fact.CustomerID
WHERE fact.`Churn Label` = 'No'
GROUP BY services.`Payment Method`
;

-- ============================================
--  Customer Demographics
-- ============================================

--- The non-churn group has higher percentages of senior citizens, customers under 30, and married customers compared to the churn group. The largest differences are observed in marital status and senior citizen status, suggesting that these two demographic characteristics may have a stronger association with customer churn than age under 30.  
SELECT fact.`Churn Label`, 
    SUM(demographics.`Under 30 Value`)/@churned_customers AS under30_percent,
    SUM(demographics.`Married Value`)/@churned_customers AS married_percent,
    SUM(demographics.`Senior Citizen Value`)/@churned_customers AS senior_citizen_percent
FROM telco_customer_churn_demographics AS demographics
JOIN telco_customer_churn AS fact ON demographics.CustomerID = fact.CustomerID
WHERE fact.`Churn Label` = 'Yes'
UNION
SELECT fact.`Churn Label`, 
    SUM(demographics.`Under 30 Value`)/@not_churned_customers AS under30_percent,
    SUM(demographics.`Married Value`)/@not_churned_customers AS married_percent,
    SUM(demographics.`Senior Citizen Value`)/@not_churned_customers AS senior_citizen_percent
FROM telco_customer_churn_demographics AS demographics
JOIN telco_customer_churn AS fact ON demographics.CustomerID = fact.CustomerID
WHERE fact.`Churn Label` = 'No';

