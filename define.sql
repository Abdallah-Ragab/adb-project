CREATE TABLE Advisor (
    AdvisorID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL
);

CREATE TABLE Student (
    StudentID SERIAL PRIMARY KEY,
    FirstName VARCHAR(255) NOT NULL,
    LastName VARCHAR(255) NOT NULL,
    GPA DECIMAL(3,2) NOT NULL, 
    AllowedCredits INT GENERATED ALWAYS AS (
      CASE
          WHEN gpa < 2.0 THEN 12 
          WHEN gpa > 3.5 THEN 21 
          ELSE 18 
      END
 	) STORED,		
    AdvisorID INTEGER,
    FOREIGN KEY (AdvisorID) REFERENCES Advisor(AdvisorID)
);

CREATE TABLE Course (
    CourseID SERIAL PRIMARY KEY,
    CourseName VARCHAR(255) NOT NULL,
    CreditHours INT NOT NULL
);

CREATE TABLE Prerequisite (
    CourseID INTEGER,
    PrereqID INTEGER,
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID),
    FOREIGN KEY (PrereqID) REFERENCES Course(CourseID),
    PRIMARY KEY (CourseID, PrereqID)
);

CREATE TABLE CourseSelection (
    SelectionID SERIAL PRIMARY KEY,
    StudentID INTEGER,
    CourseID INTEGER,
    Status VARCHAR(20) CHECK (Status IN ('Pending', 'Approved', 'Declined')),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);

CREATE TABLE Transcript (
    TranscriptID SERIAL PRIMARY KEY,
    StudentID INTEGER,
    CourseID INTEGER,
    Grade VARCHAR(10),
    FOREIGN KEY (StudentID) REFERENCES Student(StudentID),
    FOREIGN KEY (CourseID) REFERENCES Course(CourseID)
);