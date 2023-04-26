

create database BookStore
use BookStore

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Role Table

create table Roles(
RoleId int Primary key ,
userRole varchar(20) Not Null);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Users Table

CREATE TABLE Users (
    UserId int PRIMARY KEY IDENTITY(1,1),
    FullName varchar(40) NOT NULL,
    Email varchar(50) NOT NULL,
    Password nvarchar(100) NULL,
    IsActive bit NOT NULL DEFAULT 0,
    RoleId INT NOT NULL DEFAULT 2,
    CONSTRAINT unique_email UNIQUE (Email),
    CONSTRAINT FK_Role_Id FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);

 ------------------------------------------------------------------------------------------------------------------------------------------------------------------

 --UserRole Table

CREATE TABLE UserRole (
    UserSNo int PRIMARY KEY IDENTITY(1,1),
    UserId int,
    RoleId int,
    FOREIGN KEY (UserId) REFERENCES Users(UserId),
    FOREIGN KEY (RoleId) REFERENCES Roles(RoleId)
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--University Table

CREATE TABLE University (
    UniversityId int PRIMARY KEY IDENTITY(1001,1),
    Name varchar(100) NOT NULL,
    Address varchar(100) NOT NULL,
    IsDeleted bit DEFAULT 0,
    CONSTRAINT unique_Name UNIQUE (Name)
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Student Table

create table Student(
StudentId int primary key identity(101,1),
FullName varchar(50) Not NUll,
Email varchar(50) Not Null,
Address varchar(100)Not Null,
UniversityId int,
Term int Not Null,
Course varchar(50) Not Null,
IsDeleted bit default 0,
Foreign key(UniversityId) References University(UniversityId)
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Book Table
CREATE TABLE Book (
    BookId int PRIMARY KEY IDENTITY(2001,1),
    BookName varchar(100) NOT NULL,
    BookAuthor varchar(100) NOT NULL,
    BookPrice int NOT NULL,
    Course varchar(50) NOT NULL,
    IsDeleted bit DEFAULT 0
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--BookAllocation

create table BookAllocation(
id int primary key identity(1,1),
studentId int NOt null,
bookId int not null,
universityId int not null,
FOREIGN KEY (StudentId) REFERENCES Student(StudentId),
FOREIGN KEY (BookId) REFERENCES Book(BookId),
FOREIGN KEY (universityId) REFERENCES university(universityId)
);

-----------------------------------------------------------------------------------------------------------------------------------------------------------------

--Invoice Table
CREATE TABLE invoice (
    invoiceId INT NOT NULL PRIMARY KEY IDENTITY(1,1),
    universityId INT NOT NULL,
    term INT NOT NULL,
    bookQuantity INT CHECK (bookQuantity >= 0) NOT NULL DEFAULT 0,
    tax DECIMAL(10,2) NOT NULL,
    totalAmount DECIMAL(10,2) check(totalAmount>=0) NOT NULL DEFAULT 0,
    FOREIGN KEY (universityId) REFERENCES university(universityId)
);

------------------------------------------------------------------------------------------------------------------------------------------------------------------


select * from Roles
select * from UserRole
select * from Users
select * from University
select * from Student
select * from bookAllocation
select * from book
select * from Invoice