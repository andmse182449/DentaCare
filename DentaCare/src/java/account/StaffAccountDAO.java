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
    public List<AccountDTO> listAccountStaff(){
        String sql = "select * from account where roleid = 3 and accountstatus = 1";
        List<AccountDTO> list = new ArrayList<>();
        try {
            Connection con = utils.DBUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();
             while(rs.next()){
                 AccountDTO staff = new AccountDTO();
                 staff.setEmail(rs.getString("email"));
                 staff.setFullName(rs.getString("fullname"));
                 staff.setAddress(rs.getString("address"));
                 staff.setDob(rs.getDate("dob").toLocalDate());
                 staff.setPhone(rs.getString("phone"));
                 staff.setUserName(rs.getString("username"));
                 list.add(staff);
             }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
     public List<AccountDTO> listAccountStaffRemoved(){
        String sql = "select * from account where roleid = 3 and accountstatus = 0";
        List<AccountDTO> list = new ArrayList<>();
        try {
            Connection con = utils.DBUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();
             while(rs.next()){
                 AccountDTO staff = new AccountDTO();
                 staff.setUserName(rs.getString("username"));
                 staff.setEmail(rs.getString("email"));
                 staff.setFullName(rs.getString("fullname"));
                 staff.setAddress(rs.getString("address"));
                 staff.setDob(rs.getDate("dob").toLocalDate());
                 staff.setPhone(rs.getString("phone"));
                 list.add(staff);
             }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return list;
    }
    
    public boolean updateStaffAccountUnactive(String staffAccountId){
        String sql = "update account set statusAccount = 1 where accountid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, staffAccountId);
            ps.execute();
        } catch (SQLException e) {
            System.out.println("updateStaffAccount: " + e.getMessage());
        }
        return true;
    }
     public boolean updateStaffAccountActive(String staffAccountId){
        String sql = "update account set statusAccount = 0 where accountid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, staffAccountId);
            ps.execute();
        } catch (SQLException e) {
            System.out.println("updateStaffAccountUnactive: " + e.getMessage());
        }
        return true;
    }
     
      public AccountDTO accountStaff(String staffAccountId){
        String sql = "select * from account where accountid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
             PreparedStatement ps = con.prepareStatement(sql);
             ResultSet rs = ps.executeQuery();
             while(rs.next()){
                 AccountDTO staff = new AccountDTO();
                 staff.setEmail(rs.getString("email"));
                 staff.setFullName(rs.getString("fullname"));
                 staff.setAddress(rs.getString("address"));
                 staff.setDob(rs.getDate("dob").toLocalDate());
                 staff.setPhone(rs.getString("phone"));
                 staff.setUserName(rs.getString("username"));
                 return staff;
             }
        } catch (SQLException e) {
            System.out.println("Account staff: "+e.getMessage());
        }
       return null;
    }
     
     
}
