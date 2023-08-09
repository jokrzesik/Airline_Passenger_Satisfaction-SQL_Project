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

SELECT | FROM | COUNT | GROUP BY | AS | CAST | SUM | ORDER BY | CASE WHEN | OVER | PARTITION BY | DISTINCT | AVG | COMMON TABLE EXPRESSION | JOIN | WHERE 

## Insights
### Initial Exploration
**What percentage of passengers are satisfied with their flight experience?**

I began by finding the count and percentage of passengers who were or were not satisfied with their flight.
*Insert SQL Image*
Using the GROUP BY, COUNT, and combination of a few commands, it was revealed that 56,428 (43.45%) of passengers were satisfied, while the remaining 73,452 (56.55%) were neutral or dissatisfied.

**What factors affect satisfaction?**

Upon discovering that 56.55% of all passengers were neutral or dissatisfied with their experience, I decided to break that information down by demographic.  By taking the previously used code adding the Customer_Type column, and including a PARTITION BY, I was able to find the Satisfaction counts and percentages for both First-time and Returning passengers.
*Insert SQL Image*
For Returning passengers, 50,728 (47.81%) were satisfied, and 55,372 (52.19%) were neutral or dissatisfied.  Meanwhile, 5,700 (23.97%) First-time passengers were satisfied, and 18,080 (76.03%) were neutral or dissatisfied.

This method was used for other identifiying demographics of passengers: Type of Travel (Business or Personal), Class (Business, Economy, or Economy Plus), and Gender.

!!!Distinct & Count to find ages & create groups

!!!Satisfaction By Age, Flight Distance, Delays, Satisfaction Components 

### A Deeper Dive

## Next Steps & Future Additions
