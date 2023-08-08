-- SELECT * FROM airline_passenger_satisfaction

-- Total Reviews

SELECT COUNT(*) as Total_Reviews FROM airline_passenger_satisfaction

-- Count and Percent of First-Time and Returning Customers

SELECT Customer_Type, COUNT(*) as Customer_Type_Count, COUNT(*)*100/CAST(SUM(COUNT(*)) OVER() as float) AS Customer_Type_Percent FROM airline_passenger_satisfaction
GROUP BY Customer_Type


-- Count and Percent of Type_of_Travel

SELECT Type_of_Travel, COUNT(*) as Type_of_Travel_Count, COUNT(*)*100/CAST(SUM(COUNT(*)) OVER () as float) AS Percent_of_Type_of_Travel FROM airline_passenger_satisfaction
GROUP BY Type_of_Travel
ORDER BY Type_of_Travel

-- Count of Customer and Travel Type

SELECT Customer_Type, Type_of_Travel, COUNT(*) AS Type_count, COUNT(*)*100/CAST(SUM(COUNT(*)) OVER() as float) AS Type_Percent
FROM airline_passenger_satisfaction
GROUP BY Customer_Type, Type_of_Travel
ORDER BY Customer_Type

--*** WHAT PERCENTAGE OF PASSENGERS ARE SATISFIED? WHAT FACTORS AFFECT SATISFACTION? ***

-- Satisfaction Count and Percent

SELECT Satisfaction, COUNT(*) AS Satisfaction_Count, CAST(COUNT(Satisfaction) as decimal(10,2))*100/129880 As Satisfaction_Percent FROM airline_passenger_satisfaction
GROUP BY Satisfaction


-- Satisfaction Count and Percent by First-time or Returning Customers

SELECT Customer_Type, Satisfaction, COUNT(*) as Passenger_Count, COUNT(*)*100/CAST(SUM(COUNT(*)) OVER (PARTITION BY Customer_Type) as float) as Percent_of_Customer_Type FROM airline_passenger_satisfaction
GROUP BY Customer_Type, Satisfaction
ORDER BY Customer_Type, Satisfaction DESC


-- Satisfaction Count and Percent by Travel Type

SELECT Type_of_Travel, Satisfaction, COUNT(*) as Type_of_Travel_Count, COUNT(*)*100/CAST(SUM(COUNT(*)) OVER (PARTITION BY Type_of_Travel) as float) as Percent_of_Type_of_Travel FROM airline_passenger_satisfaction
GROUP BY Type_of_Travel, Satisfaction
ORDER BY Type_of_Travel, Satisfaction DESC


-- Satisfaction Count and Percent by Flight Class

SELECT Class, Satisfaction, COUNT(*) as Class_Count, COUNT(*)*100/CAST(SUM(COUNT(*)) OVER (PARTITION BY Class) as float) as Percent_of_Class FROM airline_passenger_satisfaction
GROUP BY Class, Satisfaction
ORDER BY Class, Satisfaction DESC


-- Satisfaction Count and Percent by Gender

SELECT Gender, Satisfaction, COUNT(*) as Gender_Count, COUNT(*)*100/CAST(SUM(COUNT(*)) OVER (PARTITION BY Gender) as float) as Percent_of_Gender FROM airline_passenger_satisfaction
GROUP BY Gender, Satisfaction
ORDER BY Gender, Satisfaction DESC


-- Satisfaction by Age Group
  -- Age Groups: Under 18, 18-22, 23-29, 30-39, 40-49, 50-59, 60-69, 70-79, 80+

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


-- Satisfaction by Departure_Delays Count and Average Time

SELECT Satisfaction,
COUNT(CASE WHEN Departure_Delay > 0 THEN 1 ELSE NULL END) AS Departure_Delays_Count,
AVG(CASE WHEN Departure_Delay > 0 THEN CAST(Departure_Delay AS decimal(10,2)) ELSE NULL END) AS Avg_Departure_Time_Delay
FROM airline_passenger_satisfaction
GROUP BY Satisfaction


-- Satisfaction by Arrival_Delays Count and Average Time

SELECT Satisfaction,
COUNT(CASE WHEN Arrival_Delay > 0 THEN 1 ELSE NULL END) AS Arrival_Delays_Count,
AVG(CASE WHEN Arrival_Delay > 0 THEN CAST(Arrival_Delay AS decimal(10,2)) ELSE NULL END) AS Avg_Arrival_Time_Delay
FROM airline_passenger_satisfaction
GROUP BY Satisfaction


