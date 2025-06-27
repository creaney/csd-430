<%@ page import="ChristopherReaneyModule8_2_Assignment.DBConnectionBean" %>
<%@ page import="java.sql.*" %>
<%@ page import="java.util.*" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%
	// Assignment: Module 8.2
	// Date: 06/27/2025
	// Name: Christopher Reaney
	// This JSP page allows the user to add select a record that they'd like to update.
	//		Afterward they are redirected to a page where they can make the actual change.
    DBConnectionBean db = new DBConnectionBean();

    // Get dropdown options
    ArrayList<Integer> keys = db.getAllPrimaryKeys();

    // Prepare full record table to be applied in the html table below.
    StringBuilder movieTableRows = new StringBuilder();
    String dbError = null;
    try {
        ResultSet rs = db.getAllRecords();
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
%>
<!DOCTYPE html>
<html>
<head>
    <title>Select Movie to Update</title>
    <link rel="stylesheet" href="css/style.css">
</head>
<body>
<div class="view-container">
    <h1>Select Movie Record to Update</h1>

	<!-- Form which lets user select a record and then redirects to another page to make the changes. -->
    <form action="updateForm.jsp" method="get">
        <label for="movie_id">Choose a Movie ID:</label>
        <select name="movie_id" id="movie_id">
            <% for (Integer id : keys) { %>
                <option value="<%= id %>"><%= id %></option>
            <% } %>
        </select>
        <input type="submit" value="Edit Record">
    </form>
</div>
<div class="view-container">
    <hr>
    <!-- A table with all current records so they know what they are selecting from. -->
    <h2>All (Current) Movie Records</h2>

    <% if (dbError != null) { %>
        <p style="color:red;">Error fetching records: <%= dbError %></p>
    <% } else { %>
    	<!-- Create the table and header -->
        <table border="1">
            <thead>
                <tr>
                    <th>ID</th>
                    <th>Title</th>
                    <th>Genre</th>
                    <th>Director</th>
                    <th>Release Year</th>
                    <th>Rating</th>
                </tr>
            </thead>
            <!-- Using the above java code, populate the table one row at a time -->
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
