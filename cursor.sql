/*
https://www.interviewbit.com/sql-interview-questions/

Q: What is Cursor? How to use a Cursor?
Ans: A database cursor is a control structure that allows for the traversal of records in a database. 
Cursors, in addition, facilitates processing after traversal, such as retrieval, addition, and deletion of database records. 
They can be viewed as a pointer to one row in a set of rows.

Working with SQL Cursor:
- DECLARE a cursor after any variable declaration. The cursor declaration must always be associated with a SELECT Statement.
- Open cursor to initialize the result set. The OPEN statement must be called before fetching rows from the result set.
- FETCH statement to retrieve and move to the next row in the result set.
- Call the CLOSE statement to deactivate the cursor.
- Finally use the DEALLOCATE statement to delete the cursor definition and release the associated resources.
*/

DECLARE @name VARCHAR(50)   /* Declare All Required Variables */
DECLARE db_cursor CURSOR FOR   /* Declare Cursor Name*/
SELECT name
FROM myDB.students
WHERE parent_name IN ('Sara', 'Ansh')
OPEN db_cursor   /* Open cursor and Fetch data into @name */ 
FETCH next
FROM db_cursor
INTO @name
CLOSE db_cursor   /* Close the cursor and deallocate the resources */
DEALLOCATE db_cursor
