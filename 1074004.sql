-- __/\\\\\\\\\\\__/\\\\\_____/\\\__/\\\\\\\\\\\\\\\_____/\\\\\_________/\\\\\\\\\_________/\\\\\\\________/\\\\\\\________/\\\\\\\________/\\\\\\\\\\________________/\\\\\\\\\_______/\\\\\\\\\_____        
--  _\/////\\\///__\/\\\\\\___\/\\\_\/\\\///////////____/\\\///\\\_____/\\\///////\\\_____/\\\/////\\\____/\\\/////\\\____/\\\/////\\\____/\\\///////\\\_____________/\\\\\\\\\\\\\___/\\\///////\\\___       
--   _____\/\\\_____\/\\\/\\\__\/\\\_\/\\\_____________/\\\/__\///\\\__\///______\//\\\___/\\\____\//\\\__/\\\____\//\\\__/\\\____\//\\\__\///______/\\\_____________/\\\/////////\\\_\///______\//\\\__      
--    _____\/\\\_____\/\\\//\\\_\/\\\_\/\\\\\\\\\\\____/\\\______\//\\\___________/\\\/___\/\\\_____\/\\\_\/\\\_____\/\\\_\/\\\_____\/\\\_________/\\\//_____________\/\\\_______\/\\\___________/\\\/___     
--     _____\/\\\_____\/\\\\//\\\\/\\\_\/\\\///////____\/\\\_______\/\\\________/\\\//_____\/\\\_____\/\\\_\/\\\_____\/\\\_\/\\\_____\/\\\________\////\\\____________\/\\\\\\\\\\\\\\\________/\\\//_____    
--      _____\/\\\_____\/\\\_\//\\\/\\\_\/\\\___________\//\\\______/\\\______/\\\//________\/\\\_____\/\\\_\/\\\_____\/\\\_\/\\\_____\/\\\___________\//\\\___________\/\\\/////////\\\_____/\\\//________   
--       _____\/\\\_____\/\\\__\//\\\\\\_\/\\\____________\///\\\__/\\\______/\\\/___________\//\\\____/\\\__\//\\\____/\\\__\//\\\____/\\\___/\\\______/\\\____________\/\\\_______\/\\\___/\\\/___________  
--        __/\\\\\\\\\\\_\/\\\___\//\\\\\_\/\\\______________\///\\\\\/______/\\\\\\\\\\\\\\\__\///\\\\\\\/____\///\\\\\\\/____\///\\\\\\\/___\///\\\\\\\\\/_____________\/\\\_______\/\\\__/\\\\\\\\\\\\\\\_ 
--         _\///////////__\///_____\/////__\///_________________\/////_______\///////////////_____\///////________\///////________\///////_______\/////////_______________\///________\///__\///////////////__

-- Student Name: Yun-Chi Hsiao
-- Student Number: 1074004
-- By submitting, you declare that this work was completed entirely by yourself.

-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q1

SELECT Id AS "Forum ID", Topic, Createdby AS "Lecturer ID"
FROM forum
WHERE CreatedBy = ClosedBy;

-- END Q1
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q2

SELECT user.Id AS "Lecturer ID", CONCAT(user.Firstname, ' ', user.Lastname) AS "Full Name", COUNT(CreatedBy) AS "Number of Forums Created"
FROM user 
INNER JOIN forum
ON user.Id = forum.CreatedBy
GROUP BY CreatedBy;

-- END Q2
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q3

SELECT DISTINCT Id AS "User ID", Username
FROM user
WHERE Id NOT IN (SELECT PostedBy FROM post WHERE Forum IS NOT NULL);

-- END Q3
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q4

SELECT Id AS "Post ID"
FROM post AS top
WHERE top.Forum IS NOT NULL 
AND NOT EXISTS (SELECT ParentPost FROM post AS comment WHERE top.Id = comment.ParentPost)
AND NOT EXISTS (SELECT Post FROM likepost WHERE top.Id = likepost.Post)
ORDER BY top.Id;

-- END Q4
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q5

SELECT Id AS "Post ID", Content, COUNT(likepost.Post) AS "Number of Likes"
FROM post
INNER JOIN likepost
ON post.Id = likepost.Post 
GROUP BY likepost.Post
HAVING COUNT(likepost.post) = (SELECT COUNT(post) FROM likepost GROUP BY post ORDER BY COUNT(post) DESC LIMIT 1);

-- END Q5
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q6

SELECT length(post.content) AS "Length", post.content AS "Content String", forum.Topic AS "Topic of Forum", CONCAT(user.Firstname, ' ', user.Lastname) AS "Full Name" 
FROM post
INNER JOIN forum 
INNER JOIN user
ON post.Forum = forum.Id AND post.PostedBy = user.Id
HAVING length(post.content) = (SELECT MAX(length(content)) FROM post);

-- END Q6
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q7

SELECT Student1 AS "Student1 ID", Student2 AS "Student2 ID", TIMESTAMPDIFF(DAY, WhenConfirmed, WhenUnfriended) AS "Duration (Day)"
FROM friendof
WHERE WhenUnfriended - WhenConfirmed = (SELECT MIN(WhenUnfriended - WhenConfirmed) FROM friendof);

-- END Q7
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q8

SELECT likepost.user AS "User ID", "Count of Other Like", post.Id AS "Post ID"
FROM post INNER JOIN likepost ON post.Id = likepost.Post
INNER JOIN (SELECT post.Id, count(*) - 1 AS "Count of Other Like" FROM post
INNER JOIN likepost
ON post.Id = likepost.Post GROUP BY post.Id) AS "counttable" 
ON post.Id = counttable.Id;

-- END Q8
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q9

SELECT IF (Student1 = popularid.Id, Student2, Student1) AS "User ID"
FROM (SELECT * 
FROM friendof
INNER JOIN student
ON friendof.Student1 = student.Id
WHERE friendof.WhenConfirmed IS NOT NULL AND friendof.WhenUnfriended IS NULL) AS "firststudent"
INNER JOIN student AS "secondstudent"
ON firststudent.Student2 = secondstudent.Id
INNER JOIN (SELECT Id FROM user
INNER JOIN (SELECT PostedBy, COUNT(*) AS "Likes" FROM post
INNER JOIN likepost 
ON post.Id = likepost.Post GROUP BY PostedBy ORDER BY Likes DESC LIMIT 1) AS "popular"
ON user.Id = popular.PostedBy) AS "popularid"
ON popularid.Id IN (firststudent.Id, secondstudent.Id)
WHERE firststudent.Degree = secondstudent.Degree;

-- END Q9
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- BEGIN Q10

SELECT post.Id AS "Post ID", post.WhenPosted AS "Time When the Post Was Created"
FROM post
INNER JOIN user
ON post.PostedBy = user.Id
WHERE user.Usertype = 'S' AND post.Forum IS NOT NULL
AND post.Id NOT IN (SELECT top.Id
FROM post AS "top"
INNER JOIN post AS "reply"
ON top.Id = reply.ParentPost AND top.Forum IS NOT NULL AND HOUR(timediff(reply.WhenPosted, top.WhenPosted)) <= 48
INNER JOIN forum
ON reply.PostedBy = forum.CreatedBy AND top.Forum = forum.Id);

-- END Q10
-- ____________________________________________________________________________________________________________________________________________________________________________________________________________
-- END OF ASSIGNMENT Do not write below this line