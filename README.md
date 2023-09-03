Introduction

Over the past month, I have diligently pursued the Google Data Analytics Professional Certificate on Coursera. Throughout this educational journey, I have gained valuable insights into the role of a data analyst and the various steps involved in the data analysis process, namely asking questions, data preparation, data processing, data analysis, data sharing, and taking action. This certificate program has also equipped me with hands-on experience in utilizing widely-used data analytics tools such as Spreadsheets, SQL, Tableau, and R. The culmination of this program is a Capstone Project, which I will undertake by applying my newfound skills to the Cyclistic Case Study.

Background

This case study casts me in the role of a junior data analyst, operating within the marketing analyst team at Cyclistic. Cyclistic, a bicycle-sharing company launched in 2016, operates in the city of Chicago. The company provides various service offerings, including single-ride passes, full-day passes, and annual memberships. Customers purchasing single-ride or full-day passes are categorized as casual riders, while those opting for annual memberships are considered annual members.

Ask

Lily Moreno, the Director of Marketing at Cyclistic, has emphasized the pivotal importance of annual memberships for the company's future success. Hence, our marketing team has tasked me with the question: How do annual members and casual riders use Cyclistic bikes differently? 

Prepare

To address this question, I will analyze Cyclistic's trip data for the first quarter of 2022. Due to memory constraints, we have opted for this specific time frame instead of the entire year. The data is both reliable and comprehensive, having been collected and stored by Cyclistic itself. It is neatly organized, with separate datasets available for each month of the year. The data used for this analysis can be accessed here.

Process

To start off, I used R through Posit Cloud to combine, clean, and manipulate the data. The key steps involved in this process include:

Uploading the data from January, February, and March into Posit Cloud and merging them into a single coherent dataframe.
Verify that all the observations have transferred cleanly to the new dataframe.
Verify using the `str()` function to see if any of the columns are the wrong type.
In this case, started_at was initialized as a character, which would cause issues in creating the day_of_week column
Coerce the started_as into a date by using `as.Date`
Used R functions to add ride_length (ended_at - started_at) and day_of_week (specific day of ride) columns to the dataframe.
Clean the data by:
Deleting NA/Null values
Deleting duplicates
Deleting values that have a ride_length of 0 or less, as they do not serve a purpose in the business plan
Deleting useless columns as per the instructions (start_lat, start_lng, end_lat, & end_lng)
Add date (yyyy-mm-dd), month, day, & year columns to allow for further aggregation

Analysis

With the completion of the data processing phase, we can turn our attention to addressing the primary question of our business plan: How do annual members and casual riders use Cyclistic bikes differently? 

To start, I compared the amount of rides and the average ride_length between annual members and casual riders

Upon initial examination, it becomes evident that there is a substantial difference between the usage of Cyclistic between the annual members and casual rides. Specifically, annual members exhibit roughly double the ride frequency. 
To gain a more comprehensive understanding of this difference, the ggplot package was used to create a visualization of the data from R.

The graph very obviously shows the staggering difference in usage between casual users and members of Cyclistic. Moreover, a discernible bell-shaped trend is discernible among Cyclistic members, indicating higher utilization during weekdays. Thus, it can be hypothesized that the members of Cyclistic use this service as a way to commute to-and-from work/school. 

However, when revisiting the comparison between the two user categories, a noteworthy observation is that casual users tend to have a longer average ride duration compared to members.

The graph, which showcases a trend opposite to the ride number comparison, led me to delve deeper into the number of rides at each hour..

The graph shows that members reach their first peak in ride frequency around 8:00 - 9:00 A.M., coinciding with the typical start of the workday, and a second peak around 5:00 P.M., corresponding to the end of the workday. Thus, it can be reasonably assumed that members predominantly use these services for their daily commutes. 

On the other hand, casual Cyclistic users exhibit a gradual upward trend in ride frequency until 9:00 P.M., without any notable peaks. So, we can assume, without a doubt, that the casual members do not use these bikes for their commute to work. Instead, we can infer that they use this service as a leisure activity or a means of relaxation, which further explains the decline in usage after 5:00 P.M., likely due to the coming sunset.

Share

How do annual members and casual riders use Cyclistic bikes differently? 

In light of the insights gleaned from our comprehensive data analysis, we can make strong conclusions regarding the distinctions in behavior between Cyclistic's annual members and casual riders.

Annual members demonstrate higher usage rates, as can be seen through the amount of rides they accrued during the first quarter of 2022. Despite that, they had a shorter average duration on the bike (11.54 minutes). This is because the members seem to be using this service as a way to commute to work, as seen by the peaks in usage around 9:00 A.M. and 5:00 P.M.

Conversely, casual riders exhibit lower usage rates but considerably longer average ride durations, averaging approximately 24.85 minutes—more than double that of members. The casual riders did not have any noticeable patterns in their usage throughout the hours, except for a consistent upward trend until 5:00 P.M., where it dips heavily afterwards. This pattern suggests that casual riders engage with Cyclistic as a leisurely experience rather than a commuting solution.

Act

With the differences between members and casual riders being shown, the marketing department can begin to cater their strategies towards casual riders, as the long-term goal is to make them annual members. It is possible for our team to recognize the needs of the casual riders and provide it to them through a membership program. 

For instance, in high-traffic areas of Chicago, targeted information campaigns can be implemented to attract casual riders. Promotions aimed directly at casual riders, such as buy-one-get-one deals allowing individuals and their friends to sign up together, could initiate a chain reaction that boosts annual memberships. Notably, casual riders exhibit a preference for using the service between 10:00 A.M. and 5:00 P.M., suggesting that promotional campaigns offering discounted memberships during this time frame may be particularly effective.
