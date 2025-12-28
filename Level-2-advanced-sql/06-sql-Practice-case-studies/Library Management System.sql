--Library Management System

--Retrieve the title and author of books from the "Books" table. If the genre is 'Computer Science', display 'CS Book' as the category, else display 'Other Book' as the category.
SELECT 
    title, 
    author,
    CASE 
        WHEN genre = 'Computer Science' THEN 'CS Book'
        ELSE 'Other Book'
    END AS category
FROM 
    Books;


-------------------------------------------------------------------------------------------------------------------------
--Display the member names and their corresponding addresses from the "Members" table. If the address contains the word 'Delhi', display 'Delhi Resident', else display 'Other City'.

SELECT 
    member_name,
    CASE 
        WHEN address LIKE '%Delhi%' THEN 'Delhi Resident'
        ELSE 'Other City'
    END AS city_status
FROM 
    Members;
-------------------------------------------------------------------------------------------------------------------------
--Find the total number of books available in each genre from the "Books" table. If the count is less than 5, label the genre as 'Limited', else label it as 'Abundant'.
SELECT 
    genre,
    CASE 
        WHEN COUNT(*) < 5 THEN 'Limited'
        ELSE 'Abundant'
    END AS availability
FROM 
    Books
GROUP BY
    genre;


-------------------------------------------------------------------------------------------------------------------------
--List the member names and their total number of loans from the "Members" and "Loans" tables. If a member has borrowed more than 3 books, label them as 'Frequent Borrower', else label them as 'Occasional Borrower'.

SELECT 
    M.member_name,
    CASE 
        WHEN COUNT(L.loan_id) > 3 THEN 'Frequent Borrower'
        ELSE 'Occasional Borrower'
    END AS borrowing_status
FROM 
    Members M
LEFT JOIN 
    Loans L ON M.member_id = L.member_id
GROUP BY 
    M.member_id;


-------------------------------------------------------------------------------------------------------------------------
--Display the number of books published in each year, along with a column indicating if the number of books is greater than 3. If the count is greater than 3, display "Yes" otherwise "No"

SELECT
  publication_year,
  COUNT(publication_year) AS num_books,
  CASE
    WHEN COUNT(publication_year) > 3 THEN 'Yes'
    ELSE 'No'
  END AS greater_than_three
FROM
  Books
GROUP BY
  publication_year;
-------------------------------------------------------------------------------------------------------------------------
--Classify members based on the number of loans they have made. Members with 5 or more loans are classified as 'VIP Member' members with 3 or more loans are classified as 'Regular Member' and the rest are classified as 'Basic Member'.

SELECT
  member_id,
  COUNT(loan_id) AS num_loans,
  CASE
    WHEN COUNT(loan_id) >= 5 THEN 'VIP Member'
    WHEN COUNT(loan_id) >= 3 THEN 'Regular Member'
    ELSE 'Basic Member'
  END AS membership_category
FROM
  Loans
GROUP BY
  member_id;
-------------------------------------------------------------------------------------------------------------------------
--Display the book title and the number of days each book is on hold for the member. If a book is not on hold by the member, show 0. "Days on hold" refers to the duration or number of days that a book is reserved by a member but not yet available for borrowing because it is currently on loan to another member.

SELECT
  B.title,
  M.member_name,
  CASE
    WHEN R.reservation_date > L.return_date THEN R.reservation_date - L.return_date
    ELSE 0
  END AS days_on_hold
FROM
  Reservations R
JOIN Books B ON R.book_id = B.book_id
JOIN Members M ON R.member_id = M.member_id
LEFT JOIN Loans L ON R.book_id = L.book_id AND R.member_id = L.member_id;
-------------------------------------------------------------------------------------------------------------------------
--Display the member name and the number of books borrowed by each member. However, if a member has borrowed more than 3 books, show "3+" instead of the actual count.

SELECT
  M.member_name,
  CASE
    WHEN COUNT(L.loan_id) > 3 THEN '3+'
    ELSE CAST(COUNT(L.loan_id) AS VARCHAR(2))
  END AS num_books_borrowed
FROM
  Members M
LEFT JOIN Loans L ON M.member_id = L.member_id
GROUP BY
  M.member_id;
-------------------------------------------------------------------------------------------------------------------------
--Display the book title, the number of times it has been borrowed, and the number of times it has been reserved. If there are no loans or reservations for the book, show 0.

SELECT
    b.title AS title,
    COUNT(DISTINCT CASE WHEN l.loan_id IS NOT NULL THEN l.loan_id END) AS num_times_borrowed,
    COUNT(DISTINCT CASE WHEN r.reservation_id IS NOT NULL THEN r.reservation_id END) AS num_times_reserved
FROM
    Books b
LEFT JOIN
    Loans l ON b.book_id = l.book_id
LEFT JOIN
    Reservations r ON b.book_id = r.book_id
GROUP BY
    b.book_id, b.title;
-------------------------------------------------------------------------------------------------------------------------
--Display the member name and the number of books they have borrowed in each genre. If a member has not borrowed any book in a genre, show 0.

SELECT
  M.member_name,
  G.genre,
  COUNT(CASE WHEN B.genre = G.genre THEN 1 END) AS num_borrowed
FROM
  Members M
CROSS JOIN (SELECT DISTINCT genre FROM Books) G
LEFT JOIN Loans L ON M.member_id = L.member_id
LEFT JOIN Books B ON L.book_id = B.book_id
GROUP BY
  M.member_id, G.genre;
