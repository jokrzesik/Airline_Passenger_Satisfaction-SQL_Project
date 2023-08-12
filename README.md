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
3. What class are passengers traveling for business flying? How does class affect satisfaction?
4. What relationship exists between flight class and satisfaction?
5. The majority of passengers aged from 40-59 are satisfied; why are the majority of passengers in all other age groups are neutral or dissatisfied?
6. How does age affect the scores of the various components of satisfaction?

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

This method was used for other identifiying demographics of passengers: Type of Travel (Business or Personal), Class (Business, Economy, or Economy Plus), and Gender.  Some of the key findings include 36,115 (89.87%) neutral or dissatisfied passengers traveling for personal reasons, and 47,366 (81.23%) of Economy passengers and 7,092 (75.36%) of Economy Plus passengers were neutral or dissatisfied, while only 18,994 (30.56%) of Buisiness Class passengers were neutral or dissatisfied.

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
*Table of Satisfaction by Age Group*
|Satisfaction|Under_18_Count|Under_18_Percent|18-22_Count|18-22_Percent|23-29_Count|23-29_Percent|30-39_Count|30-39_Percent|40-49_Count|40-49_Percent|50-59_Count|50-59_Percent|60-69_Count|60-69_Percent|70-79_Count|70-79_Percent|80_and_over_Count|80_and_over_Percent|
|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|---|
|Neutral or Dissatisfied|8200|83.27409363257846|6129|67.76868642193719|12444|63.92027943291556|15091|58.71070650482415|12437|41.965852341746526|10242|42.735542017858634|7563|72.13161659513591|1248|78.24451410658307|98|72.5925925925926|
|Satisfied|1647|16.72590636742155|2915|32.2313135780628|7024|36.07972056708444|10613|41.28929349517585|17199|58.034147658253474|13724|57.264457982141366|2922|27.86838340486409|347|21.755485893416928|37|27.40740740740741|

The results of the query revealed that the majority of age groups, with the exception of 40-59, were neutral or dissatisfied with their flight.  

A similar set of commands was used to compare Satisfaction with Flight Distance.
~~~SQL
SELECT Satisfaction,
    COUNT(CASE WHEN Flight_Distance < 500 THEN 1 ELSE NULL END) AS Under_500_Count,
    COUNT(CASE WHEN Flight_Distance < 500 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Flight_Distance < 500 THEN 1 ELSE NULL END)) OVER () as float) AS Under_500_Percent,
    COUNT(CASE WHEN Flight_Distance BETWEEN 500 AND 999 THEN 1 ELSE NULL END) AS '500-999_Count',
    COUNT(CASE WHEN Flight_Distance BETWEEN 500 AND 999 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Flight_Distance BETWEEN 500 AND 999 THEN 1 ELSE NULL END)) OVER () as float) AS '500-999_Percent',
    COUNT(CASE WHEN Flight_Distance BETWEEN 1000 AND 1999 THEN 1 ELSE NULL END) AS '1000-1999_Count',
    COUNT(CASE WHEN Flight_Distance BETWEEN 1000 AND 1999 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Flight_Distance BETWEEN 1000 AND 1999 THEN 1 ELSE NULL END)) OVER () as float) AS '1000-1999_Percent',
    COUNT(CASE WHEN Flight_Distance BETWEEN 2000 AND 2999 THEN 1 ELSE NULL END) AS '2000-2999_Count',
    COUNT(CASE WHEN Flight_Distance BETWEEN 2000 AND 2999 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Flight_Distance BETWEEN 2000 AND 2999 THEN 1 ELSE NULL END)) OVER () as float) AS '2000-2999_Percent',
    COUNT(CASE WHEN Flight_Distance >= 3000 THEN 1 ELSE NULL END) AS '3000+_Count',
    COUNT(CASE WHEN Flight_Distance >= 3000 THEN 1 ELSE NULL END)*100/CAST(SUM(COUNT(CASE WHEN Flight_Distance >= 3000 THEN 1 ELSE NULL END)) OVER () as float) AS '3000+_Percent'
