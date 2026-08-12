USE telco;

ALTER TABLE telco_customer_churn
CHANGE COLUMN `ï»¿CustomerID` CustomerID VARCHAR(50);

ALTER TABLE telco_customer_churn_location
CHANGE COLUMN `ï»¿Customer ID` CustomerID VARCHAR(50);

ALTER TABLE telco_customer_churn_demographics
CHANGE COLUMN `ï»¿Customer ID` CustomerID VARCHAR(50);

ALTER TABLE telco_customer_churn_services
CHANGE COLUMN `ï»¿Customer ID` CustomerID VARCHAR(50);

ALTER TABLE telco_customer_churn_status
CHANGE COLUMN `ï»¿Customer ID` CustomerID VARCHAR(50);
ALTER TABLE telco_customer_churn_population
CHANGE COLUMN `ï»¿ID` ID VARCHAR(50);

--- Check Nulls
SELECT
    SUM('Churn Label' ) AS Null_ChurnLabel,
    SUM('Monthly Charge' IS NULL) AS Null_MonthlyCharge,
    SUM('Contract' IS NULL) AS Null_Contract,
    SUM('Payment Method' IS NULL) AS Null_PaymentMethod,
    SUM('Tenure' IS NULL) AS Null_Tenure
FROM telco_customer_churn;

SELECT
    SUM('Satisfaction Score' IS NULL) AS Null_satisfactionScore,
    SUM('CLTV' IS NULL) AS Null_CLTV,
    SUM('Churn Label' IS NULL) AS Null_ChurnLabel,
    SUM('Churn Reason' IS NULL) AS Null_ChurnReason

FROM telco_customer_churn_status;

--- Check Duplicates
SELECT CustomerID,
       COUNT(*) AS id_repetition
FROM telco_customer_churn
GROUP BY CustomerID
HAVING COUNT(*) > 1;

----- Checck yes/no values
-- Partner
SELECT
    Partner,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY Partner;

-- Dependents
SELECT
    Dependents,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY Dependents;

-- Senior Citizen
SELECT
    `Senior Citizen`,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY `Senior Citizen`;

-- Device Protection => Yes/No/Internet Service
SELECT
    `Device Protection`,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY `Device Protection`;

-- Phone Service
SELECT
    `Phone Service`,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY `Phone Service`;

-- Multiple Lines => Yes/No/No Phone Service
SELECT
    `Multiple Lines`,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY `Multiple Lines`;

-- Online Security => Yes/No/No Phone Service
SELECT
    `Online Security`,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY `Online Security`;

-- Online Backup =>Yes/No/No Internet Service
SELECT
    `Online Backup`,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY `Online Backup`;

-- Paperless Billing
SELECT
    `Paperless Billing`,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY `Paperless Billing`;

-- Streaming TV => Yes/No/No Internet Service
SELECT
    `Streaming TV`,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY `Streaming TV`;

-- Streaming Movies => Yes/No/No Internet Service
SELECT
    `Streaming Movies`,
    COUNT(*) AS Count
FROM telco_customer_churn
GROUP BY `Streaming Movies`;

--------Change yes/No values to 1/0
ALTER TABLE telco_customer_churn_services
ADD COLUMN `Multiple Lines Value` TINYINT(1),
ADD COLUMN `Phone Services Value` TINYINT(1),
ADD COLUMN `Internet Service Value` TINYINT(1),
ADD COLUMN `Online Security Value` TINYINT(1),
ADD COLUMN `Paperless Billing Value` TINYINT(1),
ADD COLUMN `Online Backup Value` TINYINT(1),
ADD COLUMN `Device Protection Plan Value` TINYINT(1),
ADD COLUMN `Premium Tech Support Value` TINYINT(1),
ADD COLUMN `Streaming TV Value` TINYINT(1),
ADD COLUMN `Streaming Movies Value` TINYINT(1),
ADD COLUMN `Streaming Music Value` TINYINT(1),
ADD COLUMN `Unlimited Data Value` TINYINT(1);

