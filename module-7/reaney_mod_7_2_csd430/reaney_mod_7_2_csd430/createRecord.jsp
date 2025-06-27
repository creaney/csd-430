<%@ page import="java.sql.*,java.util.*,ChristopherReaneyModule7_2_Assignment.DBConnectionBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<%
    // Assignment: Module 7.2
    // Date: 06/27/2025
    // Name: Christopher Reaney
    // This JSP page allows the user to add a new movie record and view all current records.
    // The java code is separated from the HTML to the best of my ability.
    
    // Retrieve form parameters from the request
    String title = request.getParameter("title");
    String genre = request.getParameter("genre");
    String director = request.getParameter("director");
    String yearStr = request.getParameter("release_year");
    String ratingStr = request.getParameter("rating");

    // Check if current request to the page is a POST and all required fields are present.
    if ("POST".equalsIgnoreCase(request.getMethod()) &&
        title != null && genre != null && director != null && yearStr != null && ratingStr != null) {
        try {
            int releaseYear = Integer.parseInt(yearStr);
            double rating = Double.parseDouble(ratingStr);

            DBConnectionBean dbBean = new DBConnectionBean();
            dbBean.insertRecord(title, genre, director, releaseYear, rating);

            // Redirect to avoid resubmission on page refresh (Post/Redirect/Get pattern as is best practice)
            response.sendRedirect("createRecord.jsp?success=1");
            return;
        } catch (Exception e) {
            response.sendRedirect("createRecord.jsp?error=" + java.net.URLEncoder.encode(e.getMessage(), "UTF-8"));
            return;
        }
    }

    // Load movie records into a string buffer for safe HTML rendering outside Java
    StringBuilder movieTableRows = new StringBuilder();
    String dbError = null;

    try {
        DBConnectionBean dbBean = new DBConnectionBean();
        ResultSet rs = dbBean.getAllRecords();
        while (rs.next()) {
            movieTableRows.append("<tr>")
                .append("<td>").append(rs.getInt("movie_id")).append("</td>")
                .append("<td>").append(rs.getString("title")).append("</td>")
                .append("<td>").append(rs.getString("genre")).append("</td>")
                .append("<td>").append(rs.getString("director")).append("</td>")
                .append("<td>").append(rs.getInt("release_year")).append("</td>")
                .append("<td>").append(rs.getBigDecimal("rating")).append("</td>")
                .append("</tr>");
        }
    } catch (Exception e) {
        dbError = e.getMessage();
    }

    // Prepare feedback message from redirect parameters (success/error)
    String success = request.getParameter("success");
    String error = request.getParameter("error");
    String feedbackMessage = null;
    String feedbackColor = null;

    if ("1".equals(success)) {
        feedbackMessage = "Record added successfully!";
        feedbackColor = "green";
    } else if (error != null) {
        feedbackMessage = "Error inserting record: " + error;
        feedbackColor = "red";
    }
%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>Module 2: Create Movie DB Record</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<%-- Display feedback message if applicable --%>
<% if (feedbackMessage != null) { %>
    <p style="color:<%= feedbackColor %>;"><%= feedbackMessage %></p>
<% } %>

<div class="view-container">
    <h2>Module 2: Add New Movie Record</h2>
    <p>Use the form below to add a new movie record to the database.</p>

    <!-- HTML form for user input -->
    <form method="post" action="createRecord.jsp">
        <label for="title">Title:</label>
        <input type="text" name="title" id="title" required><br>

        <label for="genre">Genre:</label>
        <input type="text" name="genre" id="genre" required><br>

        <label for="director">Director:</label>
        <input type="text" name="director" id="director" required><br>

        <label for="release_year">Release Year:</label>
        <input type="number" name="release_year" id="release_year" min="1900" max="2099" required><br>

        <label for="rating">Rating (0.0 to 9.9):</label>
        <input type="number" step="0.1" name="rating" id="rating" min="0" max="9.9" required><br>

        <input type="submit" value="Add Record">
    </form>
</div>

<div class="view-container">
    <h2>All (Current) Movie Records</h2>

    <%-- If an error occurred loading records, show it --%>
    <% if (dbError != null) { %>
        <p style="color:red;">Error fetching records: <%= dbError %></p>
    <% } else { %>
        <table>
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
                <%= movieTableRows.toString() %>
            </tbody>
        </table>
    <% } %>
</div>

	<!-- Footer -->
	<footer>
	    <p>Student: Christopher Reaney | Course: CSD430 | Instructor: Darrell Payne</p>
	    <div class="footer-link">
	        <a href="index.jsp">Back to index</a>
	    </div>
	</footer>
</body>
</html>