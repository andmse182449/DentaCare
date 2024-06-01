/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class StaffAccountDAO {

    public List<AccountDTO> listAccountStaffClinic1(String clinicName) {
        String sql = "SELECT * FROM account a, clinic b "
                + "WHERE a.roleid = 2 AND (a.status = 0 OR a.status = 2) AND a.clinicid = b.clinicid AND b.clinicname = ?";

        List<AccountDTO> list = new ArrayList<>();
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, clinicName);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AccountDTO staff = new AccountDTO();
                    staff.setEmail(rs.getString("email"));
                    staff.setFullName(rs.getString("fullname"));
                    staff.setAddress(rs.getString("address"));
                    //staff.setDob(rs.getDate("dob").toLocalDate());
                    staff.setPhone(rs.getString("phone"));
                    staff.setUserName(rs.getString("username"));
                    list.add(staff);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }


    public List<AccountDTO> listAccountStaffRemovedClinic(String clinicName) {
        String sql = "SELECT * FROM account a, clinic b "
                + "WHERE a.roleid = 2 AND a.status = 1 AND a.clinicid = b.clinicid AND b.clinicname = ?";
        List<AccountDTO> list = new ArrayList<>();
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, clinicName);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AccountDTO staff = new AccountDTO();
                    staff.setUserName(rs.getString("username"));
                    staff.setEmail(rs.getString("email"));
                    staff.setFullName(rs.getString("fullname"));
                    staff.setAddress(rs.getString("address"));
                    //staff.setDob(rs.getDate("dob").toLocalDate());
                    staff.setPhone(rs.getString("phone"));
                    list.add(staff);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }


    public boolean updateStaffAccountUnactive(String staffUserName) {
        String sql = "update account set status = 1 where username = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, staffUserName);
            ps.execute();
        } catch (SQLException e) {
            System.out.println("updateStaffAccount: " + e.getMessage());
        }
        return true;
    }

    public boolean updateStaffAccountActive(String staffUserName) {
        String sql = "update account set status = 0 where username = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, staffUserName);
            ps.execute();
        } catch (SQLException e) {
            System.out.println("updateStaffAccountUnactive: " + e.getMessage());
        }
        return true;
    }

    public List<String> listClinicName() {
        String sql = "select clinicname from clinic group by clinicname";
        List<String> list = new ArrayList<>();
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                list.add(rs.getString("clinicname"));
            }
        } catch (SQLException ex) {
            System.out.println("listClinicName: " + ex.getMessage());
        }
        return list;
    }

}
