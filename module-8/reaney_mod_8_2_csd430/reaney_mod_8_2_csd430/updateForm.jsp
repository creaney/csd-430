<%@ page import="ChristopherReaneyModule8_2_Assignment.DBConnectionBean" %>
<%@ page import="java.sql.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	// Assignment: Module 8.2
	// Date: 06/27/2025
	// Name: Christopher Reaney
	// This JSP page allows the user to make updates to the record currently being displayed, 
	//	which was selected on the prior page this redirected from. Submission makes the desired change.
	
	// Use the incoming user provided ID to get the corresponding record from the table and display it.
    int movieId = Integer.parseInt(request.getParameter("movie_id"));
    DBConnectionBean db = new DBConnectionBean();
    ResultSet rs = db.getRecordById(movieId);
    rs.next(); // Move the cursor to the first row
%>
<!DOCTYPE html>
<html>
<head>
    <title>Update Movie Record</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="view-container">
    <h1>Update Movie Record</h1>
    
    <!-- Form with values that correspond to DB table that user can update. -->
    <!-- Submitting will make the changes and redirect to a results page. -->
    <form action="updateSubmit.jsp" method="post">
        <p><strong>Movie ID:</strong> <%= rs.getInt("movie_id") %></p>
        <input type="hidden" name="movie_id" value="<%= rs.getInt("movie_id") %>">

        <label>Title:</label>
        <input type="text" name="title" value="<%= rs.getString("title") %>" required><br>

        <label>Genre:</label>
        <input type="text" name="genre" value="<%= rs.getString("genre") %>" required><br>

        <label>Director:</label>
        <input type="text" name="director" value="<%= rs.getString("director") %>" required><br>

        <label>Release Year:</label>
        <input type="number" name="release_year" value="<%= rs.getInt("release_year") %>" required><br>

        <label>Rating:</label>
        <input type="number" step="0.1" name="rating" value="<%= rs.getDouble("rating") %>" required><br>

        <input type="submit" value="Update Record">
    </form>
    </div>

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
