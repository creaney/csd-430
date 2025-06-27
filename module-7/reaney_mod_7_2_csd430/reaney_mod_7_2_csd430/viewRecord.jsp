<%@ page import="java.sql.*,java.util.*,ChristopherReaneyModule7_2_Assignment.DBConnectionBean" %>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<!-- Assignment: Module 7.2 -->
<!-- Date: 06/27/2025 -->
<!-- Name: Christopher Reaney -->
<!-- This JSP file is used to view records in the DB  -->
<head>
    <meta charset="UTF-8">
    <title>Module 1: View Movie Record</title>
    <link rel="stylesheet" type="text/css" href="css/style.css">
</head>
<body>

<%
    // Instantiate the DB Bean
    DBConnectionBean dbBean = new DBConnectionBean();
    ArrayList<Integer> ids = dbBean.getAllPrimaryKeys();

    String selectedId = request.getParameter("movie_Id");
    ResultSet record = null;
    if (selectedId != null) {
        try {
            int id = Integer.parseInt(selectedId);
            record = dbBean.getRecordById(id);
        } catch (NumberFormatException e) {
            out.println("<p style='color:red;'>Invalid ID selected.</p>");
        }
    }
%>

<div class="view-container">

<h2>Module 1: View Record by ID</h2>
<p>Select a movie ID from the list to view its full record.</p>

<!-- Form for selecting movie ID -->
<form method="get" action="viewRecord.jsp">
    <label for="movie_Id">Movie ID:</label>
    <select name="movie_Id" id="movie_Id" required>
        <option value="">-- Select ID --</option>
        <%
        	//Loop through all found IDs to create options to select in the form. 
            for (int id : ids) {
                String selected = (selectedId != null && selectedId.equals(String.valueOf(id))) ? "selected" : "";
                out.println("<option value=\"" + id + "\" " + selected + ">" + id + "</option>");
            }
        %>
    </select>
    <br>
    <input type="submit" value="View Record">
</form>

<%
    // Display the selected record in table format
    if (record != null && record.next()) {
%>
    <h3>Record Details</h3>
    <!--  Create table to hold the records (if there is one, otherwise this table won't exist) -->
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
            <tr>
                <td><%= record.getInt("movie_id") %></td>
                <td><%= record.getString("title") %></td>
                <td><%= record.getString("genre") %></td>
                <td><%= record.getString("director") %></td>
                <td><%= record.getInt("release_year") %></td>
                <td><%= record.getBigDecimal("rating") %>
            </tr>
        </tbody>
    </table>
<%
	//Shouldn't really be an issue, but just an error catching statement to display when an ID isn't found
    } else if (selectedId != null) {
        out.println("<p style='color:red;'>No record found for the selected ID.</p>");
    }
%>
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
