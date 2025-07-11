<%@ page import="java.sql.*" %>
<jsp:useBean id="db" class="ChristopherReaneyModule_9_Assignment.DBConnectionBean" scope="page" />
<%
	// Assignment: Module 9
	// Date: 07/11/2025
	// Name: Christopher Reaney
	// This JSP page is used to process the previously selected record for deletion. 
	//	It passes the value of the selected movie ID over to the DBConnectionBean
	//	Then the user is redirected back to the delete record selection page.

    // Get selected movie ID from the form
    String movieIdStr = request.getParameter("movieId");

    if (movieIdStr != null && !movieIdStr.trim().equals("")) {
        int movieId = Integer.parseInt(movieIdStr);
    	// Call to JavaBean method to handle the actual deletion
        db.deleteRecord(movieId); 
    }

    // Redirect back to deleteRecord.jsp to refresh list
    response.sendRedirect("deleteRecord.jsp");
%>