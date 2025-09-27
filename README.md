# Zomato-Sales-Analysis-Using-SQL
1.Project Overview:

This project involved the development and analysis of a structured SQL database for Zomato restaurant data. The primary objective was to create a clean, normalized dataset that supports meaningful business insights related to restaurant performance, customer preference, and market trends across different regions. Key activities included data cleaning, enrichment, transformation, and advanced SQL querying to facilitate in-depth analytics.

2.Dataset:

The dataset used in this project was sourced from Kaggle, a widely recognized platform for open data and data science competitions. It contains comprehensive information on restaurants listed on Zomato, covering various attributes such as restaurant details, location, cuisine types, pricing, customer votes, and ratings. This dataset served as the foundation for building the SQL database and conducting analytical queries.

3.Project Objectives:

- Design and implement a robust relational database schema for Zomato restaurant data.

- Address data quality challenges such as duplicate records and inconsistent entries through meticulous data cleaning.

- Enrich restaurant data by incorporating international country mappings for enhanced geographic analysis.

- Utilize analytical SQL techniques, including window functions and complex aggregations, to generate actionable insights.

- Categorize restaurants based on ratings and pricing to better understand customer segments and preferences.

4.Approach and Methodology:

- Created normalized tables Restaurants and Countries linking restaurant data with country information.

- Performed column optimization by removing irrelevant attributes, streamlining the dataset for analysis.

- Executed updates to correct misspelled city names and ensure data consistency.

- Employed LEFT JOIN operations to augment restaurant records with country names.

- Computed aggregate statistics (minimum, maximum, average) for key variables such as votes, ratings, and average cost.

- Introduced new categorical fields to classify restaurants by rating tiers, enhancing interpretability.

- Applied window functions to analyze restaurant counts over time and geography, providing trend visibility.

- Conducted focused analyses on online delivery penetration, popular cuisines, booking features, and pricing-performance correlations.

5.Challenges Encountered:

- Ensuring data integrity required careful handling of duplicates and inconsistent geographical labels.

- Managing categorical data represented as ENUM types posed challenges for numerical aggregation.

- Maintaining database performance while executing complex joins and window functions demanded optimization.

- Balancing data enrichment with query responsiveness necessitated careful schema design.

6.Business Impact and Insights:

- Identified strategic regions with high restaurant concentration, informing potential market expansion opportunities.

- Quantified the adoption rates of online delivery services across countries, supporting supply chain and logistics planning.

- Highlighted the importance of table booking facilities in improving restaurant ratings and customer satisfaction.

- Provided actionable insights into customer preferences by spotlighting popular cuisines in high-profile localities.

- Recommended optimal pricing bands that correlate with positive customer sentiment and higher restaurant votes.

7.Key Takeaways:

- SQL remains an essential tool for both foundational data management and advanced analytics in business intelligence.

- Data enrichment through external mapping accelerates comprehensive, multi-dimensional insight generation.

- Categorization of quantifiable metrics allows more nuanced understanding of customer behavior and market segmentation.

- Advanced SQL functionalities such as window functions enrich traditional aggregation methods, offering temporal and partitioned perspectives on data.

8.Future Directions:

- Integration with visualization platforms to develop interactive executive dashboards.

- Expansion of the database to include textual customer feedback and sentiment analytics.

- Development of predictive models leveraging cleaned and enriched data to forecast market trends and customer preferences.
