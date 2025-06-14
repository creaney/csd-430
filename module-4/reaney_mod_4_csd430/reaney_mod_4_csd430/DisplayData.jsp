<%@ page import="java.util.*, ChristopherReaneyModule4Assignment.Book" %>
<%
    // Create and populate a list of Book objects with data used from the module 2 assignment
    List<Book> books = new ArrayList<Book>();
    books.add(new Book("Cibola Burn", "James S. A. Corey", 2014, "Science Fiction", "9780316334719"));
    books.add(new Book("Leviathan Wakes", "James S. A. Corey", 2011, "Science Fiction", "9780316129087"));
    books.add(new Book("The Martian", "Andy Weir", 2011, "Science Fiction", "9780804139021"));
    books.add(new Book("The Temptation of Elminster", "Ed Greenwood", 1998, "Fantasy", "9780786913791"));
    books.add(new Book("Cell", "Stephen King", 2006, "Horror", "9780743292337"));
%>

<!DOCTYPE html>
<html>
<!-- Assignment: Module 4 -->
<!-- Date: 06/14/2025 -->
<!-- Name: Christopher Reaney -->
<!-- This JSP file uses a JavaBean to populate a display window -->
<head>
    <title>Favorite Books</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<h1>My Favorite Books</h1>
<p>This table displays a list of my favorite books using JavaBeans.</p>
<p>The data is all from our module 2 assignment, with the exception of ISBN #, which I just added for this assignment.</p>

<!--  Create a table  -->
<table>
    <tr>
    <!-- Create table header -->
        <th>Title</th>
        <th>Author</th>
        <th>Year</th>
        <th>Category</th>
        <th>ISBN</th>
    </tr>

<!-- For all books in the list, loop through and set table data rows -->
<%
    for (Book b : books) {
%>
    <tr>
        <td><%= b.getTitle() %></td>
        <td><%= b.getAuthor() %></td>
        <td><%= b.getYear() %></td>
        <td><%= b.getCategory() %></td>
        <td><%= b.getIsbn() %></td>
    </tr>
<%
    }
%>

</table>

</body>
</html>
