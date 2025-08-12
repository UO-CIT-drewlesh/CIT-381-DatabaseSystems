-- Stored procedure inserts user info --
DROP PROCEDURE IF EXISTS sp_insert_userinfo;
DELIMITER //
CREATE PROCEDURE sp_insert_userinfo()
BEGIN
INSERT INTO users
VALUES(11, 'Thebeavs3', 'https://www.reddit.com/user/Thebeavs3/', '2021-01-08', 48, 4240),
	  (12, 'TheOneYardLine', 'https://www.reddit.com/user/TheOneYardLine/', '2021-05-31', 1980, 11053),
      (13, 'MountainEmployee2862', 'https://www.reddit.com/user/MountainEmployee2862/', '2022-11-05', 184, 371);
END //
DELIMITER ;
CALL sp_insert_userinfo();

-- Stored procedure inserts post info --
DROP PROCEDURE IF EXISTS sp_insert_postinfo;
DELIMITER //
CREATE PROCEDURE sp_insert_postinfo()
BEGIN
INSERT INTO posts
VALUES(11, 'The kings trading sabonis for Hali was a good move', 'Thebeavs3', '2023-11-19 08:30:08', 'https://www.reddit.com/r/nbadiscussion/comments/17z6539/the_kings_trading_sabonis_for_hali_was_a_good_move/', NULL, 101, 0, NULL), 
	  (12, 'What went wrong with the Pistons organization?', 'TheOneYardLine', '2023-11-19 05:00:15', 'https://www.reddit.com/r/nbadiscussion/comments/17zc8m2/what_went_wrong_with_the_pistons_organization/', NULL, 32, 0, NULL),
      (13, 'Are passing big-man led offenses the future of the NBA?', 'MountainEmployee2862', '2023-11-19 04:29:25', 'https://www.reddit.com/r/nbadiscussion/comments/17z0v9t/are_passing_bigman_led_offenses_the_future_of_the/', NULL, 32, 0, NULL);
END //
DELIMITER ;
CALL sp_insert_postinfo();
