/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package medicalRecord;

import dayOffSchedule.DayOffScheduleDTO;
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
public class MedicalRecordDAO {

    public MedicalRecordDTO checkExist(String bookingID) throws SQLException {
        String sql = "SELECT * FROM MEDIICALRECORDS "
                + "JOIN BOOKING ON BOOKING.bookingID = MEDIICALRECORDS.bookingID "
                + "WHERE BOOKING.bookingID = ?";
        try (Connection con = DBUtils.getConnection(); PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setString(1, bookingID);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    String medicalRecordID = rs.getString("medicalRecordID");
                    String results = rs.getString("results");
                    String reExanime = rs.getString("reExanime"); // Ensure this is the correct column name

                    return new MedicalRecordDTO(medicalRecordID, results, bookingID, reExanime);
                }
            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred while checking existence: " + e.getMessage());
            e.printStackTrace();
            throw e; // Optionally rethrow the exception to propagate it up the call stack
        }

        return null; // Return null if the record does not exist
    }

    public MedicalRecordDTO getResultByID(String bookingID) throws SQLException {
        String sql = "SELECT * FROM MEDIICALRECORDS "
                + "JOIN BOOKING ON BOOKING.bookingID = MEDIICALRECORDS.bookingID "
                + "WHERE BOOKING.bookingID = ?";
        try (Connection con = DBUtils.getConnection(); PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setString(1, bookingID);
            try (ResultSet rs = stm.executeQuery()) {
                if (rs.next()) {
                    String medicalRecordID = rs.getString("medicalRecordID");
                    String results = rs.getString("results");
                    String reExanime = rs.getString("reExanime"); // Ensure this is the correct column name

                    return new MedicalRecordDTO(medicalRecordID, results, bookingID, reExanime);
                }
            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred while checking existence: " + e.getMessage());
            e.printStackTrace();
            throw e; // Optionally rethrow the exception to propagate it up the call stack
        }

        return null; // Return null if the record does not exist
    }

    public boolean addNewRecord(String medicalRecordID, String results, String bookingID, String reExanime) throws SQLException {
        String query = "INSERT INTO MEDIICALRECORDS (medicalRecordID, results, bookingID, reExanime) VALUES (?, ?, ?, ?)";
        try (Connection con = DBUtils.getConnection(); PreparedStatement stm = con.prepareStatement(query)) {

            stm.setString(1, medicalRecordID);
            stm.setString(2, results);
            stm.setString(3, bookingID);
            stm.setString(4, reExanime);

            int rowsAffected = stm.executeUpdate();
            return rowsAffected > 0; // Return true if insertion was successful
        } catch (SQLException e) {
            System.out.println("An SQL error occurred: " + e.getMessage());
            e.printStackTrace();
            throw e; // Optionally rethrow the exception to propagate it up the call stack
        }
    }

    public int countRecord() {
        String sql = "SELECT COUNT(*) AS Numb FROM MEDIICALRECORDS";
        Connection con = DBUtils.getConnection();
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("Numb");
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return 0;
    }

    public void modifyEvent(String bookingID, String results, String reExanime) {
        String query = "UPDATE MEDIICALRECORDS SET results = ?, reExanime = ? WHERE bookingID = ?";
        try (Connection con = DBUtils.getConnection(); PreparedStatement stm = con.prepareStatement(query)) {

            stm.setString(1, results);
            stm.setString(2, reExanime);
            stm.setString(3, bookingID);

            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("An SQL error occurred during the update operation: " + e.getMessage());
            e.printStackTrace();
        }
    }

}
