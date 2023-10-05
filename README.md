# Hotel-Data-SMSS-and-Power-BI
Used SQL Server Management Studio (SMSS) to generate databases and SQL queries to enable data-based decision-making using 'real' business problems and proposals to generate insight. Designed a comprehensive business dashboard tailored to address key inquiries in the hospitality industry. This dynamic dashboard efficiently answers critical business questions, including:

* #### Year-over-Year Growth: Analyzing the hotel's performance over time, deciphering trends, and pinpointing growth opportunities.

* #### Top Performing Hotel Categories: Identifying the most lucrative hotel types, enabling strategic investments and marketing efforts.

* #### Optimizing Parking Spaces: Determining if an increase in parking spaces is necessary due to heightened customer demand, ensuring a seamless experience for our guests.

* #### Uncovering Unique Insights: Delving into the data to extract uncommon and commercially relevant insights, providing a competitive edge in the market.

Key Skills:

Data Analysis: Proficiency in extracting, cleaning, and analyzing data sets to reveal meaningful patterns and trends to answer relevant data-driven business questions.
Visualization: Skilled in creating visually appealing and easy-to-understand dashboards using industry-leading tools (Power BI).

## Data Collection
### Analysis of Hotel Booking Data
The data was provided in the form of a cleaned, Excel worksheet sourced from an openly sourced hotel booking database. The goal of this project was to build a visual story using SQL Server Management Studio (SSMS) and Power BI to build a visual dashboard to answer specific business questions. 

The pipeline for this project began with establishing the software on my device and downloading this to the specifications of the program. SSMS was used as the SQL querying program to further broaden my skill set. This did not come without issues as the installation of the program was littered with troubleshooting specific error codes and establishing issues with the installation. Much of the issues were due to the SQL server being freshly installed on my device, calling for me to personalize the install and connection settings with the virtual SQL server using the newer SQL Server 2022 framework which operates slightly differently than the video I was using to guide this project.

Furthermore, once SSMS was installed the database was created and the relevant data was imported from the hotel booking Excel worksheet using the SQL Import & Export Wizard due to Excel being in the 2016 format to ensure data integrity during the import. 

## EDA on the Hotel Booking dataset
When imported into the database, initial queries focused on fetching all the data in each of the imported tables to have a better understanding of the fields that could be used for further data analysis. For this initial step, SELECT all statements were generated for each sheet. 
```
select * from dbo.['2018$']
select * from dbo.['2019$']
select * from dbo.['2020$']
```
Since this way of fetching data, opened three independent windows the function UNION was used to unify 2018, 2019, and 2020 data into a singular table containing all the booking data. For ease, a temporary table was generated called hotels which combines all the data from each of the years was created for more convenient fetching of this data in future queries.
```
with hotels as(
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

select * from hotels
```
### Joining tables (LEFT JOINS)
Now the data has been established in the database and unifying the tables has occurred. Common keys can be determined by viewing each of the Excel files to determine those columns that share a name/key and are joined onto the master table. In this instance, a LEFT JOIN is used to combine the hotels temporary table with the market_segment table by matching the market_segment column in the hotels table with the market_segment.market_segment column. 
```
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
```
Furthermore, a second LEFT JOIN is used to combine the hotels table with the meal_cost table by matching the meal column in the hotels table and the meal_cost.meal column for future analyses.
```
left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal
```
## Power BI Visualisation

In SSMS, queries were generated to access the necessary dashboard data for easy importing into Power BI. Utilizing the onboard tools, the SSMS query was connected to Power BI, allowing specific SQL queries to be executed during data import the below code was specified to unite the tables, and display the relevant fields with the correctly joined foreign keys for market_segment and meal_cost. 
```
-- Creates a temporary table named hotels, uniting all years of data
with hotels as(
select * from dbo.['2018$']
union
select * from dbo.['2019$']
union
select * from dbo.['2020$'])

-- Joins to link foreign keys

select * from hotels
left join dbo.market_segment$
on hotels.market_segment = market_segment$.market_segment
left join dbo.meal_cost$
on meal_cost$.meal = hotels.meal
```
Once the data had been imported, the visualization began by identifying the KPI's that the business was interested in answering. Firstly, a net_revenue column was generated using a calculated measure using the total_days_booked, a calculation of weekend_stays and weekday_stays. This total_days_booked value was multiplied by the ADR, and the discount amount attributed by the market_segment table using Power Query. An example can be seen below:
```
"revenue_discount_app", each ([stays_in_week_nights]+[stays_in_weekend_nights])*([adr]*[Discount]))
```
Using this new column, a Card was created in Power BI called Net Revenue which reported this calculated value. Furthermore, Cards were created for the average daily rate (ADR) using the fields in the Visualisations tab to aggregate the data into an overall average.

