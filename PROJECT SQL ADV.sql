use ig_clone;
# Use the above database to solve the given questions:

# 1.0 Create an ER diagram or draw a schema for the given database.

# 2.0We want to reward the user who has been around the longest, Find the 5 oldest users.

SELECT ID, USERNAME FROM USERS order by CREATED_AT LIMIT 5;

# 3.To target inactive users in an email ad campaign, find the users who have never posted a photo.

SELECT USERNAME FROM USERS where id not in (select user_id from photos);


# 4.Suppose you are running a contest to find out who got the most likes on a photo. Find out who won?
with cte as (select photo_id, count(user_id) as nlikes from likes 
                  group by photo_id order by nlikes desc limit 1)
							select u.username, c.photo_id, c.nlikes from cte c
                                           join photos p on p.id=c.photo_id
                                           join users u on p.user_id=u.id;


# 5.The investors want to know how many times does the average user post.
with cte as (select u.id, count(p.id) as photonum
                from photos p right join users u 
                on p.user_id=u.id group by u.id)
                select avg(photonum) as avguserpost from cte;


# 6.A brand wants to know which hashtag to use on a post, and find the top 5 most used hashtags.
select id as tag_id, tag_name, count(*) as tag_count
from tags t 
join photo_tags pt on t.id=pt.tag_id
group by t.id order by tag_count desc limit 5;


# 7.To find out if there are bots, find users who have liked every single photo on the site.
select l.user_id, u.username from likes l
join users u on l.user_id = u.id
join photos p on l.photo_id=p.id
group by l.user_id, u. username
having count(distinct l.photo_id)=(select count(*) from photos );


# 8.Find the users who have created instagramid in may and select top 5 newest joinees from it?

select username, created_at from users 
where monthname(created_at)='may' order by created_at desc limit 5; 


# 9.Can you help me find the users whose name starts with c and ends with any number and have posted the photos as well as liked the photos?

select  distinct u.id,u.username from users u
join photos p on u.id=p.user_id
join likes l on u.id= l.user_id
where u.username regexp '^c.*[0-9]$';


# 10.Demonstrate the top 30 usernames to the company who have posted photos in the range of 3 to 5.

select u.username from users u join photos p on u.id = p.user_id
group by u.username having count(p.id) between 3 and 5 
order by count(p.id) desc limit 30; 

