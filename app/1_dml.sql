-- Task 1: Database Design

-- DML

-- Users
INSERT INTO Users (username, password, role)
VALUES ('student1', 'student1', 'Student');
INSERT INTO Users (username, password, role)
VALUES ('student2', 'student2', 'Student');
INSERT INTO Users (username, password, role)
VALUES ('student3', 'student3', 'Student');
INSERT INTO Users (username, password, role)
VALUES ('tutor1', 'tutor1', 'Tutor');
INSERT INTO Users (username, password, role)
VALUES ('admin1', 'admin1', 'Admin');

-- Challenges
INSERT INTO Challenges (code, title, body, category, flag, is_visible, is_available, points)
VALUES ('CH_1', 'Challenge 1', '...', 'Cryptography', 'flag{1}', 1, 1, 500);
INSERT INTO Challenges (code, title, body, category, flag, is_visible, is_available, points)
VALUES ('CH_2', 'Challenge 2', '...', 'Web', 'flag{2}', 1, 1, 500);
INSERT INTO Challenges (code, title, body, category, flag, is_visible, is_available, points)
VALUES ('CH_3', 'Challenge 3', '...', 'Binary', 'flag{3}', 1, 1, 500);

-- Student 1 solved Challenge 1
INSERT INTO Solved_Challenges (user_id, challenge_code)
VALUES ((SELECT id FROM Users WHERE username = 'student1'), 'CH_1');
UPDATE Users
SET score = score + (SELECT points FROM Challenges WHERE code = 'CH_1')
WHERE id = (SELECT id FROM Users WHERE username = 'student1');

-- Student 1 solved Challenge 2
INSERT INTO Solved_Challenges (user_id, challenge_code)
VALUES ((SELECT id FROM Users WHERE username = 'student1'), 'CH_2');
UPDATE Users
SET score = score + (SELECT points FROM Challenges WHERE code = 'CH_2')
WHERE id = (SELECT id FROM Users WHERE username = 'student1');

-- Student 2 solved Challenge 1
INSERT INTO Solved_Challenges (user_id, challenge_code)
VALUES ((SELECT id FROM Users WHERE username = 'student2'), 'CH_1');
UPDATE Users
SET score = score + (SELECT points FROM Challenges WHERE code = 'CH_1')
WHERE id = (SELECT id FROM Users WHERE username = 'student2');
