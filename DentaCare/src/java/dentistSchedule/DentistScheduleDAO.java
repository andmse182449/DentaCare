/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dentistSchedule;

import account.AccountDTO;
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
public class DentistScheduleDAO {

    public List<DentistScheduleDTO> getAccountDentistByRoleID1() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<DentistScheduleDTO> list = new ArrayList<>();
        StringBuilder query = new StringBuilder("""
                                                select DENTISTSCHEDULE.accountID, DENTISTSCHEDULE.clinicScheduleID from DENTISTSCHEDULE 
                                                join ACCOUNT on ACCOUNT.accountID = DENTISTSCHEDULE.accountID 
                                                join clinicSchedule on CLINICSCHEDULE.clinicScheduleID = DENTISTSCHEDULE.clinicScheduleID 
                                                join CLINIC on CLINIC.clinicID = CLINICSCHEDULE.clinicID 
                                                WHERE roleID = 1""");
        try {
            String sql = null;
            sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                int clinicScheduleID = rs.getInt("clinicScheduleID");

                DentistScheduleDTO dto = new DentistScheduleDTO(accountID, clinicScheduleID);
                list.add(dto);
            }
        } catch (SQLException e) {
            System.out.println("SQL: ");
            e.printStackTrace();
        } finally {
            if (rs != null) {
                rs.close();
            }
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }

    public boolean addDenToSche(String accountID, int clinicScheduleID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO DENTISTSCHEDULE VALUES (?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, accountID);
            stm.setInt(2, clinicScheduleID);
            stm.executeUpdate();
            return true;
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
        return false;
    }

    public DentistScheduleDTO checkAlreadyDentistInDenSche(String accountID, int clinicScheduleID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DentistScheduleDTO dto = null;
        String query = "SELECT * FROM DENTISTSCHEDULE WHERE accountID = ? and clinicScheduleID = ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, accountID);
            stm.setInt(2, clinicScheduleID);
            rs = stm.executeQuery();
            while (rs.next()) {
                accountID = rs.getString("accountID");
                clinicScheduleID = rs.getInt("clinicScheduleID");

                dto = new DentistScheduleDTO(accountID, clinicScheduleID);
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

    public boolean modifyDentistSchedule(String accountID, int clinicScheduleID, String oldAccountID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.getConnection();
            String query = "UPDATE DENTISTSCHEDULE SET accountID = ? WHERE clinicScheduleID = ? and accountID = ? ";
            stm = con.prepareStatement(query);
            stm.setString(1, accountID);
            stm.setInt(2, clinicScheduleID);
            stm.setString(3, oldAccountID);
            int e = stm.executeUpdate();
            if (e > 0) {
                return true;
            }
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
        return false;
    }


}
