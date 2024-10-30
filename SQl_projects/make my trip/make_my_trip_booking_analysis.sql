use booking_analysis;

# Table creation

-- CREATE TABLE booking_table(
--    Booking_id       VARCHAR(3) NOT NULL 
--   ,Booking_date     date NOT NULL
--   ,User_id          VARCHAR(2) NOT NULL
--   ,Line_of_business VARCHAR(6) NOT NULL
-- );
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b1','2022-03-23','u1','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b2','2022-03-27','u2','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b3','2022-03-28','u1','Hotel');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b4','2022-03-31','u4','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b5','2022-04-02','u1','Hotel');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b6','2022-04-02','u2','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b7','2022-04-06','u5','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b8','2022-04-06','u6','Hotel');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b9','2022-04-06','u2','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b10','2022-04-10','u1','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b11','2022-04-12','u4','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b12','2022-04-16','u1','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b13','2022-04-19','u2','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b14','2022-04-20','u5','Hotel');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b15','2022-04-22','u6','Flight');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b16','2022-04-26','u4','Hotel');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b17','2022-04-28','u2','Hotel');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b18','2022-04-30','u1','Hotel');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b19','2022-05-04','u4','Hotel');
-- INSERT INTO booking_table(Booking_id,Booking_date,User_id,Line_of_business) VALUES ('b20','2022-05-06','u1','Flight');
-- ;
-- CREATE TABLE user_table(
--    User_id VARCHAR(3) NOT NULL
--   ,Segment VARCHAR(2) NOT NULL
-- );
-- INSERT INTO user_table(User_id,Segment) VALUES ('u1','s1');
-- INSERT INTO user_table(User_id,Segment) VALUES ('u2','s1');
-- INSERT INTO user_table(User_id,Segment) VALUES ('u3','s1');
-- INSERT INTO user_table(User_id,Segment) VALUES ('u4','s2');
-- INSERT INTO user_table(User_id,Segment) VALUES ('u5','s2');
-- INSERT INTO user_table(User_id,Segment) VALUES ('u6','s3');
-- INSERT INTO user_table(User_id,Segment) VALUES ('u7','s3');
-- INSERT INTO user_table(User_id,Segment) VALUES ('u8','s3');
-- INSERT INTO user_table(User_id,Segment) VALUES ('u9','s3');
-- INSERT INTO user_table(User_id,Segment) VALUES ('u10','s3');

# Lets answer few questions based upon the date we got

# Write an sql query that gives the Segment, total users count in that segment and count of users who booked the flight in April 2022
# But the catch here is since we need total count of customers irrespective of whether they have booked or not, we need total count of 
# customers coming from customer table

-- select 
-- u.segment,
-- count(distinct u.User_id) as total_user_count,
-- count(distinct case when extract(year from b.booking_date) = 2022 and extract(month from b.booking_date) = 4 then b.user_id end) as 
-- users_booked_flight_in_april
-- from 
-- booking_table as b
-- right join 
-- user_table as u 
-- on b.User_id = u.User_id
-- group by 1

# Write a query to identify users whose first bookings was a hotel booking
# Since the ask here is to findout the users who's first booking is hotel, we can consider only the booking table, there is no need of
# joining with any other table

-- with first_booking as (
-- select 
-- *,
-- dense_rank() over(partition by User_id order by booking_date) as ranking_order
-- from 
-- booking_table
-- )

-- select 
-- user_id
-- from 
-- first_booking
-- where ranking_order = 1 and line_of_business = 'Hotel'

# One more way to do this problem is by using first_value function

-- with first_booking_data as (
-- select 
-- *,
-- first_value(line_of_business) over(partition by user_id order by booking_date) as first_booking
-- from 
-- booking_table
-- )

-- select 
-- distinct user_id
-- from 
-- first_booking_data 
-- where first_booking = 'Hotel'

# Write a query to calculate the days difference between first and last booking of each user
# For this question also, since we are dealing with booking related stuff no need of joining, only booking table is enough to approach
# at the answer

-- select
-- user_id,
-- min(booking_date) as first_booking,
-- max(booking_date) as last_booking,
-- datediff(max(booking_date),min(booking_date)) as day_difference
-- from 
-- booking_table
-- group by user_id

# Write a query to count the number of flight and hotel bookings in each of the user segments for the year 2022

select 
u.segment,
sum(case when line_of_business = 'Flight' then 1 else 0 end) as Flight_bookings,
sum(case when line_of_business = 'Hotel' then 1 else 0 end) as Hotel_bookings
from 
booking_table as b 
join 
user_table as u 
on u.user_id = b.user_id
where extract(year from booking_date) = 2022
group by u.segment