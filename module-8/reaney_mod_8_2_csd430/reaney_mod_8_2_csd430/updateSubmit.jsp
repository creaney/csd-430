<%@ page import="java.sql.*" %>
<%@ page import="ChristopherReaneyModule8_2_Assignment.DBConnectionBean" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	// Assignment: Module 8.2
	// Date: 06/27/2025
	// Name: Christopher Reaney
	// This JSP page displays the final change that a user just made to the table. 
	//	It allows the user to go back to the main page to make more changes if desired. 
	
	// Use the incoming user provided ID to get the corresponding record from the table and display it.
    int movieId = Integer.parseInt(request.getParameter("movie_id"));
    String title = request.getParameter("title");
    String genre = request.getParameter("genre");
    String director = request.getParameter("director");
    int releaseYear = Integer.parseInt(request.getParameter("release_year"));
    double rating = Double.parseDouble(request.getParameter("rating"));

    // Create an instance of the DB connection bean
    DBConnectionBean db = new DBConnectionBean();

    // Update the record using the bean method
    db.updateRecord(movieId, title, genre, director, releaseYear, rating);
%>
<!DOCTYPE html>
<html>
<head>
    <title>Record Updated</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
    <h1>Record Successfully Updated</h1>

    <!-- Display the updated record in an html table format -->
    <table border="1">
        <thead>
            <tr>
                <th>ID</th>
                <th>Title</th>
                <th>Genre</th>
                <th>Director</th>
                <th>Year</th>
                <th>Rating</th>
            </tr>
        </thead>
        <tbody>
            <tr>
            <!-- Get the individual items from the DB table to populate the html table row -->
                <td><%= movieId %></td>
                <td><%= title %></td>
                <td><%= genre %></td>
                <td><%= director %></td>
                <td><%= releaseYear %></td>
                <td><%= rating %></td>
            </tr>
        </tbody>
    </table>

	<!-- Footer -->
	<footer>
	    <p>Student: Christopher Reaney | Course: CSD430 | Instructor: Darrell Payne</p>
	    <div class="footer-link">
	    	<a href="updateSelect.jsp">Back to the Record Select Page</a><br>
	        <a href="index.jsp">Back to index</a>
	    </div>
	</footer>
</body>
</html>
