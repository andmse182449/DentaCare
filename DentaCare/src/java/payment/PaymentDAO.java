/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package payment;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.time.LocalDate;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class PaymentDAO {
    public void createPayment(String paymentID, float amount, String orderInfo, int responseCode, String transactionNo, String bankCode, LocalDate paymentDay, String bookingID) {
    
        try {
            String sql = "INSERT INTO PAYMENT VALUES (?, ?, ?, ?, ?, ?, ?, ?)";
            Connection con = DBUtils.getConnection();
            PreparedStatement stm = con.prepareStatement(sql);
            
            stm.setString(1, paymentID);
            stm.setFloat(2, amount);
            stm.setString(3, orderInfo);
            stm.setInt(4, responseCode);
            stm.setString(5, transactionNo);
            stm.setString(6, bankCode);
            stm.setDate(7, Date.valueOf(paymentDay));
  
            stm.setString(8, bookingID);
            stm.executeUpdate();
            con.close();
        } catch (SQLException ex) {
            System.out.println("Error in servlet. Details:" + ex.getMessage());
            ex.printStackTrace();
        }
    }
}