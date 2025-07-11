package ChristopherReaneyModule_9_Assignment;

import java.sql.*;
import java.util.ArrayList;

/*
* Assignment: Module 9
* Date: 07/11/2025
* Name: Christopher Reaney
* 
* This JavaBean handles database interactions for a MySQL movie records application.
* It provides functionality to connect to the database, insert new records,
* retrieve all records, fetch specific records by ID, update specific records, 
* and get a list of all primary keys.
*/

public class DBConnectionBean {
    // Database connection URL, username, and password
    private final String url = "jdbc:mysql://localhost:3306/CSD430";
    private final String username = "student1";
    private final String password = "pass";
    private Connection connection;

    // Constructor to establish database connection
    public DBConnectionBean() {
        try {
            Class.forName("com.mysql.cj.jdbc.Driver");
            connection = DriverManager.getConnection(url, username, password);
        } catch (Exception e) {
            e.printStackTrace(); // Log any errors
        }
    }

    // Method to get all primary keys
    public ArrayList<Integer> getAllPrimaryKeys() {
        ArrayList<Integer> keys = new ArrayList<>();
        String query = "SELECT movie_id FROM reaney_movies_data"; 
        		
        try (PreparedStatement stmt = connection.prepareStatement(query);
             ResultSet rs = stmt.executeQuery()) {
            while (rs.next()) {
                keys.add(rs.getInt("movie_id"));
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return keys;
    }

    // Method to retrieve a record by its primary key
    public ResultSet getRecordById(int id) {
        ResultSet rs = null;
        String query = "SELECT * FROM reaney_movies_data WHERE movie_id = ?";

        try {
            PreparedStatement stmt = connection.prepareStatement(query);
            stmt.setInt(1, id);
            rs = stmt.executeQuery();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return rs;
    }
    
    // Insert a new movie record using provided data fields
    public void insertRecord(String title, String genre, String director, int releaseYear, double rating) throws SQLException {
        Connection conn = getConnection();
        String sql = "INSERT INTO reaney_movies_data (title, genre, director, release_year, rating) VALUES (?, ?, ?, ?, ?)";
        PreparedStatement stmt = conn.prepareStatement(sql);
        stmt.setString(1, title);
        stmt.setString(2, genre);
        stmt.setString(3, director);
        stmt.setInt(4, releaseYear);
        stmt.setDouble(5, rating);
        stmt.executeUpdate();
        conn.close();
    }

    // Retrieve all records
    public ResultSet getAllRecords() throws SQLException {
        Connection conn = getConnection();
        Statement stmt = conn.createStatement();
        return stmt.executeQuery("SELECT * FROM reaney_movies_data");
    }
    
    // Update an existing movie record by a provided movie_id
    public void updateRecord(int movieId, String title, String genre, String director, int releaseYear, double rating) {
        String sql = "UPDATE reaney_movies_data SET title=?, genre=?, director=?, release_year=?, rating=? WHERE movie_id=?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setString(1, title);
            stmt.setString(2, genre);
            stmt.setString(3, director);
            stmt.setInt(4, releaseYear);
            stmt.setDouble(5, rating);
            stmt.setInt(6, movieId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // Method to delete a record by its movie_id
    public void deleteRecord(int movieId) {
        String sql = "DELETE FROM reaney_movies_data WHERE movie_id = ?";
        try (PreparedStatement stmt = connection.prepareStatement(sql)) {
            stmt.setInt(1, movieId);
            stmt.executeUpdate();
        } catch (SQLException e) {
            e.printStackTrace();
        }
    }
    
    // This is used internally to avoid repeated connection creation.
    private Connection getConnection() {
        return this.connection;
    }
}