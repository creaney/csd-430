<%@ page language="java" import="java.util.*, java.sql.*" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<jsp:useBean id="db" class="ChristopherReaneyModule_9_Assignment.DBConnectionBean" scope="page" />
<!DOCTYPE html>
<html>
<!-- 
    Assignment: Module 9
    Author: Christopher Reaney
    Date: 07/11/2025
    This JSP file is used to display all records in a table and allow user to select a movie ID to delete. It then
    passes that value to the deleteProcess page on submit. 
-->
<head>
    <meta charset="UTF-8">
    <title>Delete Movie Record - Module 4</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<h1>Module 4: Delete Movie Record</h1>
<p>Select a Movie ID from the dropdown below to delete a record. Remaining records will be displayed after deletion.</p>

<%
    // Retrieve all records and primary keys using JavaBean
    ResultSet rs = db.getAllRecords();
    ArrayList<Integer> keys = db.getAllPrimaryKeys();
%>

<!-- Form to select Movie ID for deletion -->
<% if (keys.size() > 0) { %>
    <div class="view-container">
        <form action="deleteProcess.jsp" method="post">
            <label for="movieId">Select Movie ID to Delete:</label>
            <select name="movieId" id="movieId" required>
                <%
                    for (Integer id : keys) {
                %>
                    <option value="<%= id %>"><%= id %></option>
                <%
                    }
                %>
            </select>
            <input type="submit" value="Delete Selected Record">
        </form>
    </div>
<% } else { %>
    <div class="view-container">
        <p>No records available for deletion.</p>
    </div>
<% } %>

<!-- Display Table with Movie Records -->
<table border="1">
    <thead>
        <tr>
            <th>Movie ID</th>
            <th>Title</th>
            <th>Genre</th>
            <th>Director</th>
            <th>Release Year</th>
            <th>Rating</th>
        </tr>
    </thead>
    <tbody>
    <%
        // Check if records exist
        boolean hasRecords = false;
        while (rs.next()) {
            hasRecords = true;
    %>
        <tr>
            <td><%= rs.getInt("movie_id") %></td>
            <td><%= rs.getString("title") %></td>
            <td><%= rs.getString("genre") %></td>
            <td><%= rs.getString("director") %></td>
            <td><%= rs.getInt("release_year") %></td>
            <td><%= rs.getDouble("rating") %></td>
        </tr>
    <%
        }
        if (!hasRecords) {
    %>
        <tr>
            <td colspan="6" style="text-align:center;">No records found in the database.</td>
        </tr>
    <%
        }
        rs.close();
    %>
    </tbody>
</table>

<!-- Footer -->
<footer>
    <p>Student: Christopher Reaney | Course: CSD430 | Instructor: Darrell Payne</p>
	<div class="footer-link">
		<a href="index.jsp">Back to index</a>
	</div>
</footer>

</body>
</html>