UPDATE telco_customer_churn_services
SET
    `Multiple Lines Value` = CASE WHEN `Multiple Lines` =  'Yes' THEN 1 ELSE 0 END,
    `Phone Services Value` = CASE WHEN `Phone Service` =  'Yes' THEN 1 ELSE 0 END,
    `Internet Service Value` = CASE WHEN `Internet Service` =  'Yes' THEN 1 ELSE 0 END,
    `Online Security Value` = CASE WHEN `Online Security` =  'Yes' THEN 1 ELSE 0 END,
    `Online Backup Value` = CASE WHEN `Online Backup` =  'Yes' THEN 1 ELSE 0 END,
    `Device Protection Plan Value` = CASE WHEN `Device Protection Plan` =  'Yes' THEN 1 ELSE 0 END,
    `Premium Tech Support Value` = CASE WHEN `Premium Tech Support` =  'Yes' THEN 1 ELSE 0 END,
    `Streaming TV Value` = CASE WHEN `Streaming TV` =  'Yes' THEN 1 ELSE 0 END,
    `Streaming Movies Value` = CASE WHEN `Streaming Movies` =  'Yes' THEN 1 ELSE 0 END,
    `Streaming Music Value` = CASE WHEN `Streaming Music` =  'Yes' THEN 1 ELSE 0 END,
    `Unlimited Data Value` = CASE WHEN `Unlimited Data` =  'Yes' THEN 1 ELSE 0 END,
    `Paperless Billing Value` = CASE WHEN `Paperless Billing` = 'Yes' THEN 1 ELSE 0 END;

ALTER TABLE telco_customer_churn
ADD COLUMN `Partner Value` TINYINT(1),
ADD COLUMN `Dependents Value` TINYINT(1),
ADD COLUMN `Senior Citizen Value` TINYINT(1),
ADD COLUMN `Phone Service Value` TINYINT(1),
ADD COLUMN `Paperless Billing Value` TINYINT(1);
UPDATE telco_customer_churn
SET
    `Partner Value` = CASE WHEN Partner = 'Yes' THEN 1 ELSE 0 END,
    `Dependents Value` = CASE WHEN Dependents = 'Yes' THEN 1 ELSE 0 END,
    `Senior Citizen Value` = CASE WHEN `Senior Citizen` = 'Yes' THEN 1 ELSE 0 END,
    `Phone Service Value` = CASE WHEN `Phone Service` = 'Yes' THEN 1 ELSE 0 END,
    `Paperless Billing Value` = CASE WHEN `Paperless Billing` = 'Yes' THEN 1 ELSE 0 END;

ALTER TABLE telco_customer_churn_demographics
ADD COLUMN `Under 30 Value` TINYINT(1),
ADD COLUMN `Married Value` TINYINT(1),
ADD COLUMN `Senior Citizen Value` TINYINT(1);
UPDATE telco_customer_churn_demographics
SET
    `Under 30 Value` = CASE WHEN `Under 30` = 'Yes' THEN 1 ELSE 0 END,
    `Married Value` = CASE WHEN `Married` = 'Yes' THEN 1 ELSE 0 END,
    `Senior Citizen Value` = CASE WHEN `Senior Citizen` = 'Yes' THEN 1 ELSE 0 END;

-- ============================================
--  Views
-- ============================================

CREATE OR REPLACE VIEW vw_customer_churn_summary AS
SELECT
    c.CustomerID,
    c.`Churn Label`,
    s.`Churn Score`,
    s.`Satisfaction Score`,
    s.CLTV,
    s.`Churn Category`,
    s.`Churn Reason`,
    srv.`Offer`,
    srv.Contract,
    srv.`Avg Monthly Long Distance Charges`,
    srv.`Tenure in Months`,
    srv.`Online Security Value`,
    srv.`Device Protection Plan Value`,
    srv.`Phone Services Value`,
    srv.`Multiple Lines Value`,
    srv.`Streaming TV Value`,
    srv.`Streaming Movies Value`,
    srv.`Streaming Music Value`,
    srv.`Unlimited Data Value`,
    srv.`Payment Method`,
    d.`Under 30 Value`,
    d.`Married Value`,
    d.`Senior Citizen Value`
FROM telco_customer_churn c
LEFT JOIN telco_customer_churn_status s
       ON c.CustomerID = s.CustomerID
LEFT JOIN telco_customer_churn_services srv
       ON c.CustomerID = srv.CustomerID
LEFT JOIN telco_customer_churn_demographics d
       ON c.CustomerID = d.CustomerID;


CREATE OR REPLACE VIEW vw_customer_status AS
SELECT
    CustomerID,
    `Churn Label`,
    `Satisfaction Score`,
    CASE
        WHEN `Satisfaction Score` < 3 THEN 'Low'
        WHEN `Satisfaction Score` = 3 THEN 'Medium'
        ELSE 'High'
    END AS satisfaction_category,
    `Churn Score`,
    CLTV,
    `Churn Category`,
    `Churn Reason`
FROM telco_customer_churn_status;