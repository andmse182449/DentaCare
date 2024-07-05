/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package account;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
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
        String sql = "UPDATE account SET username = ?, fullname = ?, phone = ?, address = ?, dob = ?, gender = ?, image = ? WHERE accountId = ?";
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, staff.getUserName());
            ps.setString(2, staff.getFullName());
            ps.setString(3, staff.getPhone());
            ps.setString(4, staff.getAddress());
            ps.setDate(5, java.sql.Date.valueOf(staff.getDob()));
            ps.setBoolean(6, staff.isGender());
            ps.setString(7, staff.getImage());
            ps.setString(8, staff.getAccountID());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.getMessage();
            return false;
        }
    }

    public List<AccountDTO> listNameDentist1(Date today, int clinicID) {
        String sql = """
                 SELECT 
                         a.accountID AS dentistID, 
                         a.fullname, 
                         COUNT(DISTINCT b.bookingID) AS bookingCount,
                         (SELECT COUNT(DISTINCT n.medicalRecordID)
                          FROM MEDIICALRECORDS n
                          WHERE n.reExanime = ? 
                          AND n.bookingID IN (SELECT b2.bookingID 
                                              FROM booking b2
                                              WHERE b2.dentistID = a.accountID)) AS medicalCount,
                         (COUNT(DISTINCT b.bookingID) +
                          (SELECT COUNT(DISTINCT n.medicalRecordID)
                           FROM MEDIICALRECORDS n
                           WHERE n.reExanime = ? 
                           AND n.bookingID IN (SELECT b2.bookingID 
                                               FROM booking b2 
                                               WHERE b2.dentistID = a.accountID))) AS totalCount
                     FROM 
                         account a
                         LEFT JOIN booking b ON a.accountID = b.dentistID AND b.appointmentDay = ?
                         RIGHT JOIN DENTISTSCHEDULE b3 ON b3.accountID = a.accountID AND b3.workingDate = ?
                     WHERE 
                         a.roleID = 1 
                         AND a.status = 0 
                         AND a.clinicID = ?
                     GROUP BY 
                         a.accountID, a.fullname
                     ORDER BY 
                         totalCount 
                 """;

        List<AccountDTO> list = new ArrayList<>();
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            java.sql.Date sqlDate = new java.sql.Date(today.getTime());
            ps.setDate(1, sqlDate);
            ps.setDate(2, sqlDate);
            ps.setDate(3, sqlDate);
            ps.setDate(4, sqlDate);
            ps.setInt(5, clinicID);

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

    public AccountDTO checkDentist(String id) {
        String sql = "select fullname from account where accountid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, id);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                AccountDTO dentist = new AccountDTO();
                dentist.setFullName(rs.getString("fullname"));
                return dentist;
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return null;
    }

    public List<AccountDTO> listAccount(int roleID, int status) {
        String sql = "SELECT * FROM account where roleid = ? and status = ?";

        List<AccountDTO> list = new ArrayList<>();
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setInt(1, roleID);
            ps.setInt(2, status);
            try (ResultSet rs = ps.executeQuery()) {
                while (rs.next()) {
                    AccountDTO account = new AccountDTO();
                    account.setAccountID(rs.getString("accountid"));
                    account.setEmail(rs.getString("email"));
                    account.setFullName(rs.getString("fullname"));
                    account.setAddress(rs.getString("address"));
                    java.sql.Date dob = rs.getDate("dob");
                    if (dob != null) {
                        account.setDob(dob.toLocalDate());
                    } else {
                        account.setDob(null);
                    }
                    account.setPhone(rs.getString("phone"));
                    account.setUserName(rs.getString("username"));
                    account.setGender(rs.getBoolean("gender"));
                    list.add(account);
                }
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }

    public double getRevenue(Date today) {
        String sql = "SELECT SUM(price) AS revenue FROM booking WHERE appointmentday = ? and status = 2";
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            java.sql.Date sqlDate = new java.sql.Date(today.getTime());
            ps.setDate(1, sqlDate);
            try (ResultSet rs = ps.executeQuery()) {
                if (rs.next()) {
                    return rs.getDouble("revenue");
                }
            }
        } catch (SQLException e) {
            System.out.println("Error in getRevenue: " + e.getMessage());
        }
        return 0;
    }

    public List<LocalDate> getPreviousDaysInCurrentMonth(LocalDate targetDate) {
        List<LocalDate> dates = new ArrayList<>();
        LocalDate startDate = targetDate.minusDays(10);

        for (LocalDate date = startDate; date.isBefore(targetDate); date = date.plusDays(1)) {
            dates.add(date);
        }

        return dates;
    }

}
