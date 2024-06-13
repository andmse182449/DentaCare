/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dayOffSchedule;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class DayOffScheduleDAO {
    // chua lam

    public List<DayOffScheduleDTO> getAllOffDate(int clinicID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<DayOffScheduleDTO> list = new ArrayList<>();
        String sql = "select * from DAYOFFSCHEDULE where clinicID = ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, clinicID);
            rs = stm.executeQuery();
            while (rs.next()) {
                int dayOffScheduleID = rs.getInt("dayOffScheduleID");
                String dayOff = rs.getString("dayOff");
                String description = rs.getString("description");
                clinicID = rs.getInt("clinicID");

                DayOffScheduleDTO off = new DayOffScheduleDTO(dayOffScheduleID, dayOff, description, clinicID);
                list.add(off);
            }
        } catch (SQLException e) {
            System.out.println("SQL: ");
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return list;
    }
    
    public List<DayOffScheduleDTO> getAllOffDate2() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<DayOffScheduleDTO> list = new ArrayList<>();
        String sql = "select * from DAYOFFSCHEDULE ";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int dayOffScheduleID = rs.getInt("dayOffScheduleID");
                String dayOff = rs.getString("dayOff");
                String description = rs.getString("description");
                int clinicID = rs.getInt("clinicID");

                DayOffScheduleDTO off = new DayOffScheduleDTO(dayOffScheduleID, dayOff, description, clinicID);
                list.add(off);
            }
        } catch (SQLException e) {
            System.out.println("SQL: ");
        } finally {
            if (con != null) {
                con.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (rs != null) {
                rs.close();
            }
        }
        return list;
    }
public boolean addNewOffDate(String dayOff, String description, int clinicID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("INSERT INTO DAYOFFSCHEDULE (dayOff, description, clinicID) VALUES (?, ?, ?)");
        try {
            con = DBUtils.getConnection();

            // Validate clinicID existence in CLINIC table
            if (!clinicExists(clinicID, con)) {
                System.out.println("Clinic with ID " + clinicID + " does not exist.");
                return false;
            }

            stm = con.prepareStatement(query.toString());

            stm.setString(1, dayOff);
            stm.setString(2, description);
            stm.setInt(3, clinicID);

            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0; // Return true if insertion was successful
        } catch (SQLException e) {
            System.out.println("An SQL error occurred: " + e.getMessage());
            e.printStackTrace();
        } finally {
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException ex) {
                System.out.println("An error occurred while closing resources: " + ex.getMessage());
                ex.printStackTrace();
            }
        }
        return false; // Return false if insertion failed
    }

// Helper method to check if clinicID exists in CLINIC table
    private boolean clinicExists(int clinicID, Connection con) throws SQLException {
        PreparedStatement stmt = null;
        ResultSet rs = null;
        try {
            String query = "SELECT 1 FROM CLINIC WHERE clinicID = ?";
            stmt = con.prepareStatement(query);
            stmt.setInt(1, clinicID);
            rs = stmt.executeQuery();
            return rs.next(); // Returns true if clinicID exists in CLINIC table
        } finally {
            // Close ResultSet and Statement
            if (rs != null) {
                rs.close();
            }
            if (stmt != null) {
                stmt.close();
            }
        }
    }

    public void modifyEvent(String dayOff, String description, int clinicID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.getConnection();
            String query = "UPDATE DAYOFFSCHEDULE SET description = ? WHERE dayOff = ? and clinicID = ? ";
            stm = con.prepareStatement(query);
            stm.setString(1, description);
            stm.setString(2, dayOff);
            stm.setInt(3, clinicID);
            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("An SQL error occurred: ");
            e.printStackTrace();
        } finally {
            try {
                if (stm != null) {
stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.out.println("An error occurred while closing the resources: ");
                e.printStackTrace();
            }
        }
    }
}