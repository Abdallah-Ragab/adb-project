-- 1. Drop existing roles (if they exist) to avoid conflicts
DROP ROLE IF EXISTS student;
DROP ROLE IF EXISTS advisor;

-- 2. Create Roles
CREATE ROLE student;
CREATE ROLE advisor;

-- 3. Revoke Default Public Permissions (Essential for Least Privilege)
REVOKE ALL ON ALL TABLES IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL SEQUENCES IN SCHEMA public FROM PUBLIC;
REVOKE ALL ON ALL FUNCTIONS IN SCHEMA public FROM PUBLIC;


-- 4. Grant Privileges to Roles

-- Advisor Permissions
GRANT SELECT ON Advisor TO advisor;
GRANT SELECT ON Student TO advisor;  -- RLS will restrict access
GRANT SELECT ON Course TO advisor;
GRANT SELECT, UPDATE ON CourseSelection TO advisor; -- For approving/declining
GRANT SELECT ON Transcript TO advisor;
GRANT SELECT ON Prerequisite TO advisor;

-- Student Permissions
GRANT SELECT ON Student TO student; -- Students can view their own information
GRANT SELECT ON Course TO student;
GRANT SELECT ON CourseSelection TO student;
GRANT SELECT ON Transcript TO student;
GRANT SELECT ON Prerequisite TO student;


-- 5. Set Row Access Policies

-- RLS policy for Student
ALTER TABLE Student ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS student_advisor_access ON Student; -- Drop any existing policies

CREATE POLICY student_advisor_access ON Student
    USING (
        (
            current_user LIKE 's%' AND 
            StudentID = (substring(current_user FROM 2)::int)
        ) OR
        (
            current_user LIKE 'a%' AND 
            AdvisorID = (substring(current_user FROM 2)::int)
        )
    );


-- RLS policy for CourseSelection

ALTER TABLE CourseSelection ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS student_advisor_courseselection_access ON CourseSelection; -- Drop any existing policies

CREATE POLICY student_advisor_courseselection_access ON CourseSelection
    USING (
        (current_user LIKE 's%' AND StudentID = substring(current_user FROM 2)::int) OR
        (current_user LIKE 'a%' AND StudentID IN (
            SELECT StudentID FROM Student 
            WHERE AdvisorID = substring(current_user FROM 2)::int
        ))
    );


-- RLS policy for Transcript
ALTER TABLE Transcript ENABLE ROW LEVEL SECURITY;
DROP POLICY IF EXISTS student_advisor_transcript_access ON Transcript; -- Drop any existing policies

CREATE POLICY student_advisor_transcript_access ON Transcript
    USING (
        (current_user LIKE 's%' AND StudentID = substring(current_user FROM 2)::int) OR
        (current_user LIKE 'a%' AND StudentID IN (
            SELECT StudentID FROM Student 
            WHERE AdvisorID = substring(current_user FROM 2)::int
        ))
    );


--6. Set Function Security

GRANT EXECUTE ON FUNCTION get_student_transcript(INT) TO student, advisor; 
GRANT EXECUTE ON FUNCTION get_used_credits(INT) TO student, advisor;
GRANT EXECUTE ON FUNCTION get_approved_courses(INT) TO student, advisor;
GRANT EXECUTE ON FUNCTION list_students_under_advisor(INT) TO advisor;  -- Advisor-specific
GRANT EXECUTE ON FUNCTION list_available_courses(INT) TO student;