# Airline Passenger Satisfaction - *SQL Project*

## The Data
The data for this project was downloaded from the [Maven Analytics](https://www.mavenanalytics.io) [Data Playground](https://www.mavenanalytics.io/data-playground). The dataset contained 129 thousand rows and 24 columns.  

## Inqueries

For this project, I began with a few key questions to answer.  After gaining insights into the data, I asked more specific questions based on the initial findings.  

### Key Questions
- What percentage of passengers are satisfied with their flight experience? 
- What factors affect satisfaction?
### Specific Questions
1. Why are first-time passengers mostly neutral or dissatisfied?
2. Why are passengers traveling for personal reasons mostly neutral or dissatisfied?
3. What class do passengers traveling for business flying? How does class affect satisfaction?
4. The majority of passengers aged from 40-59 are satisfied; why are the majority of passengers in all other age groups are neutral or dissatisfied?
5. How does age affect the scores of the various components of satisfaction?

**SQL Commands Used**

To answer the Key Questions, I used SQL within the Azure Data Studio and used the following commands:

`SELECT | FROM | COUNT | GROUP BY | AS | CAST | SUM | ORDER BY | CASE WHEN`  
`OVER | PARTITION BY | AVG | COMMON TABLE EXPRESSION | JOIN | WHERE`

## Insights
### Initial Exploration
**What percentage of passengers are satisfied with their flight experience?**

I began by finding the count and percentage of passengers who were or were not satisfied with their flight.
~~~SQL
SELECT Satisfaction, COUNT(*) AS Satisfaction_Count, CAST(COUNT(*) as float)*100/SUM(COUNT(*)) OVER() As Satisfaction_Percent
FROM airline_passenger_satisfaction
GROUP BY Satisfaction
~~~
Using the `GROUP BY`, `COUNT`, and combination of a few commands, it was revealed that 56,428 (43.45%) of passengers were satisfied, while the remaining 73,452 (56.55%) were neutral or dissatisfied.

**What factors affect satisfaction?**

Upon discovering that 56.55% of all passengers were neutral or dissatisfied with their experience, I decided to break that information down by demographic.  By taking the previously used code adding the Customer_Type column, and including a `PARTITION BY`, I was able to find the Satisfaction counts and percentages for both First-time and Returning passengers.
~~~SQL
SELECT Customer_Type, Satisfaction, COUNT(*) as Passenger_Count, COUNT(*)*100/CAST(SUM(COUNT(*)) OVER (PARTITION BY Customer_Type) as float) as Percent_of_Customer_Type
FROM airline_passenger_satisfaction
GROUP BY Customer_Type, Satisfaction
ORDER BY Customer_Type, Satisfaction DESC
~~~
For Returning passengers, 50,728 (47.81%) were satisfied, and 55,372 (52.19%) were neutral or dissatisfied.  Meanwhile, 5,700 (23.97%) First-time passengers were satisfied, and 18,080 (76.03%) were neutral or dissatisfied.

This method was used for other identifiying demographics of passengers: Type of Travel (Business or Personal), Class (Business, Economy, or Economy Plus), and Gender.  Some of the key findings include 36,115 (89.87%) neutral or dissatisfied passengers traveling for personal reasons, and 47,366 (81.23%) of Economy passengers and 7,092 (75.36%) of Economy Plus passengers were neutral or dissatisfied, while only 18,994 (30.56%) of buisiness passengers were neutral or dissatisfied.

To analyze the count and percent of satisfaction by age, I started by using the `COUNT`, `GROUP BY`, and `ORDER BY` commands to learn the age range of passengers and the distribution.  With this information, I created 9 bins to categorize passengers by age.  Passengers aged 30+ and over were sorted into groups of 10 years.  For those younger than 30, three more unique bins were created: Under 18, to cater to traveling minors; 18-22, for college aged flyers; and 23-29, grouping the remaining customers in their 20's.

After deciding the bins, I then utilized a similar code to what I used for the other demographics.  However, this time, for each count function, I needed to create a `CASE WHEN` to ensure the proper ages were counted.
~~~SQL
SELECT Satisfaction,
    COUNT(CASE WHEN Age<18 THEN 1 ELSE NULL END) AS Under_18_Count,
    COUNT(CASE WHEN Age<18 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Age<18 THEN 1 ELSE NULL END)) OVER () as float) AS Under_18_Percent,
    COUNT(CASE WHEN Age BETWEEN 18 AND 22 THEN 1 ELSE NULL END) AS '18-22_Count',
    COUNT(CASE WHEN Age BETWEEN 18 AND 22 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Age BETWEEN 18 AND 22 THEN 1 ELSE NULL END)) OVER () as float) AS '18-22_Percent',
    COUNT(CASE WHEN Age BETWEEN 23 AND 29 THEN 1 ELSE NULL END) AS '23-29_Count',
    COUNT(CASE WHEN Age BETWEEN 23 AND 29 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Age BETWEEN 23 AND 29 THEN 1 ELSE NULL END)) OVER () as float) AS '23-29_Percent',
    COUNT(CASE WHEN Age BETWEEN 30 AND 39 THEN 1 ELSE NULL END) AS '30-39_Count',
    COUNT(CASE WHEN Age BETWEEN 30 AND 39 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Age BETWEEN 30 AND 39 THEN 1 ELSE NULL END)) OVER () as float) AS '30-39_Percent',
    COUNT(CASE WHEN Age BETWEEN 40 AND 49 THEN 1 ELSE NULL END) AS '40-49_Count',
    COUNT(CASE WHEN Age BETWEEN 40 AND 49 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Age BETWEEN 40 AND 49 THEN 1 ELSE NULL END)) OVER () as float) AS '40-49_Percent',
    COUNT(CASE WHEN Age BETWEEN 50 AND 59 THEN 1 ELSE NULL END) AS '50-59_Count',
    COUNT(CASE WHEN Age BETWEEN 50 AND 59 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Age BETWEEN 50 AND 59 THEN 1 ELSE NULL END)) OVER () as float) AS '50-59_Percent',
    COUNT(CASE WHEN Age BETWEEN 60 AND 69 THEN 1 ELSE NULL END) AS '60-69_Count',
    COUNT(CASE WHEN Age BETWEEN 60 AND 69 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Age BETWEEN 60 AND 69 THEN 1 ELSE NULL END)) OVER () as float) AS '60-69_Percent',
    COUNT(CASE WHEN Age BETWEEN 70 AND 79 THEN 1 ELSE NULL END) AS '70-79_Count',
    COUNT(CASE WHEN Age BETWEEN 70 AND 79 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Age BETWEEN 70 AND 79 THEN 1 ELSE NULL END)) OVER () as float) AS '70-79_Percent',
    COUNT(CASE WHEN Age>79 THEN 1 ELSE NULL END) AS '80_and_over_Count',
    COUNT(CASE WHEN Age>79 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Age>79 THEN 1 ELSE NULL END)) OVER () as float) AS '80_and_over_Percent'
FROM airline_passenger_satisfaction
GROUP BY Satisfaction
~~~

!!!Satisfaction By Age, Flight Distance, Delays, Satisfaction Components 

### A Deeper Dive

## Next Steps & Future Inqueries
