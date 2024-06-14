/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dentistSchedule;

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
                                                    select DENTISTSCHEDULE.*, ACCOUNT.fullName from DENTISTSCHEDULE 
                                                    join ACCOUNT on ACCOUNT.accountID = DENTISTSCHEDULE.accountID 
                                                    WHERE roleID = 1
                                                """);
        try {
            String sql = null;
            sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int dentistScheduleID = rs.getInt("dentistScheduleID");
                String accountID = rs.getString("accountID");
                String workingDate = rs.getString("workingDate");
                DentistScheduleDTO dto = new DentistScheduleDTO(dentistScheduleID, accountID, workingDate);
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

    public List<DentistScheduleDTO> getForDenList(String accountID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<DentistScheduleDTO> list = new ArrayList<>();
        StringBuilder query = new StringBuilder("""
                                                select ACCOUNT.accountID, ACCOUNT.fullName, DENTISTSCHEDULE.workingDate from DENTISTSCHEDULE
                                                                                                join ACCOUNT on ACCOUNT.accountID = DENTISTSCHEDULE.accountID 
                                                                                                WHERE DENTISTSCHEDULE.accountID = ?
                                                """);
        try {
            String sql = null;
            sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, accountID);
            rs = stm.executeQuery();
            while (rs.next()) {
                int dentistScheduleID = rs.getInt("dentistScheduleID");
                accountID = rs.getString("accountID");
                String workingDate = rs.getString("workingDate");

                DentistScheduleDTO dto = new DentistScheduleDTO(dentistScheduleID, accountID, workingDate);
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

    public boolean addDenToSche(String accountID, String workingDate) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO DENTISTSCHEDULE VALUES (?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, accountID);
            stm.setString(2, workingDate);
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

    public DentistScheduleDTO checkAlreadyDentistInDenSche(String accountID, String workingDate) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DentistScheduleDTO dto = null;
        String query = "SELECT * FROM DENTISTSCHEDULE WHERE accountID = ? and workingDate = ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, accountID);
            stm.setString(2, workingDate);
            rs = stm.executeQuery();
            while (rs.next()) {
                int dentistScheduleID = rs.getInt("dentistScheduleID");
                accountID = rs.getString("accountID");
                workingDate = rs.getString("workingDate");

                dto = new DentistScheduleDTO(dentistScheduleID, accountID, workingDate);

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

    public List<DentistScheduleDTO> getDenFromDate(String workingDate) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DentistScheduleDTO dto = null;
        List<DentistScheduleDTO> list = new ArrayList<>();
        String query = "SELECT * FROM DENTISTSCHEDULE WHERE workingDate = ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, workingDate);
            rs = stm.executeQuery();
            while (rs.next()) {
                int dentistScheduleID = rs.getInt("dentistScheduleID");
                String accountID = rs.getString("accountID");
                workingDate = rs.getString("workingDate");

                dto = new DentistScheduleDTO(dentistScheduleID, accountID, workingDate);
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

    public List<DentistScheduleDTO> checkSesssionDen(String accountID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        DentistScheduleDTO dto = null;
        List<DentistScheduleDTO> list = new ArrayList<>();
        String query = " SELECT * FROM DENTISTSCHEDULE WHERE accountID = ? ";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, accountID);
            rs = stm.executeQuery();
            while (rs.next()) {
                int dentistScheduleID = rs.getInt("dentistScheduleID");
                accountID = rs.getString("accountID");
                String workingDate = rs.getString("workingDate");

                dto = new DentistScheduleDTO(dentistScheduleID, accountID, workingDate);
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

    public boolean modifyDentistSchedule(String accountID, String workingDate, String oldAccountID) {
        Connection con = null;
        PreparedStatement stm = null;
        try {
            con = DBUtils.getConnection();
            String query = "UPDATE DENTISTSCHEDULE SET accountID = ? WHERE workingDate = ? and accountID = ? ";
            stm = con.prepareStatement(query);
            stm.setString(1, accountID);
            stm.setString(2, workingDate);
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
