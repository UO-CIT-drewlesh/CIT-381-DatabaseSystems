DROP VIEW IF EXISTS vw_p7;
CREATE VIEW vw_p7 AS
SELECT PostID, Title, u.UserID, AuthorName, DATEDIFF(CURRENT_DATE, DateAndTime) as Days_Since_Post
From posts
INNER JOIN users u USING(AuthorName);

select * from vw_p7;