/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clinic;

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
public class ClinicDAO {

    public List<ClinicDTO> getAllClinic() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<ClinicDTO> list = new ArrayList<>();
        String sql = "select * from CLINIC";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                int clinicID = rs.getInt("clinicID");
                String clinicName = rs.getString("clinicName");
                String clinicAddress = rs.getString("clinicAddress");
                String city = rs.getString("city");
                String hotline = rs.getString("hotline");
                ClinicDTO clinic = new ClinicDTO(clinicID, clinicName, clinicAddress, city, hotline);
                list.add(clinic);
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

    public ClinicDTO getClinicByName(String clinicName) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT * FROM = CLINIC ");
        if (clinicName != null && !clinicName.isEmpty()) {
            query.append(" WHERE clinicName like ? ");
        }
        try {
            con = DBUtils.getConnection();
            String sql;
            sql = String.valueOf(query);
            stm = con.prepareStatement(sql);
            if (clinicName != null && !clinicName.isEmpty()) {
                stm.setString(1, "%" + clinicName + "%");
            }
            rs = stm.executeQuery();
            while (rs.next()) {
                int clinicID = rs.getInt("clinicID");
                clinicName = rs.getString("clinicName");
                String clinicAddress = rs.getString("clinicAddress");
                String city = rs.getString("city");
                String hotline = rs.getString("hotline");
                ClinicDTO clinic = new ClinicDTO(clinicID, clinicName, clinicAddress, city, hotline);
                return clinic;
            }
        } catch (SQLException e) {
            System.out.println("SQL: ");
            e.printStackTrace();
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
    
    public ClinicDTO getClinicByID(int clinicID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT * FROM CLINIC WHERE clinicID = ?");
        try {
            con = DBUtils.getConnection();
            String sql;
            sql = String.valueOf(query);
            stm = con.prepareStatement(sql);
            stm.setInt(1, clinicID);
            rs = stm.executeQuery();
            while (rs.next()) {
                clinicID = rs.getInt("clinicID");
                String clinicName = rs.getString("clinicName");
                String clinicAddress = rs.getString("clinicAddress");
                String city = rs.getString("city");
                String hotline = rs.getString("hotline");
                ClinicDTO clinic = new ClinicDTO(clinicID, clinicName, clinicAddress, city, hotline);
                return clinic;
            }
        } catch (SQLException e) {
            System.out.println("SQL: ");
            e.printStackTrace();
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
}