FROM airline_passenger_satisfaction
GROUP BY Satisfaction
~~~
*Table of Satisfaction by Flight Distance*
|Satisfaction|Under_500_Count|Under_500_Percent|500-999_Count|500-999_Percent|1000-1999_Count|1000-1999_Percent|2000-2999_Count|2000-2999_Percent|3000+_Count|3000+_Percent|
|---|---|---|---|---|---|---|---|---|---|---|
|Neutral or Dissatisfied|26629|66.45288480734678|23630|67.48150898135191|15055|53.94123969903261|5800|35.03684909991543|2338|22.639682385978503|
|Satisfied|13443|33.54711519265322|11387|32.518491018648085|12855|46.05876030096739|10754|64.96315090008457|7989|77.3603176140215|

This showed how the majority of passengers flying less than 2000 miles were neutral or dissatisfied, while the majority of those flying 2000 or more were satisfied with their experience.

The next queries compared Satisfaction with Departure and Arrival Delays.  Using `COUNT` and `AVG` paired with a `CASE WHEN` in the `GROUP BY`, I was able to determine find the number of delays and average delay length sorted by satisfaction.  The example below uses Departure Delays.
~~~SQL
SELECT Satisfaction,
    COUNT(*) AS Departure_Delays_Count,
    AVG(CAST(Departure_Delay AS decimal(10,2))) AS Avg_Departure_Time_Delay
FROM airline_passenger_satisfaction
GROUP BY Satisfaction, (CASE WHEN Departure_Delay > 0 THEN 1 ELSE NULL END)
~~~
Findings showed that off the satisfied passengers, 21,772 experienced a delay and 34,656 had no delay.  Of the neutral or dissatisfied passengers, 34,962 experienced a delay and 38,490 had no delay. The average delay (factoring out on-time flights) was 32.38 minutes for satisfied passengers and 35.72 for neutral or dissatisfied.  The results for Arrival Delay were similar to that of Departure Delay.

Lastly, I explored the ratings of different satisfaction components by passengers.  This method mostly used the `AVG` command as well as the `GROUP BY` to divide the ratings by Satisfaction.  Ratings were based on a scale of 0-5, with 0 being not applicable and 5 being the highest.  All 0 ratings were converted to `NULL` to be kept out of calculations.
~~~SQL
SELECT Satisfaction,
    AVG([Departure_and_Arrival_Time_Convenience]+[Ease_of_Online_Booking]+
    [Check_in_Service]+[Online_Boarding]+[Gate_Location]+[On_board_Service]+[Seat_Comfort]+
    [Leg_Room_Service]+[Cleanliness]+[Food_and_Drink]+[In_flight_Service]+[In_flight_Wifi_Service]+
    [In_flight_Entertainment]+[Baggage_Handling])/14 AS Overall_Satisfaction_Score,
    AVG(CAST([Departure_and_Arrival_Time_Convenience] as decimal(4,2))) as Avg_Dep_and_Arr_Time_Convenience,
    AVG(CAST([Ease_of_Online_Booking] as decimal(4,2))) AS Avg_Ease_of_Online_Booking,
    AVG(CAST([Check_in_Service] as decimal(4,2))) AS Avg_Check_in_Service,
    AVG(CAST([Online_Boarding] as decimal(4,2))) AS Avg_Online_Boarding,
    AVG(CAST([Gate_Location] as decimal(4,2))) AS Avg_Gate_Location,
    AVG(CAST([On_board_Service] as decimal(4,2))) AS Avg_On_board_Service,
    AVG(CAST([Seat_Comfort] as decimal(4,2))) AS Avg_Seat_Comfort,
    AVG(CAST([Leg_Room_Service] as decimal(4,2))) AS Avg_Leg_Room_Service,
    AVG(CAST([Cleanliness] as decimal(4,2))) AS Avg_Cleanliness,
    AVG(CAST([Food_and_Drink] as decimal(4,2))) AS Avg_Food_and_Drink,
    AVG(CAST([In_flight_Service] as decimal(4,2))) AS Avg_In_flight_Service,
    AVG(CAST([In_flight_Wifi_Service] as decimal(4,2))) AS Avg_In_flight_Wifi_Service,
    AVG(CAST([In_flight_Entertainment] as decimal(4,2))) AS Avg_In_flight_Entertainment,
    AVG(CAST([Baggage_Handling] as decimal(4,2))) AS Avg_Baggage_Handling
