/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clinicSchedule;

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
public class ClinicScheduleDAO {

    public boolean addNewClinicSchedule(String workingDay, int clinicID, String description) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("INSERT INTO CLINICSCHEDULE (workingDay, clinicID, description) VALUES (?, ?, ?)");
        try {
            String sql = null;
            sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);

            stm.setString(1, workingDay);
            stm.setInt(2, clinicID);
            stm.setString(3, description);

            stm.executeUpdate();
            return true;
        } catch (SQLException e) {
            System.out.println("An SQL error occurred: ");
            e.printStackTrace();
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return false;
    }

    public List<ClinicScheduleDTO> getAllClinicSchedule() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ClinicScheduleDTO> list = new ArrayList<>();
        String sql = "select * from CLINICSCHEDULE";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int clinicScheduleID = rs.getInt("clinicScheduleID");
                String startTimeClinic = rs.getString("startTimeClinic");
                String endTimeClinic = rs.getString("endTimeClinic");
                String workingDay = rs.getString("workingDay");
                int clinicID = rs.getInt("clinicID");
                String description = rs.getString("description");
                ClinicScheduleDTO clinicSchedule = new ClinicScheduleDTO(clinicScheduleID, startTimeClinic, endTimeClinic, workingDay, clinicID, description);
                list.add(clinicSchedule);
            }
            return list;
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
        return null;
    }

    public List<ClinicScheduleDTO> getWorkingDaysByClinicId(int clinicID) throws SQLException {
    Connection con = null;
    PreparedStatement stm = null;
    ResultSet rs = null;
    List<ClinicScheduleDTO> list = new ArrayList<>();
    String sql = "SELECT workingDay FROM CLINICSCHEDULE WHERE clinicID = ?";
    try {
        con = DBUtils.getConnection();
        stm = con.prepareStatement(sql);
        stm.setInt(1, clinicID);
        rs = stm.executeQuery();
        
        while (rs.next()) {
            String workingDay = rs.getString("workingDay");
            ClinicScheduleDTO clinicSchedule = new ClinicScheduleDTO();
            clinicSchedule.setWorkingDay(workingDay);
            clinicSchedule.setClinicID(clinicID); // You might still want to set clinicID
            list.add(clinicSchedule);
        }
    } catch (SQLException e) {
        System.err.println("SQL Error: " + e.getMessage());
    } finally {
        try {
            if (rs != null) {
                rs.close();
            }
        } catch (SQLException e) {
            System.err.println("Error closing ResultSet: " + e.getMessage());
        }
        try {
            if (stm != null) {
                stm.close();
            }
        } catch (SQLException e) {
            System.err.println("Error closing PreparedStatement: " + e.getMessage());
        }
            try {
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.err.println("Error closing Connection: " + e.getMessage());
            }
        }
        return list;
    }


}
