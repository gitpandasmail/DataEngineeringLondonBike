# DataEngineeringLondonBike

# 🚴 GENERAL INFORMATION 🚴
We are analyzing how London city bike usage is affected by weather conditions.
The goal is to determine:
* How weather impacts ride demand
* Whether temperature, rainfall, and wind influence trip duration and volume
* How weather forecasts can be used to optimize bike availability

❓ Our business questions ❓
* How much does temperature affect the number of daily and hourly bike rentals?
* How much precipitation and wind speed significantly reduce bike usage?
* Can we forecast bike demand at different stations based on upcoming weather conditions?
* Which times of day are most sensitive to weather changes in terms of bike usage?
* What is the threshold of "bad weather" beyond which bike usage drops sharply?
* How much does the weather change the average duration of rides?
* How does weather affect ebike vs bike usage?

🗂️ Our datasets 🗂️
1. London Bike-Share Usage
~700,000+ trip records in August 2023
Contains start/end timestamps, duration, station IDs, and bike type
Source: Kaggle — London Bike-Share Usage Dataset
2. Heathrow Weather Hourly Observations 
Contains temperature, wind, cloud coverage, visibility, etc with hour-level granularity
Source: CEDA UK Hourly Weather Observations
3. Heathrow Hourly Rain Data (CEDA)
Contains precipitation amount and duration with hour-level granularity
Source: CEDA UK Hourly Rain Observations

# 🦮 GUIDES 🦮
'How to run' guides are under spesific project part folders in out Github. Please check the details from there.


Container README - https://github.com/gitpandasmail/DataEngineeringLondonBike/blob/main/test_container/README.md

dbt README - https://github.com/gitpandasmail/DataEngineeringLondonBike/blob/main/andmetehnika_dbt/README.md

# Data analysis
Note: This information is added after part 3 deadline. It is to support poster presentation in case anyone wants more information
We have used following ranges to group the weather data

* Time of day effect on bike ride count and e-bike %

E-bikes are likely more popular during night time because e-bike amount in the city is likely very limited. At night time, people who ride bikes are more free to choose e-bikes as there are more available.

<img width="761" height="472" alt="image" src="https://github.com/user-attachments/assets/9992edd8-5549-4d3c-8bae-5317d98d4bb0" />

* Day of the week effect on bike rides count and e-bike %

<img width="748" height="459" alt="image" src="https://github.com/user-attachments/assets/851ba94e-7694-4c34-b2f3-cc930d562ec6" />

* Wind effect on daytime bike ride average count and e-bike rate per hour

Data is filtered by hour - includes hours 7-21. Reason - Night time has calmer winds in London and not many people ride bike during night because of the day-night-cycle,  which can give wrong understandings of how wind speed affects bike rides.

<img width="779" height="478" alt="image" src="https://github.com/user-attachments/assets/e2897386-4bbf-4c53-800f-bac0bb6e8fbf" />

* Rain effect on bike ride average count and e-bike rate per hour

<img width="750" height="467" alt="image" src="https://github.com/user-attachments/assets/893c6ba1-6bd7-4035-b94c-6e11efed66f8" />

* Hourly sunshine duration effect on daytime bike rides count and e-bike rate

Data is filtered by hour - includes hours 7-21. Reason - Night time always has 0 hours of sunshine and not many people ride bike during night because of the day-night-cycle,  which can give wrong understandings of how sunshine duration affects bike rides.

<img width="858" height="528" alt="image" src="https://github.com/user-attachments/assets/d535888b-c842-4327-9f04-ccba499c9af4" />

* Daytime hour based average temperature effect on daytime bike rides count and e-bike rate

Data is filtered by hour - includes hours 7-21. Reason - Night time has on avergae lower temperature and not many people ride bike during night because of the day-night-cycle, which can give wrong understandings of how temperature affects bike rides.

  <img width="812" height="498" alt="image" src="https://github.com/user-attachments/assets/76f27313-2e7f-4433-bb5f-0affb54d703c" />

## Data analysis details

Temperature grouping details

<img width="391" height="198" alt="image" src="https://github.com/user-attachments/assets/76aab991-ec13-4a41-bd41-580e88c9bc4c" />

Rainfall grouping details

<img width="390" height="146" alt="image" src="https://github.com/user-attachments/assets/60dde797-22ee-4e54-b3e7-483161846234" />

Wind speed grouping details

<img width="390" height="164" alt="image" src="https://github.com/user-attachments/assets/8293ea81-bb59-433f-8013-e54bb867158b" />



