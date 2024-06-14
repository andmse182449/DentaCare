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
import java.util.Date;
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

    public boolean UpdateProfileStaff(AccountDTO staff) {
        String sql = "UPDATE account SET username = ?, fullname = ?, phone = ?, address = ?, dob = ?, gender = ? WHERE accountId = ?";
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, staff.getUserName());
            ps.setString(2, staff.getFullName());
            ps.setString(3, staff.getPhone());
            ps.setString(4, staff.getAddress());
            ps.setDate(5, java.sql.Date.valueOf(staff.getDob()));
            ps.setBoolean(6, staff.isGender());
            ps.setString(7, staff.getAccountID());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.getMessage();
            return false;
        }
    }

    public List<AccountDTO> listNameDentist1(Date today) {
        String sql = """
                     SELECT 
                         a.accountID AS dentistID, 
                         a.fullname, 
                         COUNT(b.bookingID) AS bookingCount
                     FROM 
                         account a
                         LEFT JOIN booking b ON a.accountID = b.dentistID AND b.appointmentDay = ?
                     WHERE 
                         a.roleid = 1 
                         AND a.status = 0 
                         AND a.clinicid = 1
                     GROUP BY 
                         a.accountID, a.fullname
                     ORDER BY 
                         bookingCount;""";

        List<AccountDTO> list = new ArrayList<>();
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            java.sql.Date sqlDate = new java.sql.Date(today.getTime());
            ps.setDate(1, sqlDate);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AccountDTO dentist = new AccountDTO();
                    dentist.setAccountID(rs.getString("dentistID"));
                    dentist.setFullName(rs.getString("fullname"));
                    list.add(dentist);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public AccountDTO checkDentist(String id){
        String sql = "select fullname from account where accountid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while(rs.next()){
                AccountDTO dentist = new AccountDTO();
                dentist.setFullName(rs.getString("fullname"));
                return dentist;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

}
