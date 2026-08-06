# Customer Repurchase Timing Analysis

Analyzed 100K+ e-commerce orders (Google Cloud public dataset) to identify what actually drives repeat purchases, tested traffic source, product type, and purchase timing as candidate drivers.

## Business Question
Which customer segments and traffic sources drive repeat purchases, and where do we lose customers after their first order?

## Key Finding
Traffic source and product type do not meaningfully predict customer loyalty, repeat purchase rate is ~9-10% across all channels. The real signal is timing: median gap between 1st and 2nd purchase is 245 days (~8 months), not 30 days as commonly assumed. Even more notably, ~70% of customers never place a second order at all, meaning the biggest loss point is right after the first purchase, not somewhere later in the retention curve.

## Recommendation
Since channel and product don't explain repeat purchase behavior, the business should focus on reaching out to first-time customers over a longer period after purchase - around 2, 5, and 8 months later - rather than adjusting ad spend or product selection.

## Conclusion
The bigger opportunity isn't picking the right channel or product, it's staying in touch with customers long enough for them to come back on their own timeline.

## Dashboard
![dashboard](https://github.com/sanikavk/customer-repurchase-timing-analysis/blob/main/dashboard_screenshot.png)

## Tech Stack
|BigQuery | SQL | Google Sheets | Looker Studio|
|--|--|--|--|

## Files
```
customer-repurchase-timing-analysis/
|
|-- queries.sql                           # all 6 SQL queries
|-- business_question_and_findings.md     # full write-up of findings and proposed A/B test
|-- dashboard_screenshot.png              # final Looker Studio dashboard
```

## Dataset
Google Cloud public dataset: `bigquery-public-data.thelook_ecommerce`

