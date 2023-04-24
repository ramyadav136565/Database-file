create database BookStore
use BookStore


------------------------------------------------------------------------------------------------------------------------------------------------------------------
--Role Table

create table Roles(
RoleId int Primary key ,
Role varchar(20) Not Null);

insert into Role (RoleId,Role) values (1,'Admin'),(2,'Staff');
--EXEC sp_RENAME 'Roles.Role', 'userRole', 'COLUMN'

select * from Roles
EXEC sp_rename 'Role', 'roles';


------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Users Table

Create table Users(
UserId int Primary key identity(1,1),
FullName varchar(40) Not Null,
Email varchar(50) Not Null ,
Password varchar(40) Not Null,
IsActive bit default 0);

ALTER TABLE Users
ALTER COLUMN Password nvarchar(100) NULL;

ALTER TABLE Users
ALTER COLUMN  IsActive bit  not null;



ALTER TABLE users
ADD RoleId INT  Not null default 2 ,
CONSTRAINT FK_Role_Id FOREIGN KEY (RoleId) REFERENCES Roles(RoleId);

ALTER TABLE users
ALTER COLUMN RoleId INT NOT NULL;

alter table users
drop roleid 

ALTER TABLE Users
DROP CONSTRAINT FK_RoleId;

ALTER TABLE Users
DROP COLUMN RoleId;


ALTER TABLE users
DROP COLUMN RoleId;

ALTER TABLE users ADD CONSTRAINT unique_email UNIQUE (Email);



insert Into Users VALUES('Piyush Mishra','piyush@gmail.com','12345',1),
('Ram Yadav','ram@gmail.com','12345',0);
 select * from users

 insert Into Users(FullName,Email,IsActive) VALUES('shivam','shivam@gmail.com',1)

 ------------------------------------------------------------------------------------------------------------------------------------------------------------------

 --UserRole Table

create table UserRole(
UserId int,
RoleId int,
FOREIGN KEY (UserId) REFERENCES Users(UserId),
FOREIGN KEY (RoleId) REFERENCES Role(RoleId));

alter table UserRole
add UserSNo int primary key identity(1,1);

insert Into UserRole(UserId,RoleId) values(1,1),(2,2);

select * from UserRole


------------------------------------------------------------------------------------------------------------------------------------------------------------------

--University Table

create table University(
UniversityId int primary key identity(1001,1),
Name Varchar(100) Not Null,
Address varchar(100) Not Null
);
Alter table University
Add IsDeleted bit default 0;

insert into University(Name,Address,IsDeleted) values('Solicon','Bhubaneshwar',1),('DAVV','Indore',1);
ALTER TABLE University ADD CONSTRAINT unique_Name UNIQUE (Name);


select * from University

--EXEC sp_RENAME 'University.UniversityAddress', 'Address', 'COLUMN'

drop table university

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


insert into Student(FullName,Email,Address,UniversityId,Term,Course,IsDeleted) 
values
('Rohit kumar','rohit@gmail.com','Indore',1002,8,'B.Tech',1),
('Harsh Joshi','harsh@gmail.com','Delhi',1001,8,'B.Tech',0);


insert into Student(FullName,Email,Address,UniversityId,Term,Course,IsDeleted) 
values
('pradeep Yadav','pradeep@gmail.com','Indore',1002,8,'B.Tech',1);

select * from Student
drop table student
------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Book Table
create table Book(
BookId int primary key identity(2001,1),
BookName varchar(100) Not Null,
BookAuthor varchar(100) Not Null,
BookPrice int Not Null,
Course varchar(50) Not Null
);

insert into Book(BookName,BookAuthor,BookPrice,Course) values
('Engineering Physics','Malik and singh',500,'B.tech'),
('Advanced Engineering Mathematics','Chandrika Prasad',700,'B.tech')

alter table Book
add IsDeleted bit default 0;

update book
set IsDeleted =0


select * from Book
drop table Book
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

insert into BookAllocation(StudentId,BookId,universityId) 
values
(101,2001,1001),
(101,2002,1001),
(102,2001,1002),
(102,2002,1002)

select * from BookAllocation

drop table BookAllocation

------------------------------------------------------------------------------------------------------------------------------------------------------------------

--Invoice Table
CREATE TABLE invoice (
invoiceId INT NOT NULL PRIMARY KEY identity(1,1),
universityId INT NOT NULL,
term int NOT NULL,
bookQuantity INT CHECK (bookQuantity >= 0) NOT NULL DEFAULT 0,
tax DECIMAL(10,2) NOT NULL,
totalAmount DECIMAL(10,2) check(totalAmount>=0) NOT NULL DEFAULT 0,
FOREIGN KEY (universityId) REFERENCES university(universityId),
  
);
ALTER TABLE invoice
ADD  totalAmount DECIMAL(10,2) check(totalAmount>=0) NOT NULL DEFAULT 0;

ALTER TABLE invoice
ADD  bookQuantity DECIMAL(10,2) check(bookQuantity>=0) NOT NULL DEFAULT 0;

--drop table Invoice
--alter table Invoice 
--alter column Taxes int Not Null

INSERT INTO Invoice( universityId, semester, tax, totalAmount)
VALUES(1001, 8,100, 2200);

select * from Invoice

alter table invoice
drop column bookQuantity

ALTER TABLE invoice
DROP CONSTRAINT FK_RoleId;
SELECT o.name AS object_name, o.type_desc AS object_type, c.name AS column_name
FROM sys.objects o
INNER JOIN sys.columns c ON o.object_id = c.object_id
WHERE c.name = 'bookQuantity'

ALTER TABLE invoice DROP CONSTRAINT invoice




ALTER TABLE Users
DROP COLUMN RoleId;

SET IDENTITY_INSERT invoice ON
drop table Invoice


------------------------------------------------------------------------------------------------------------------------------------------------------------------

select * from Roles
select * from UserRole
select * from Users
select * from University
select * from Student
select * from bookAllocation
select * from book
select * from Invoice


DELETE FROM invoice WHERE invoiceid in (1,2,5,6);
--SELECT SUM(quantity * bookPrice) AS total_amount
--FROM invoice
--INNER JOIN Book ON invoice.bookId = book.bookId
--WHERE studentId = 101
--AND universityId = 1001
--AND semester =8; 

DELETE FROM bookallocation
WHERE serialNo in(17)

update users
set IsActive=1
where UserId =5

SET IDENTITY_INSERT bookallocation ON;
INSERT INTO invoice (UniversityId, Semester, Tax, TotalAmount) VALUES (1002, 2, 10, 500.00);
SET IDENTITY_INSERT bookallocation OFF;

sp_help 'bookallocation'