![image](https://github.com/slinkymelinki/Hotel-Data-SMSS-and-Power-BI/assets/69980345/c26db59f-f9e2-424a-8b45-ef9d1f9bbc0b)


Lastly, Cards were added for Total Booked Nights which was determined in the previous step by summing up the total stays_in_weeknights and stays_in_weekdays. Car spaces were also generated using data found in the hotel's table. Sparklines were added as a visual depiction of the general trend of the field in question.

![image](https://github.com/slinkymelinki/Hotel-Data-SMSS-and-Power-BI/assets/69980345/28443fb8-2bfa-4c0a-8626-a4424cbf34e5)

A graph showing net value over the booked dates was generated for both City Hotels and Resort Hotels to identify trends over the 3-year period. As a result of generating this graph, outliers were identified ranging back to 2014. To address this a page-wide filter was applied to the dashboard to only include data past 1/1/2018 to eliminate this issue.

![image](https://github.com/slinkymelinki/Hotel-Data-SMSS-and-Power-BI/assets/69980345/0a4e1d46-6f14-46c6-b74f-542d422c743f)

Next, a pie chart was included to distinguish the split of revenue generated by both City Hotels and Resort Hotels. Lastly, a Matrix Table was included to cover more detailed data analyses with breakdowns of the net revenue, required parking spaces, and percentage of drivers to inform the business regarding their parking query.

![image](https://github.com/slinkymelinki/Hotel-Data-SMSS-and-Power-BI/assets/69980345/3ad3c2ba-bff8-44d0-8060-a094d79b4c09)![image](https://github.com/slinkymelinki/Hotel-Data-SMSS-and-Power-BI/assets/69980345/dd504dca-24d2-459e-b2fa-e2b2c3e39ff9)

Furthermore, slicers were implemented to allow for customizable reflections on the data over set periods. Additionally, slicer buttons were included for the hotel type and city.

![image](https://github.com/slinkymelinki/Hotel-Data-SMSS-and-Power-BI/assets/69980345/89a0d47b-c50e-4aeb-92b6-da48db5e200d)

## Conclusions

![image](https://github.com/slinkymelinki/Hotel-Data-SMSS-and-Power-BI/assets/69980345/02fd9d48-8f05-4a30-b901-24bd17a5b5ad)

### Year-over-Year Growth:
Analyzing the hotel's performance over time is critical for understanding trends and identifying growth opportunities. By comparing data year-over-year, we can discern patterns, both positive and negative, in the hotel's performance metrics. This analysis allows us to pinpoint areas of improvement, capitalize on successful strategies, and adapt our approach to meet changing market demands, ensuring sustained growth and profitability.

Using the dashboard, it can be seen that in general the revenue has decreased over the course of the 3 years investigated. Peaking in late 2019, the hotel has experienced similar trends between both City and Resort hotels with a larger proportion of the revenue originating from City Hotels. This is further supported by the pie chart indicating a 53.62% percentage of the market for City Hotels.

### Top Performing Hotel Categories:
Identifying the most lucrative hotel types is pivotal for making informed strategic investments and directing targeted marketing efforts. By analyzing the performance metrics of different hotel categories, we can determine which ones generate the highest revenue and customer satisfaction. This knowledge enables us to allocate resources effectively, enhance services in these categories, and implement marketing campaigns tailored to attract and retain customers in these segments, maximizing profitability and customer loyalty.

Using the dashboard, a clear trend can be seen with City Hotels generating more revenue over the 3-year period. They experience more bookings, a higher average daily rate and perform better as a result.

### Optimizing Parking Spaces:
Assessing the need for increased parking spaces is essential to accommodate heightened customer demand and provide a seamless experience for our guests. By analyzing data related to parking space utilization, such as occupancy rates and customer feedback, we can identify periods of high demand and assess if current parking facilities are adequate. This information empowers us to make data-driven decisions, either by optimizing existing parking spaces or planning expansions, ensuring that our guests have convenient access to parking facilities, enhancing customer satisfaction, and fostering repeat business.

Using the dashboard, the percentage of drivers can be determined using the matrix table. The percentage of guests who have personal cars is lower in City Hotels when compared to Resort Hotels although they only constitute an average of 2.5% of customers, indicating that there is little demand for additional spaces and the investment could be used elsewhere.

### Uncovering Unique Insights:
Delving into the data to extract uncommon and commercially relevant insights provides a competitive edge in the market. By exploring the data deeply, we can uncover hidden patterns, customer preferences, and market trends that might go unnoticed through conventional analysis. These unique insights can inform product offerings, marketing strategies, and customer engagement initiatives. Leveraging such insights allows us to stay ahead of the competition, adapt swiftly to changing market dynamics, and provide exceptional value to our customers, fostering long-term relationships and business success.

This dashboard can be used to effortlessly flex to the criteria needed for the business to develop.

I hope you have enjoyed this project!

Lewis
