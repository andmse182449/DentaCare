package utils;


import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
public class DBUtils {

    public static Connection getConnection() {

        String url;
        if (instance == null || instance.trim().isEmpty()) {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + ";databaseName=" + dbName;
        } else {
            url = "jdbc:sqlserver://" + serverName + ":" + portNumber + "\\" + instance + ";databaseName=" + dbName;
        }

        try {
            Class.forName("com.microsoft.sqlserver.jdbc.SQLServerDriver");
        } catch (ClassNotFoundException ex) {
            System.out.println("DentaCare: Can not load JDBC Driver. Please check your pom file");
        }

        try {
            Connection con = DriverManager.getConnection(url, userID, password);
            return con;
        } catch (SQLException ex) {
            System.out.println("DentaCare: Can not connect SQL Server. Reason: " + ex.getMessage());
        }
        return null;
    }

    private final static String serverName = "localhost";
    private final static String dbName = "DentaCare1";
    private final static String portNumber = "1433";
    private final static String instance = "";
    private final static String userID = "sa";
    private final static String password = "12345";

}