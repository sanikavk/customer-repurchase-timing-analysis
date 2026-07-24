## Business Question
Which customer segments and traffic sources drive repeat purchases, and where do we lose customers after their first order?

I chose this question because repeat purchases are usually cheaper to earn than new customers, so understanding what drives someone to buy a second time has a direct, practical business impact.

## Findings

1. Traffic source does not predict loyalty

    - Search had the most frequent buyers in raw count (7,005)
    - But repeat-buyer rate (frequent buyers / total customers) was ~9-10% across all channels
    - Search only looks better due to volume, not loyalty impact

2. Product type does not predict repurchase

    - Checked products bought more than once by the same customer
    - Repurchases were rare and scattered, no category pattern
    - What's bought first doesn't predict return likelihood

3. Timing is the key signal

    - Median gap between 1st and 2nd order: 245 days (~8 months)
    - Average (~396 days) skewed by outliers, median is more reliable
    - Original assumption of a 30-day nudge doesn't match actual behavior

4. Most customers never return

    - Only ~30% of customers ever placed a 2nd order (29,829 out of 100,000)
    - The biggest single drop-off happens right after the first purchase, not gradually over time

## Recommendation

Since channel and product don't predict loyalty, but timing does, the best lever is reaching out to customers over a longer period after purchase - around 2, 5, and 8 months later - not a single quick email.

## Proposed A/B Test

- Hypothesis: Emails at ~60/150/240 days increase 2nd-purchase rate vs. no follow-up
- Primary metric: % of customers making a 2nd purchase within 300 days
- Test group: Emails at 60, 150, 240 days
- Control group: No follow-up
- Duration: 10+ months
- Decision rule: Roll out if test group shows statistically significant lift