FROM airline_passenger_satisfaction
GROUP BY Satisfaction
~~~
Examinining the created table naturally showed higher ratings for satisfied customers and lower ones for neutral or dissatisfied.  The averages showed that satified customers provided an overall 3.70 rating, while neutral or dissatisfied customers provided an overall 2.97. However, a few categories showed more extreme differences.  Online Boarding was rated 2.71 on average by neutral or dissatisfied customers and 4.15 for satisfied.  In Flight Wifi Service was rated 2.40 by neutral or dissatisfied customers and 3.39 by satisfied.  It should also noted that while Departure and Arrival Time Convenience as well as Gate Location actually scored higher by neutral or dissatisfied customers, the numbers were fairly close together (3.29 and 3.14 for Convenience; 2.98 and 2.97 for Location).  

### A Deeper Dive
After compliting the queries and gaining insight based on my initial questions, I found myself asking some more questions wanting to gain a better understanding of the relationships of the various demographics and satisfaction components. Below are the futher questions that I explored.

**1. Why are first-time passengers mostly neutral or dissatisfied?**  
To answer this question, I looked at different data comparisons all filtered to First-time passengers.  I began by checking the satisfaction component averages, sorted by satisfaction.
~~~SQL
SELECT Customer_Type, Satisfaction,
    AVG([Departure_and_Arrival_Time_Convenience]+[Ease_of_Online_Booking]+[Check_in_Service]+[Online_Boarding]+[Gate_Location]+[On_board_Service]+[Seat_Comfort]+[Leg_Room_Service]+[Cleanliness]+[Food_and_Drink]+[In_flight_Service]+[In_flight_Wifi_Service]+[In_flight_Entertainment]+[Baggage_Handling])/14 AS Overall_Satisfaction_Score,
    AVG(CAST([Departure_and_Arrival_Time_Convenience] as decimal(4,2))) AS Avg_Dep_and_Arr_Time_Convenience,
    AVG(CAST([Ease_of_Online_Booking] as decimal(4,2))) AS Avg_Ease_of_Online_Booking,
    AVG(CAST([Check_in_Service] as decimal(4,2))) AS Avg_Check_in_Service,
    AVG(CAST([Online_Boarding] as decimal(4,2))) AS Avg_Online_Boarding,
    AVG(CAST([Gate_Location] as decimal(4,2))) AS Avg_Gate_Location,
    AVG(CAST([On_board_Service] as decimal(4,2))) AS Avg_On_board_Service,
    AVG(CAST([Seat_Comfort] as decimal(4,2))) AS Avg_Seat_Comfort,
    AVG(CAST([Leg_Room_Service] as decimal(4,2))) AS Avg_Leg_Room_Service,
    AVG(CAST([Cleanliness] as decimal(4,2))) AS Avg_Cleanliness,
    AVG(CAST([Food_and_Drink] as decimal(4,2))) AS Avg_Food_and_Drink,
    AVG(CAST([In_flight_Service] as decimal(4,2))) AS Avg_In_flight_Service,
    AVG(CAST([In_flight_Wifi_Service] as decimal(4,2))) AS Avg_In_flight_Wifi_Service,
    AVG(CAST([In_flight_Entertainment] as decimal(4,2))) AS Avg_In_flight_Entertainment,
    AVG(CAST([Baggage_Handling] as decimal(4,2))) AS Avg_Baggage_Handling
FROM airline_passenger_satisfaction
WHERE Customer_Type = 'First-time'
GROUP BY Satisfaction, Customer_Type
~~~
It showed that while the overall average for satisfied and neutral or dissatisfied passengers remained constant, specific components became more polarized.  For example, Departure and Arrival Time Convenience (which was nearly equal between satisfaction groups as a whole) was rated 4.06 by satisfied passenters and 2.61 by neutral or dissatisfied.  Similar effects were observed in Online Boarding and In Flight Wifi Service.

Next, I investigated First-time passengers' satisfaction rates in terms of Departure and Arrival Delay using a similar code to what I used earlier when looking at Delays.
~~~SQL
SELECT Type_of_Travel, (CASE WHEN Departure_Delay = 0 THEN 'No Delay' WHEN Departure_Delay > 0 THEN 'Delay' END) AS Flight_Delayed,
    Satisfaction, COUNT(*) AS Count,
    AVG(CASE WHEN Departure_Delay > 0 THEN CAST(Departure_Delay AS decimal(10,2)) ELSE NULL END) AS Avg_Departure_Time_Delay