-- Overall Satisfaction compared with Satisfaction Elements

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


-- Satisfaction by Flight Distance Count and Percent

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


--*** WHY ARE FIRST-TIME PASSENGERS MOSTLY NEUTRAL OR DISSATISFIED?

--First-time Passengers' Satisfaction and Satisfaction Element

SELECT Customer_Type, Satisfaction,
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
WHERE Customer_Type = 'First-time'
GROUP BY Satisfaction, Customer_Type


--How does Departure Delay affect First-Time Passenger Satisfaction?

SELECT Customer_Type, (CASE WHEN Departure_Delay = 0 THEN 'No Delay' WHEN Departure_Delay > 0 THEN 'Delay' END) AS Flight_Delayed,
Satisfaction, COUNT(*) AS Count,
AVG(CASE WHEN Departure_Delay > 0 THEN CAST(Departure_Delay AS decimal(10,2)) ELSE NULL END) AS Avg_Departure_Time_Delay
FROM airline_passenger_satisfaction
WHERE Customer_Type = 'First-time'
GROUP BY Customer_Type, (CASE WHEN Departure_Delay = 0 THEN 'No Delay' WHEN Departure_Delay > 0 THEN 'Delay' END), Satisfaction


--How does Arrival Delay affect First-Time Passenger Satisfaction?

SELECT Customer_Type, (CASE WHEN Arrival_Delay > 0 THEN 'Late' ELSE 'On Time' END) AS Arrival_Delayed,
Satisfaction, COUNT(*) AS Count,
AVG(CASE WHEN Arrival_Delay > 0 THEN CAST(Arrival_Delay AS decimal(10,2)) ELSE NULL END) AS Avg_Arrival_Time_Delay
FROM airline_passenger_satisfaction
WHERE Customer_Type = 'First-time'
GROUP BY Customer_Type, (CASE WHEN Arrival_Delay > 0 THEN 'Late' ELSE 'On Time' END), Satisfaction;


--How does flight distance affect First-Time Passenger Satisfaction?

WITH temp AS (
    SELECT ID, (CASE WHEN Flight_Distance <500 THEN 'Under_500_Miles' 
    WHEN Flight_Distance BETWEEN 500 AND 999 THEN '500-999_Miles'
    WHEN Flight_Distance BETWEEN 1000 AND 1999 THEN '1000-1999_Miles'
    WHEN Flight_Distance BETWEEN 2000 AND 2999 THEN '2000-2999_Miles'
    WHEN Flight_Distance >= 3000 THEN '3000+_Miles' END) AS Flight_Distance_Range
    FROM airline_passenger_satisfaction)
SELECT Customer_Type, Satisfaction, temp.Flight_Distance_Range, COUNT(*) AS Count 
FROM airline_passenger_satisfaction
JOIN temp
ON airline_passenger_satisfaction.ID = temp.ID
WHERE Customer_Type = 'First-time'
GROUP BY Customer_Type, Satisfaction, temp.Flight_Distance_Range
ORDER BY (CASE WHEN temp.Flight_Distance_Range = 'Under_500_Miles' THEN 1 WHEN temp.Flight_Distance_Range = '500-999_Miles' THEN 2 WHEN temp.Flight_Distance_Range = '1000-1999_Miles' THEN 3 WHEN temp.Flight_Distance_Range = '2000-2999_Miles' THEN 4 ELSE 5 END), Satisfaction


-- *** WHY ARE PERSONAL (Type_of_Travel) PASSENGERS MOSTLY DISSATISFIED?

--Personal Passengers' Satisfaction and Satisfaction Element

SELECT Type_of_Travel, Satisfaction,
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
WHERE Type_of_Travel = 'Personal'
GROUP BY Satisfaction, Type_of_Travel


--How does Departure Delay affect Personal Passenger Satisfaction?

SELECT Type_of_Travel, (CASE WHEN Departure_Delay = 0 THEN 'No Delay' WHEN Departure_Delay > 0 THEN 'Delay' END) AS Flight_Delayed,
Satisfaction, COUNT(*) AS Count,
AVG(CASE WHEN Departure_Delay > 0 THEN CAST(Departure_Delay AS decimal(10,2)) ELSE NULL END) AS Avg_Departure_Time_Delay
FROM airline_passenger_satisfaction
WHERE Type_of_Travel = 'Personal'
GROUP BY Type_of_Travel, (CASE WHEN Departure_Delay = 0 THEN 'No Delay' WHEN Departure_Delay > 0 THEN 'Delay' END), Satisfaction


