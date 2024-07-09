/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package invoice;

import Service.ServiceDTO;
import account.AccountDTO;
import booking.BookingDTO;
import clinic.ClinicDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Year;
import java.util.ArrayList;
import java.util.List;
import timeSlot.TimeSlotDTO;

/**
 *
 * @author ADMIN
 */
public class InvoiceDAO {

    public InvoiceDTO getInvoice(String bookingID) {
        String sql = "select * from invoice where bookingID = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, bookingID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                InvoiceDTO invoice = new InvoiceDTO();
                invoice.setInvoiceID(rs.getString("invoiceID"));
                invoice.setInvoiceDate(rs.getDate("invoiceDay"));
                invoice.setInvoiceStatus(rs.getInt("invoicestatus"));
                return invoice;
            }
        } catch (SQLException e) {
            System.out.println("getInvoice: " + e.getMessage());
        }
        return null;
    }

    public boolean createInvoice(InvoiceDTO invoice, String bookingID) {
        String sql = "INSERT INTO invoice (invoiceID, invoiceDay, invoiceStatus, bookingID) VALUES (?, ?, ?, ?)";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, invoice.getInvoiceID());
            java.util.Date utilDate = invoice.getInvoiceDate();
            if (utilDate != null) {
                java.sql.Date sqlDate = new java.sql.Date(utilDate.getTime());
                ps.setDate(2, sqlDate);
            } else {
                ps.setDate(2, null);
            }
            ps.setInt(3, invoice.getInvoiceStatus());
            ps.setString(4, bookingID);
            ps.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("createInvoice: " + e.getMessage());
        }
        return false;
    }

    public boolean setStatusInvoice(String invoiceID) {
        String sql = "update invoice set invoiceStatus = 1 where invoiceid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, invoiceID);
            ps.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("setStatusInvoice: " + e.getMessage());
        }
        return false;
    }

    public BookingDTO getBookingClinic(String bookingID) {
        String sql = """
            SELECT 
                bookingID, createDay, appointmentDay, a.status, a.price, a.deposit, 
                customer.fullName AS customerName, customer.phone, 
                serviceName, timePeriod, dentist.fullName AS dentistName
            FROM 
                booking a
                INNER JOIN account customer ON a.customerID = customer.accountid
                LEFT JOIN account dentist ON a.dentistID = dentist.accountID
                INNER JOIN service c ON a.serviceid = c.serviceid 
                INNER JOIN timeslot d ON a.slotid = d.slotid
            WHERE 
                bookingID = ?
            """;

        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, bookingID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingDTO booking = new BookingDTO();
                booking.setBookingID(rs.getString("bookingid"));
                booking.setAppointmentDay(rs.getDate("appointmentDay").toLocalDate());
                booking.setCreateDay(rs.getDate("createday").toLocalDate());
                booking.setPrice(rs.getFloat("price"));
                booking.setDeposit(rs.getFloat("deposit"));
                booking.setStatus(rs.getInt("status"));
                booking.setFullNameDentist(rs.getString("dentistName"));
                ServiceDTO service = new ServiceDTO();
                service.setServiceName(rs.getString("servicename"));
                AccountDTO customer = new AccountDTO();
                customer.setFullName(rs.getString("customerName"));
                customer.setPhone(rs.getString("phone"));
                TimeSlotDTO timeSlot = new TimeSlotDTO();
                timeSlot.setTimePeriod(rs.getString("timePeriod"));
                booking.setService(service);
                booking.setAccount(customer);
                booking.setTimeSlot(timeSlot);
                return booking;
            }
        } catch (SQLException e) {
            System.out.println("getBookingClinic: " + e.getMessage());
        }
        return null;
    }

    public ClinicDTO getClinic(int clinicID) {
        String sql = "select * from clinic where clinicID = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, clinicID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ClinicDTO clinic = new ClinicDTO();
                clinic.setClinicID(rs.getInt("clinicid"));
                clinic.setClinicName(rs.getString("clinicname"));
                clinic.setClinicAddress(rs.getString("clinicaddress"));
                clinic.setCity(rs.getString("city"));
                clinic.setHotline(rs.getString("hotline"));
                return clinic;
            }

        } catch (SQLException e) {
            System.out.println("getClinic: " + e.getMessage());
        }
        return null;
    }

    public int maxInvoiceID() {
        String sql = "SELECT COUNT(invoiceid) AS maxID FROM invoice";
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {
            if (rs.next()) {
                return rs.getInt("maxID");
            }
        } catch (SQLException e) {
            System.out.println("maxInvoiceID: " + e.getMessage());
        }
        return 0;
    }

    public String generateInvoiceID() {
        String prefix = "IN" + Year.now().getValue(); // IN2024
        int maxID = maxInvoiceID(); // Get the max existing ID
        return prefix + String.format("%02d", ++maxID); // IN202400001
    }

}
