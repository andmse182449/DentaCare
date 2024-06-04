/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package slotDetail;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class SlotDetailDAO {

    public boolean addSlotToSchedule(int slotID, int clinicScheduleID) throws SQLException {
        String query = "INSERT INTO SlotDetail (slotID, clinicScheduleID) VALUES (?, ?) ";

        try (Connection con = DBUtils.getConnection(); PreparedStatement stm = con.prepareStatement(query)) {

            stm.setInt(1, slotID);
            stm.setInt(2, clinicScheduleID);
            stm.executeUpdate();
            return true;

        } catch (SQLException ex) {
            System.err.println("SQL Exception while adding slot to schedule:");
            ex.printStackTrace();
            return false;
        }
    }
}