--How does Arrival Delay affect Personal Passenger Satisfaction?

SELECT Type_of_Travel, (CASE WHEN Arrival_Delay > 0 THEN 'Late' ELSE 'On Time' END) AS Arrival_Delayed,
Satisfaction, COUNT(*) AS Count,
AVG(CASE WHEN Arrival_Delay > 0 THEN CAST(Arrival_Delay AS decimal(10,2)) ELSE NULL END) AS Avg_Arrival_Time_Delay
FROM airline_passenger_satisfaction
WHERE Type_of_Travel = 'Personal'
GROUP BY Type_of_Travel, (CASE WHEN Arrival_Delay > 0 THEN 'Late' ELSE 'On Time' END), Satisfaction;


--How does flight distance affect First-Time Passenger Satisfaction?

WITH temp AS (
    SELECT ID, (CASE WHEN Flight_Distance <500 THEN 'Under_500_Miles' 
    WHEN Flight_Distance BETWEEN 500 AND 999 THEN '500-999_Miles'
    WHEN Flight_Distance BETWEEN 1000 AND 1999 THEN '1000-1999_Miles'
    WHEN Flight_Distance BETWEEN 2000 AND 2999 THEN '2000-2999_Miles'
    WHEN Flight_Distance >= 3000 THEN '3000+_Miles' END) AS Flight_Distance_Range
    FROM airline_passenger_satisfaction)
SELECT Type_of_Travel, Satisfaction, temp.Flight_Distance_Range, COUNT(*) AS Count 
FROM airline_passenger_satisfaction
JOIN temp
ON airline_passenger_satisfaction.ID = temp.ID
WHERE Type_of_Travel = 'Personal'
GROUP BY Type_of_Travel, Satisfaction, temp.Flight_Distance_Range
ORDER BY (CASE WHEN temp.Flight_Distance_Range = 'Under_500_Miles' THEN 1 WHEN temp.Flight_Distance_Range = '500-999_Miles' THEN 2 WHEN temp.Flight_Distance_Range = '1000-1999_Miles' THEN 3 WHEN temp.Flight_Distance_Range = '2000-2999_Miles' THEN 4 ELSE 5 END), Satisfaction


-- ** WHAT CLASS ARE BUSINESS PASSENGERS (Type_of_Travel) FLYING? HOW DOES THAT AFFECT SATISFACTION?

-- Count of Business Passengers Seat Class by Satisfaction

SELECT Type_of_Travel, Class, Satisfaction, COUNT(*) AS Count
FROM airline_passenger_satisfaction
WHERE Type_of_Travel = 'Business'
GROUP BY Type_of_Travel, Satisfaction, Class


---*** WHAT RELATIONSHIP EXISTS BETWEEN CLASS AND SATISFACTION?

--Count Satisfaction by Class

SELECT Class, Satisfaction, COUNT(*) AS Count
FROM airline_passenger_satisfaction
GROUP BY Class, Satisfaction
ORDER BY Class

--Economy Class Satisfaction Elements by Type of Travel

SELECT Class, Satisfaction, Type_of_Travel,
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
WHERE Class = 'Economy'
GROUP BY Class, Satisfaction, Type_of_Travel
ORDER BY Type_of_Travel


--Economy Plus Class Satisfaction Elements by Type of Travel

SELECT Class, Satisfaction, Type_of_Travel,
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
WHERE Class = 'Economy Plus'
GROUP BY Class, Satisfaction, Type_of_Travel
ORDER BY Type_of_Travel


--Business Class Satisfaction Elements by Type of Travel

SELECT Class, Satisfaction, Type_of_Travel,
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
WHERE Class = 'Business'
GROUP BY Class, Satisfaction, Type_of_Travel
ORDER BY Type_of_Travel


--*** AGE RANGES FROM 40-59 HAVE OVER 50% OF CUSTOMERS SATISFIED, VERY DIFFERENT THAN ANY OTHER AGE GROUP; WHY?

-- Satisfaction Count broken into age brackets

