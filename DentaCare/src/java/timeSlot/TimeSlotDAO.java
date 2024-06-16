/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package timeSlot;

import dentistSchedule.DentistScheduleDTO;
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
public class TimeSlotDAO {

    public List<TimeSlotDTO> getAllTimeSLot() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        TimeSlotDTO dto = null;
        List<TimeSlotDTO> list = new ArrayList<>();
        String query = "SELECT * FROM TIMESLOT";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                int slotID = rs.getInt("slotID");
                String timePeriod = rs.getString("timePeriod");
                dto = new TimeSlotDTO(slotID, timePeriod);
                list.add(dto);
            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred: ");

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }
    
    public TimeSlotDTO getTimeSLotByID(int slotID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        TimeSlotDTO dto = null;
        String query = "SELECT * FROM TIMESLOT WHERE slotID = ? ";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, slotID);
            rs = stm.executeQuery();
            if (rs.next()) {
                String timePeriod = rs.getString("timePeriod");
                dto = new TimeSlotDTO(slotID, timePeriod);
            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred: ");

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return dto;
    }


    
}
