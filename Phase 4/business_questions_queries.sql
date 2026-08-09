-- Fraud Analysis — Key Findings

-- 1. What is the overall fraud rate across all transactions? (total transactions, fraud count, fraud rate %)

call fraud_detection_db.sp_overall_fraud_rate();

-- Out of 1,852,394 transactions, 9,651 were fraudulent — an overall fraud rate of 0.521%. This matches typical real-world card fraud rates and 
-- serves as the baseline for every comparison below.





-- 2. Which merchant categories have the highest fraud rates? (group by category, calculate fraud rate for each)

call fraud_detection_db.sp_fraud_rate_by_category();

-- Highest: shopping_net (1.593%), misc_net (1.304%), grocery_pos (1.265%). Lowest: home and health_fitness (0.151% each). 
-- Online/digital categories show notably higher fraud rates than routine or in-person categories — consistent with card-not-present 
-- fraud being easier to commit online.





-- 3. How has fraud changed over time? (fraud count and rate by year and month)

call fraud_detection_db.sp_fraud_trend_by_month();
    
-- Fraud rates start elevated in January–February (2019: 0.963%, 1.037%) and generally decline through the year (December: 0.420%), with 2020 
-- showing a similar early-year bump. Suggests a seasonal pattern, possibly tied to post-holiday spending and new-account activity.




    
    
-- 4. Which merchants have the highest number of fraudulent transactions? (top 10 merchants by fraud count)

call fraud_detection_db.sp_top_merchants_by_fraud();

-- Fraud is spread fairly evenly across merchants — the top merchant (fraud_Kilback LLC) had only 62 fraud cases, and the top 10 range narrowly 
-- between 53–62. No single merchant dominates, suggesting fraud is systemic rather than concentrated in a few bad actors.






-- 5. Do fraudulent transactions tend to be larger or smaller than legitimate ones? (compare average, min, max transaction amount for fraud vs. non-fraud)

call fraud_detection_db.sp_avg_amount_fraud_vs_legit();

-- Legitimate transactions average $67.65 (range: $1.00–$28,948.90). Fraudulent transactions average $530.66 (range: $1.06–$1,376.04) — about 7.8x higher. 
-- Notably, fraud amounts stay within a bounded range rather than including extreme outliers, unlike legitimate transactions.






-- 6. What time of day sees the highest fraud rates? (fraud rate by hour, 0–23)

call fraud_detection_db.sp_fraud_rate_by_hour();

-- The strongest signal in the dataset. Fraud peaks sharply at 22:00 (2.601%) and 23:00 (2.546%) — roughly 15–20x higher than the safest 
-- daytime hours (most hours between 7:00–21:00 sit under 0.15%).






-- 7. Which days of the week have the highest fraud rates? (fraud rate by day of week)

call fraud_detection_db.sp_fraud_rate_by_day_of_week();

-- Highest: Friday (0.640%), Thursday (0.637%), Wednesday (0.612%). Lowest: Monday (0.402%). A milder pattern than the hourly breakdown, 
-- but midweek-to-Friday shows consistent elevation.






-- 8. Does fraud rate vary by customer age group? (fraud rate by age band)

call fraud_detection_db.sp_fraud_rate_by_age_band();

-- Highest: 56–65 (0.680%) and 65+ (0.672%). Lowest: 36–45 (0.397%). Older customers show nearly double the fraud rate of 
-- the lowest-risk age group — consistent with older cardholders being more frequent fraud/scam targets.






-- 9. Does fraud rate differ between genders? (fraud rate by gender)

call fraud_detection_db.sp_fraud_rate_by_gender();

-- Male: 0.567%. Female: 0.483%. A modest but consistent gap — male cardholders show a ~17% relatively higher fraud rate.






-- 10. Which states have the highest fraud rates? (fraud rate by state, top 10)

call fraud_detection_db.sp_fraud_rate_by_state();

-- Highest (excluding small-sample outliers): RI (2.013%), AK (1.687%), OR (0.746%), NH (0.674%), VA (0.654%), TN (0.638%). 
-- Note: DE showed a 100% fraud rate, but this is based on only 9 total transactions — a statistical outlier from an extremely small sample, 
-- not a meaningful pattern.






-- 11. Which cities have the most fraud cases in absolute terms? (top 10 cities by fraud count)

call fraud_detection_db.sp_top_cities_by_fraud();
    
-- Houston and Dallas lead with 39 fraud cases each, followed by Birmingham (36) and New York City (35). Similar to the merchant finding, 
-- city-level fraud counts are fairly evenly distributed and largely track with each city's overall transaction volume rather than showing 
-- an anomalous concentration.






-- 12. (Bonus) When during the week — combining day and hour — does fraud peak? (fraud rate by day of week × hour, useful for a heatmap visual later)

call fraud_detection_db.sp_fraud_rate_by_day_and_hour();

-- The single highest-risk window is late night on Wednesday through Saturday, specifically 22:00–23:00: Thursday 22:00 (3.267%), 
-- Friday 23:00 (3.211%), Friday 22:00 (3.050%), Thursday 23:00 (3.036%), Wednesday 22:00 (3.035%), Saturday 22:00 (2.942%). 
-- This combined view confirms and sharpens the standalone hour and day findings — the risk isn't just "late at night" or "midweek" independently, 
-- but specifically their intersection.