WITH temp AS( 
    SELECT (CASE WHEN Age<18 THEN 'Under_18'
    WHEN Age BETWEEN 18 AND 22 THEN '18-22'
    WHEN Age BETWEEN 23 AND 29 THEN '23-29' 
    WHEN Age BETWEEN 30 AND 39 THEN '30-39' 
    WHEN Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN Age BETWEEN 50 AND 59 THEN '50-59'
    WHEN Age BETWEEN 60 AND 69 THEN '60-69' 
    WHEN Age BETWEEN 70 AND 79 THEN '70-79'
    WHEN Age>79 THEN '80_and_over' END) AS Age_Bracket, ID 
    FROM airline_passenger_satisfaction
    )
SELECT temp.Age_Bracket, Satisfaction, COUNT(*) as Count 
FROM airline_passenger_satisfaction
JOIN temp
ON temp.ID = airline_passenger_satisfaction.ID
GROUP BY temp.Age_Bracket, Satisfaction
ORDER BY temp.Age_Bracket, Satisfaction


--Count of Flight Class by Age bracket

WITH temp AS( 
    SELECT (CASE WHEN Age<18 THEN 'Under_18'
    WHEN Age BETWEEN 18 AND 22 THEN '18-22'
    WHEN Age BETWEEN 23 AND 29 THEN '23-29' 
    WHEN Age BETWEEN 30 AND 39 THEN '30-39' 
    WHEN Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN Age BETWEEN 50 AND 59 THEN '50-59'
    WHEN Age BETWEEN 60 AND 69 THEN '60-69' 
    WHEN Age BETWEEN 70 AND 79 THEN '70-79'
    WHEN Age>79 THEN '80_and_over' END) AS Age_Bracket, ID 
    FROM airline_passenger_satisfaction
    )
SELECT temp.Age_Bracket, Class, COUNT(*) as Count 
FROM airline_passenger_satisfaction
JOIN temp
ON temp.ID = airline_passenger_satisfaction.ID
GROUP BY temp.Age_Bracket, Class
ORDER BY (
    CASE WHEN temp.Age_Bracket = 'Under_18' THEN 1
    WHEN temp.Age_Bracket = '18-22' THEN 2
    WHEN temp.Age_Bracket = '23-29' THEN 3
    WHEN temp.Age_Bracket = '30-39' THEN 4
    WHEN temp.Age_Bracket = '40-49' THEN 5
    WHEN temp.Age_Bracket = '50-59' THEN 6
    WHEN temp.Age_Bracket = '60-69' THEN 7
    WHEN temp.Age_Bracket = '70-79' THEN 8
    WHEN temp.Age_Bracket = '80_and_over' THEN 9 END), 
    Class


---*** DOES AGE AFFECT SATISFACTION ELEMENT SCORES?

--Satisfaction Element Scores By Age Bracket and Satisfaction

WITH temp AS( 
    SELECT (CASE WHEN Age<18 THEN 'Under_18'
    WHEN Age BETWEEN 18 AND 22 THEN '18-22'
    WHEN Age BETWEEN 23 AND 29 THEN '23-29' 
    WHEN Age BETWEEN 30 AND 39 THEN '30-39' 
    WHEN Age BETWEEN 40 AND 49 THEN '40-49'
    WHEN Age BETWEEN 50 AND 59 THEN '50-59'
    WHEN Age BETWEEN 60 AND 69 THEN '60-69' 
    WHEN Age BETWEEN 70 AND 79 THEN '70-79'
    WHEN Age>79 THEN '80_and_over' END) AS Age_Bracket, ID 
    FROM airline_passenger_satisfaction
    )
SELECT temp.Age_Bracket, Satisfaction, 
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
JOIN temp
ON temp.ID = airline_passenger_satisfaction.ID
GROUP BY temp.Age_Bracket, Satisfaction
ORDER BY Satisfaction, (
    CASE WHEN temp.Age_Bracket = 'Under_18' THEN 1
    WHEN temp.Age_Bracket = '18-22' THEN 2
    WHEN temp.Age_Bracket = '23-29' THEN 3
    WHEN temp.Age_Bracket = '30-39' THEN 4
    WHEN temp.Age_Bracket = '40-49' THEN 5
    WHEN temp.Age_Bracket = '50-59' THEN 6
    WHEN temp.Age_Bracket = '60-69' THEN 7
    WHEN temp.Age_Bracket = '70-79' THEN 8
    WHEN temp.Age_Bracket = '80_and_over' THEN 9 END)


-- Next explorations: 
    --Why are passengers more neutral or dissatisfied on shorter flights? (Under 2000 miles)
    --What are the satisfaction priorities of different customer profiles?