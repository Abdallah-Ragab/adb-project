-- Advisors
INSERT INTO Advisor (FirstName, LastName) VALUES
('Rania', 'Mahmoud'),
('Tarek', 'Youssef'),
('Samira', 'Ibrahim'),
('Nabil', 'Kamal');


-- Students
INSERT INTO Student (FirstName, LastName, GPA, AdvisorID) VALUES
('Ali', 'Mohamed', 3.2, 1),
('Sara', 'Ahmed', 2.8, 2),
('Omar', 'Khaled', 3.8, 1),
('Yasmin', 'Said', 1.8, 3),
('Karim', 'Ali', 3.5, 4),
('Aya', 'Hassan', 3.9, 1),
('Mostafa', 'Ali', 2.5, 2),
('Farida', 'Khaled', 1.9, 3),
('Mahmoud', 'Said', 3.1, 4),
('Aisha', 'Ali', 2.2, 1),
('Adel', 'Mohamed', 3.7, 2),
('Heba', 'Ahmed', 1.5, 3),  -- Low GPA
('Waleed', 'Khaled', 4.0, 4), -- High GPA
('Laila', 'Said', 2.9, 1),
('Youssef', 'Ali', 3.6, 2);


-- Courses
INSERT INTO Course (CourseName, CreditHours) VALUES
('Introduction to Programming', 3),
('Calculus I', 4),
('Linear Algebra', 3),
('Data Structures and Algorithms', 4),
('Database Management Systems', 3),
('Arabic Language', 2),
('English Language', 2),
('Physics I', 4),
('Chemistry I', 4),
('History of Egypt', 2),
('Software Engineering', 3),
('Artificial Intelligence', 4),
('Machine Learning', 3),
('Web Development', 3),
('Mobile Application Development', 4),
('Digital Logic', 3),
('Computer Networks', 4),
('Operating Systems', 3),
('Microcontrollers', 3),
('Math I', 3),
('Math II', 3),
('Math III', 3),
('Math IV', 3);


-- Prerequisites
INSERT INTO Prerequisite (CourseID, PrereqID) VALUES
(4, 1),  -- Data Structures requires Intro to Programming
(4, 2),  -- Data Structures requires Calculus I
(4, 3),  -- Data Structures requires Linear Algebra
(5, 4),  -- Database Management requires Data Structures
(12, 4), -- AI requires Data Structures
(12, 5), -- AI requires Database Management
(13, 12),-- Machine Learning requires AI
(14, 5), -- Web Development requires Database Management
(15, 14),-- Mobile App Development requires Web Development
(16, 3), -- Digital Logic requires Linear Algebra
(17, 5), -- Computer Networks requires Database Management
(18, 4), -- Operating Systems requires Data Structures
(19, 16),-- Microcontrollers requires Digital Logic
(20, 2), -- Math I requires Calculus I
(20, 3), -- Math I requires Linear Algebra
(21, 20),-- Math II requires Math I
(21, 3), -- Math II requires Linear Algebra
(22, 21),-- Math III requires Math II
(22, 3), -- Math III requires Linear Algebra
(23, 22);-- Math IV requires Math III



-- Course Selections
INSERT INTO CourseSelection (StudentID, CourseID, Status) VALUES
(1, 4, 'Approved'), (1, 5, 'Pending'),  -- Ali: Intro to Programming, Calculus I (Passed), now taking Data Structures and Database
(2, 5, 'Approved'), (2, 3, 'Pending'),  -- Sara: Calculus I, Linear Algebra (Passed), now taking Data Structures and Database
(3, 12, 'Approved'), (3, 13, 'Pending'), -- Omar: Data Structures, Database (Passed),  now taking AI and Machine Learning
(4, 3, 'Approved'), (4, 1, 'Pending'),  -- Yasmin: Linear Algebra, Intro to Programming (Passed), now taking Data Structures and Database
(5, 12, 'Pending'), (5, 14, 'Approved'), -- Karim: Data structures and Algorithms,  Database systems (passed), now taking AI, web dev
(6, 13, 'Pending'), (6, 15, 'Approved'), -- Aya: AI, Web dev (passed), now taking machine learning, mobile app dev
(7, 14, 'Pending'), (7, 15, 'Approved'), -- Mostafa: web dev and mobile app dev (passed)
(8, 4, 'Pending'), -- Farida: data structures (passed)
(9, 13, 'Approved'), (9, 15, 'Pending'),  -- Mahmoud: AI (Passed), taking machine learning and mobile
(10, 15, 'Approved'), (10, 17, 'Pending'), -- Aisha: Mobile app dev (passed), taking computer networks
(11, 17, 'Approved'), (11, 18, 'Pending'), -- Adel: computer networkds (passed), taking operating systems
(12, 5, 'Pending'), (12, 1, 'Pending'),   -- Heba: Taking intro to programming and calculus,  database systems
(13, 18, 'Approved'),(13, 19, 'Pending'),  -- Waleed: operating systems (passed), taking microcontrollers
(14, 19, 'Approved'), (14, 20, 'Pending'), -- Laila: microcontrollers (passed), taking math 1
(15, 21, 'Approved'), (15, 22, 'Pending'); -- Youssef: math 2 (passed), taking math 3


-- Transcripts
INSERT INTO Transcript (StudentID, CourseID, Grade) VALUES
(1, 1, 'A'), (1, 2, 'B+'), 
(2, 1, 'B'), (2, 2, 'C+'),
(3, 1, 'A-'), (3, 2, 'A'), (3, 3, 'B+'), (3, 4, 'A'),
(4, 2, 'C'), (4, 1, 'D'),
(5, 4, 'B+'), (5, 5, 'A-'),
(6, 4, 'A'), (6, 5, 'A'), (6, 12, 'B+'), (6, 14, 'A-'),
(7, 4, 'C+'), (7, 5, 'B-'), (7, 14, 'B'), (7, 15, 'C+'),
(8, 1, 'D'), (8, 2, 'F'), (8, 3, 'C-'),
(9, 4, 'A-'), (9, 5, 'B+'), (9, 12, 'A'), 
(10, 14, 'C+'), (10, 15, 'B-'),
(11, 12, 'B'), (11, 13, 'B+'), (11, 14, 'A-'),(11, 15, 'A'),(11, 17, 'A-'),
(12, 1, 'F'), (12, 2, 'D'),
(13, 1, 'A'), (13, 2, 'A'),(13, 3, 'A'),(13, 4, 'A'),(13, 5, 'A'),(13, 12, 'A'),(13, 13, 'A'), (13, 14, 'A'), (13, 15, 'A'), (13, 16, 'A'), (13, 17, 'A'), (13, 18, 'A-'),
(14, 1, 'B+'), (14, 2, 'B'),(14, 3, 'B-'),(14, 4, 'C+'),(14, 5, 'C'),(14, 12, 'A-'),(14, 13, 'B+'), (14, 14, 'B'), (14, 15, 'B-'), (14, 16, 'C+'), (14, 17, 'C'), (14, 18, 'C-'),(14, 19, 'C'),
(15, 1, 'A'), (15, 2, 'A-'),(15, 3, 'B+'),(15, 4, 'B'),(15, 5, 'B-'),(15, 12, 'C+'),(15, 13, 'C'), (15, 14, 'C-'), (15, 15, 'D+'), (15, 16, 'D'), (15, 17, 'D-'), (15, 18, 'F'),(15, 19, 'F'), (15, 20, 'D'),(15, 21, 'C');