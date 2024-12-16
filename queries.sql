-- get the total credit hours used by a student in approved courses
CREATE OR REPLACE FUNCTION get_used_credits(student_id INT)
RETURNS INT AS 
$$
DECLARE 
    total_credit_hours INT;
BEGIN
    -- Calculate the sum of credit hours for courses selected by the student
    SELECT COALESCE(SUM(c.CreditHours), 0) 
    INTO total_credit_hours
    FROM CourseSelection cs
    JOIN Course c ON cs.CourseID = c.CourseID
    WHERE cs.StudentID = student_id AND cs.Status = 'Approved';

    RETURN total_credit_hours;
END;
$$ LANGUAGE plpgsql;


-- retrieve a student's approved courses
CREATE OR REPLACE FUNCTION get_approved_courses(student_id INT) RETURNS TABLE (CourseName VARCHAR(255), CreditHours INT) AS
$$
BEGIN
    RETURN QUERY
    SELECT c.CourseName, c.CreditHours
    FROM Course c
    JOIN CourseSelection cs ON c.CourseID = cs.CourseID
    WHERE cs.StudentID = student_id AND cs.Status = 'Approved';
END;
$$ LANGUAGE plpgsql;

-- list all students under a certain advisor
CREATE OR REPLACE FUNCTION list_students_under_advisor(advisor_id INT) RETURNS TABLE (StudentId INT, FirstName VARCHAR(255), LastName VARCHAR(255), GPA DECIMAL(3,2), AllowedCredits INT, UsedCredits INT) AS
$$
BEGIN
    RETURN QUERY
    SELECT s.StudentID, s.FirstName, s.LastName, s.GPA, s.AllowedCredits, get_used_credits(s.StudentID) as UsedCredits
    FROM Student s
    WHERE s.AdvisorID = advisor_id;
END;
$$ LANGUAGE plpgsql;

-- receive a student's transcript
CREATE OR REPLACE FUNCTION get_student_transcript(student_id INT) RETURNS TABLE (CourseName VARCHAR(255), Grade VARCHAR(10)) AS
$$
BEGIN
    RETURN QUERY
    SELECT c.CourseName, t.Grade
    FROM Course c
    JOIN Transcript t ON c.CourseID = t.CourseID
    WHERE t.StudentID = student_id;
END;
$$ LANGUAGE plpgsql;

-- list all courses available to a student based on completed prerequisites
CREATE OR REPLACE FUNCTION list_available_courses(student_id INT)
RETURNS TABLE(course_id INT, course_name VARCHAR, credit_hours INT) AS $$
BEGIN
    RETURN QUERY
    SELECT 
        c.CourseID,
        c.CourseName,
        c.CreditHours
    FROM 
        Course c
    WHERE 
        -- Ensure the student has completed all prerequisites for the course
        NOT EXISTS (
            SELECT 1
            FROM Prerequisite p
            WHERE p.CourseID = c.CourseID
              AND p.PrereqID NOT IN (
                  SELECT t.CourseID
                  FROM Transcript t
                  WHERE t.StudentID = student_id
                    AND SUBSTRING(t.Grade, 1, 1) IN ('A', 'B', 'C') -- Only consider passing grades
              )
        )
        AND c.CourseID NOT IN (
            SELECT t.CourseID
            FROM Transcript t
            WHERE t.StudentID = student_id
        ); -- Exclude courses the student has already completed
END;
$$ LANGUAGE plpgsql;