FROM airline_passenger_satisfaction
WHERE Type_of_Travel = 'Personal'
GROUP BY Type_of_Travel, (CASE WHEN Departure_Delay = 0 THEN 'No Delay' WHEN Departure_Delay > 0 THEN 'Delay' END), Satisfaction
~~~
The overall difference in delays for satisfied and neutral or dissatisfied customers was within a few minutes.  When filtered for First-time customers, the gap was a little less than 4 minutes for Departure Delays, and a little over 2 minutes for Arrivals; not much of a change from the overall.

The final examination at First-time passenger experience involved flight distance.  To do this, I required the use of `COMMON TABLE EXPRESSION`, `JOIN`, `WHERE`, `GROUP BY`, and `ORDER BY`.  
~~~SQL
WITH
    temp
    AS
    (
        SELECT ID, (CASE WHEN Flight_Distance <500 THEN 'Under_500_Miles' 
    WHEN Flight_Distance BETWEEN 500 AND 999 THEN '500-999_Miles'
    WHEN Flight_Distance BETWEEN 1000 AND 1999 THEN '1000-1999_Miles'
    WHEN Flight_Distance BETWEEN 2000 AND 2999 THEN '2000-2999_Miles'
    WHEN Flight_Distance >= 3000 THEN '3000+_Miles' END) AS Flight_Distance_Range
        FROM airline_passenger_satisfaction
    )
SELECT Customer_Type, Satisfaction, temp.Flight_Distance_Range, COUNT(*) AS Count
FROM airline_passenger_satisfaction
    JOIN temp
    ON airline_passenger_satisfaction.ID = temp.ID
WHERE Customer_Type = 'First-time'
GROUP BY Customer_Type, Satisfaction, temp.Flight_Distance_Range
ORDER BY (CASE WHEN temp.Flight_Distance_Range = 'Under_500_Miles' THEN 1 WHEN temp.Flight_Distance_Range = '500-999_Miles' THEN 2 WHEN temp.Flight_Distance_Range = '1000-1999_Miles' THEN 3 WHEN temp.Flight_Distance_Range = '2000-2999_Miles' THEN 4 ELSE 5 END), Satisfaction
~~~
This query, however, did not show any unusual patterns, as the ratios of satisfied to neutral or dissatisfied passengers were similar across each age bracket.    

**2. Why are passengers traveling for personal reasons mostly neutral or dissatisfied?**  
My approach to understanding this questions was the same as when examining satifsaction of First-time passengers.  I used the same set of codes, only switching out Customer Type for Type of Travel.  Many of the patterns and insights from First-time passengers' satisfaction held true with those flying for personal reasons.  Nearly all of the ratings of satisfaction components were the same, except for Online Booking, Online Boarding, and In Flight Wifi Service, which all scored much higher for satisfied passengers than neutral or dissatisfied ones.  Regarding delays, neutral or dissatisfied Personal passengers experienced nearly 12 minute longer Departure Delays on average than satisfied passengers; in terms of Arrivals, the difference was over 9 minutes, still far greater than the overall average.  There was no change in satisfaction observed for Personal passengers when accounting for Flight Distance.  
  
**3. What class are passengers traveling for business flying? How does class affect satisfaction?**  
Two queries gave insight to these questions.  The first query used `WHERE` to filter for Buisness travelers, `GROUP BY` to sort by class, and `COUNT` to provide number and percentage.
~~~SQL
SELECT Type_of_Travel, Class, COUNT(*) Count, COUNT(*)*100/CAST(SUM(COUNT(*)) OVER () as float) AS Percentage
FROM airline_passenger_satisfaction
WHERE Type_of_Travel = 'Business'
GROUP BY Type_of_Travel, Class
~~~
The result showed that 66.32% flew Business Class, 28.21% flew Economy, and 5.57% flew Economy Plus.
I continued by using the same code but adding Satisfaction to the mix.  It revealed that the wide majority of passengers traveling for business seated in business class were satisfied with the experience.  However, the majority of those flying Economy or Economy Plus were neutral or dissatisfied.  These results peaked my interest since as a whole Business travelers were satisfied 58.37% of the time. This led me to ask the next question in my exploration.  

**4. What relationship exists between flight class and satisfaction?**

**5. The majority of passengers aged from 40-59 are satisfied; why are the majority of passengers in all other age groups are neutral or dissatisfied?**


**6. How does age affect the scores of the various components of satisfaction?**




## Next Steps & Future Inqueries
