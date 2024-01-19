CREATE DATABASE Library;

USE Library;

CREATE TABLE  Branch(Branch_no INT PRIMARY KEY, Manager_Id INT, Branch_address VARCHAR(120), Contact_no INT);
INSERT INTO Branch VALUES
(1, 1001, '123 Main street New York', 5551234),
(2, 1002, '345 Oak Avanue London', 5555755),
(3, 1003, '256 Elm Lane Berlin', 5555675),
(4, 1004, '575 Pine Boulevard New York', 5557895),
(5, 1005, '465 Maple Street United States', 4556778);
SELECT * FROM Branch;


CREATE TABLE Employee (Emp_Id INT PRIMARY KEY, Emp_name VARCHAR(50), Position VARCHAR(50), Salary INT, Branch_no INT REFERENCES Branch(Branch_no));
INSERT INTO Employee VALUES
(10001, 'John Doe', 'Manager', 100000, 1),
(10002, 'John Smith', 'Clerk', 60000, 1),
(10003, 'Jhonson Michle', 'Secretary', 70000, 2),
(10004, 'Alex Wilson', 'Manager', 100000, 4),
(10005, 'Emily Brown', 'Sales Rep', 50000, 3),
(10006, 'Arjun Krishna', 'Clerk', 100000, 5),
(10007, 'Mary Alex', 'Cashier', 45000, 4),
(10008, 'Izza Arun', 'Manager', 100000, 5),
(10009, 'Nashwa Antony', 'Accountant', 50000, 2),
(10010, 'Alexander', 'Secretary', 70000, 5);
SELECT * FROM Employee;


CREATE TABLE Customer(Customer_Id INT PRIMARY KEY, Customer_name VARCHAR(50), Customer_address VARCHAR(120), Reg_date DATE);
INSERT INTO Customer VALUES
(111, 'Athira Jeswin', '123 House, Oak villa, kakkanad', '2023-05-28'),
(112, 'Anjana Mohan', 'VP House, Kozhikode', '2023-06-12'),
(113, 'Sandra Thomas', 'Flat no 556, Asset homes, Edappally', '2022-01-06'),
(114, 'Vinicious Abraham', '896 Main street, Chelsea', '2022-12-25'),
(115, 'Christian Romero', '666 Pine road, Manchester', '2020-09-13');
SELECT * FROM Customer;


CREATE TABLE IssueStatus(Issue_Id INT PRIMARY KEY, Issued_cust INT REFERENCES Customer(customer_id), Issued_book_name VARCHAR(80), Issue_date DATE, Isbn_book BIGINT);
INSERT INTO IssueStatus VALUES
(1, 111, 'The little Prince', '2023-06-28', 6598745612365),
(2, 112, 'She:A History Of Adventure', '2023-08-01', 7895463215648),
(3, 113, 'The Da Vinci Code', '2022-02-25', 9658769841236),
(4, 114, 'Harry Potter and the Philosophers Stone', '2023-01-28', 6598336455598);
SELECT * FROM IssueStatus;


CREATE TABLE ReturnStatus(Return_Id INT PRIMARY KEY, Return_cust VARCHAR(50), Return_book_name VARCHAR(80), Return_date DATE, Isbn_book2 BIGINT);
INSERT INTO ReturnStatus VALUES
(501, 'Athira Jeswin', 'The little Prince', '2023-08-03', 6598745612365),
(502, 'Anjana Mohan', 'She:A History Of Adventure', '2023-09-05', 7895463215648),
(503, 'Sandra Thomas', 'The Da Vinci Code', '2022-03-28', 9658769841236),
(504, 'Vinicious Abraham', 'Harry Potter and the Philosophers Stone', '2023-03-02', 6598336455598);
SELECT * FROM ReturnStatus;


CREATE TABLE Books(ISBN BIGINT PRIMARY KEY, Book_title VARCHAR(100), Category VARCHAR(100), Rental_Price DECIMAL(10,2), Status VARCHAR(5) CHECK (Status IN('YES','NO')), Author VARCHAR(50), Publisher VARCHAR(50));
INSERT INTO Books VALUES
(6598745612365, 'The little Prince', 'Fantasy, Childrens Fiction', 400.00, 'YES', 'Antoine de Saint', 'Reynal and Hitchcock'),
(7895463215648, 'She:A History Of Adventure', 'Adventure,Fantasy,Romance', 450.00, 'YES', 'H. Rider Haggard', 'Longmans'),
(6336558975462, 'The Alchemist', 'Quest,Adventure,Fantasy', 869.30, 'NO', 'Paulo Coelho', 'HarperTorch'),
(9645563126665, 'One Hundred Years of Solitude', 'Magic realism', 399.00, 'NO', 'Gabriel Garcia Marquez', 'Harper & Row'),
(9658769841236, 'The Da Vinci Code', 'Mystery,Detective,Fiction,Thriller', 813.00, 'YES', 'Dan Brown', 'Doubleday'),
(6598336455598, 'Harry Potter and the Philosophers Stone', 'Fantasy', 999.00, 'YES', 'J. K. Rowling', 'Bloomsbury'),
(3336664598551, 'The Hobbit', 'High Fantasy, Juvenile Fantasy', 355.00, 'NO', 'J. R. R. Tolkien', 'George Allen & Unwin'),
(3164597894562, 'Anne of Green Gables', 'Novel', 199.00, 'NO', 'Lucy Maud Montgomery', 'L.C Page & Co.');
SELECT * FROM Books;
DROP TABLE BOOKS;


#1.Retrieve the book title, category, and rental price of all available books.

SELECT  Book_title, Category, Rental_Price FROM Books WHERE Status = 'YES';


#2. List the employee names and their respective salaries in descending order of salary.

SELECT  Emp_name, Salary FROM Employee ORDER BY Salary DESC;


#3. Retrieve the book titles and the corresponding customers who have issued those books.

SELECT IssueStatus.Issued_book_name, Customer.Customer_name FROM IssueStatus JOIN Customer ON IssueStatus.Issued_cust = Customer.Customer_id;


#4. Display the total count of books in each category.

SELECT Category,COUNT(*) AS Total_Books_Count FROM Books GROUP BY Category;


#5. Retrieve the employee names and their positions for the employees whose salaries are above Rs.50,000.

SELECT Emp_name,Position FROM Employee WHERE Salary>50000;


#6. List the customer names who registered before 2022-01-01 and have not issued any books yet.

SELECT C.Customer_name FROM Customer C LEFT JOIN IssueStatus I ON C.Customer_id = I.Issued_cust WHERE C.Reg_date < '2022-01-01' AND I.Issued_cust IS NULL;


#7. Display the branch numbers and the total count of employees in each branch.

SELECT Branch_no, COUNT(*) AS Total_Employees FROM Employee GROUP BY Branch_no;


#8. Display the names of customers who have issued books in the month of June 2023.

SELECT C.Customer_name FROM Customer C JOIN IssueStatus I ON C.Customer_id = I.Issued_cust WHERE MONTH(I.Issue_date)=6 AND YEAR(I.Issue_date)=2023;


#9.Retrieve book_title from book table containing history.

SELECT Book_title FROM Books WHERE Category='History';


#10.Retrieve the branch numbers along with the count of employees for branches having more than 5 employees.

SELECT Branch_no,COUNT(*) AS Total_Employees FROM Employee GROUP BY Branch_no HAVING COUNT(*) > 5;