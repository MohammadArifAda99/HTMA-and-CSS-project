create database db_library;
use db library;


CREATE TABLE library_branch(
BranchID int not null primary key identity (1,1),
 BranchName varchar(90) NOT NULL,
  BranchAddress varchar(90) NOT NULL,
	);

insert into library_branch values
( 'Kelowna', '3343'),
('', 'Burnaby'),
( 'Richmond', '4354'),
('Coquitlam', '6765'),
('Mission','random');


select * from library_branch;

create table borrower(
CardNumber int NOT NULL primary key identity(1,1),
Fname varchar(90) NOT NULL,
HomeAddress varchar(90),
contact int 
);

select*from borrower;

insert into borrower values
('Allan','8392'83945672'),
('Mike','8976','4576943'),
('Peter','9012','12387512'),
('Devid','3421','237690475'),
('Kevin','5675','984354219'),
('Julia','9087','678511899'),
('Bob','2322','253498765'),
('Lisa','1213','323221345');


create table publisher(
PublisherName varchar(90) NOT NULL primary key,
PublisherAddress varchar(90) NOT NULL,
phone int
);

insert into publisher values
('Milssa','3465','621577899'),
('Angila','1234','66550092'),
('Nalam','7809','84357899'),
('Makinz','3245','212577899'),
('Tom','2143','689577899'),
('Logon','5687','688511899'),
('Kenz','1243','71177899'),
('Lee','3456','73297899'),
('Karal','1234','677345533'),
('Moises','2354','34151145'),
('Heel','4576','726378956'),
('Brown','2354','17397891');


create table books(
BookID int NOT NULL primary key identity(100,1),
title varchar(90) NOT NULL,
PublisherName varchar(90) foreign key 
references publisher(PublisherName),
);

insert into books values
('The power of postive','Moises'),
('Critical Thinkers','Brown'),
('Louse penny','Makinz'),
('Woman','Heel'),
('School','Moises'),
('Women and freedom','Brown'),
('Indogenous','Lisa'),
('Big boy','Kevin'),
('Target','Mike'),
('Rose','Logon'),
('Visit','Makinz')
('Big Dream','Arin'),
('Love','Artan'),
('Homeland','Lee'),
('War','Hal'),
('Glance','Karin'),
('Long','Brown'),
('Read','Arin'),
('Revenge','Ken'),
('Peace','Liz'),
('Boycote','Alix');

select*from books;

create table Book_Authors(
BookID int foreign key 
references books(BookID),
AuthorName varchar(90) NOT NULL
);

insert into Book_Authors values
('242','Alix Mike'),
('243','Bob Aran'),
('244','Alina Tashiba'),
('246','Nandan Singh'),
('250','Sony Son'),
('251','Ajoy Dana'),
('252','Laiza Frog'),
('253','Nardam Sohni'),
('254','Neema Neema'),
('255','Zoo Arin'),
('256','Naz Naz'),
('257','Megan Akz'),
('258','zal Naz');


create table book_copies(
 BookID int foreign key 
 references books(BookID),
 BrachID int foreign key 
references library_branch(BranchID),
Number_of_copies int 
);

insert into book_copies values
('142','1','12'),
('144','2','24'),
('146','3','80'),
('145','4','34'),
('142','5','45');
--('150','6','20');




create table book_loan(
BookID int not null foreign key 
references books(BookID),
BrachID int not null foreign key 
references library_branch(BranchID),
CardNumber int not null foreign key
references borrower(CardNumber),
DateOut date,
DueDate Date
);

insert into book_loan values 
('243','3','3', '2023-01-10','2023-01-20'),
('244','4','6', '2023-02-12','2023-01-30'),
('246','3','4', '2023-01-10','2023-01-20'),
('247','2','7', '2023-01-10','2023-01-20'),
('248','4','3', '2023-01-10','2023-01-20'),
('253','2','5', '2023-01-10','2023-01-20'),
('250','1','8', '2023-01-10','2023-01-20'),
('251','3','6', '2023-01-10','2023-01-20'),
('245','2','3', '2023-01-10','2023-01-20');


select*from ((book_loan full outer join borrower on book_loan.CardNumber=borrower.CardNumber)
full outer join books on book_loan.BookID=books.BookID );


select * from books;
select * from library_branch;
select * from book_copies;



--creating stored procedures

CREATE PROCEDURE BookByBranch 
    @bookTitle nvarchar(50),   
    @branchName nvarchar(50)   
AS    
    select books.title,library_branch.BranchName,book_copies.Number_of_copies
from book_copies inner join books on book_copies.BookID= books.BookID
inner join library_branch on book_copies.BrachID=library_branch.BranchID
where books.title=@bookTitle and library_branch.BranchName like @branchName;

GO  


EXECUTE BookByBranch N'Woman', N'Richmond';
EXECUTE BookByBranch N'Woman', N'%';

select * from book_loan;
select * from borrower;

CREATE PROCEDURE BorrowersWithoutCheckout 
AS
select borrower.Fname from borrower left join book_loan on borrower.CardNumber = book_loan.CardNumber
where book_loan.CardNumber is null;

EXECUTE BorrowersWithoutCheckout;