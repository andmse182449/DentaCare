/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package booking;

import Service.ServiceDTO;
import account.AccountDTO;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
import timeSlot.TimeSlotDTO;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class BookingDAO {

    public boolean createBooking(String bookingID, LocalDate createDay, LocalDate appointmentDay, float price, int serviceID, int slotID,
            String customerID, String dentistID, int clinicID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO BOOKING VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, bookingID);
            stm.setDate(2, Date.valueOf(createDay));
            stm.setDate(3, Date.valueOf(appointmentDay));
            stm.setInt(4, 0);
            stm.setFloat(5, price);
            stm.setInt(6, serviceID);
            stm.setInt(7, slotID);
            stm.setString(8, customerID);
            if (dentistID == null || dentistID.equals("")) {
                stm.setString(9, null);
            } else {
                stm.setString(9, dentistID);
            }
            stm.setInt(10, clinicID);

            if (stm.executeUpdate() != 0) {
                return true;
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

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

    public List<BookingDTO> getAllBookingList() {
        String sql = "SELECT * FROM BOOKING";
        Connection con = DBUtils.getConnection();
        List<BookingDTO> list = new ArrayList<>();
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                String bookingID = rs.getString("bookingID");

                LocalDate createDay = null;
                java.sql.Date cdSql = rs.getDate("createDay");
                if (cdSql != null) {
                    createDay = cdSql.toLocalDate();
                }

                LocalDate appointmentDay = null;
                java.sql.Date apSql = rs.getDate("appointmentDay");
                if (apSql != null) {
                    appointmentDay = apSql.toLocalDate();
                }

                int status = rs.getInt("status");
                float price = rs.getFloat("price");
                int serviceID = rs.getInt("serviceID");
                int slotID = rs.getInt("slotID");
                String customerID = rs.getString("customerID");
                String dentistID = rs.getString("dentistID");
                int clinicID = rs.getInt("clinicID");
                list.add(new BookingDTO(bookingID, createDay, appointmentDay, status, price, serviceID, slotID, customerID, dentistID, clinicID));
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

    public int countBooking() {
        String sql = "SELECT COUNT(*) AS Numb FROM BOOKING";
        Connection con = DBUtils.getConnection();
        try {
            PreparedStatement st = con.prepareStatement(sql);
            ResultSet rs = st.executeQuery();
            if (rs.next()) {
                return rs.getInt("Numb");
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return 0;
    }

    public List<Integer> getClinicIDLimitBooking() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Integer> clinicIDs = new ArrayList<>();
        String query = "SELECT clinicID, appointmentDay, slotID, COUNT(*) AS appointmentCount\n"
                + "FROM BOOKING\n"
                + "GROUP BY clinicID, appointmentDay, slotID\n"
                + "HAVING COUNT(*) = 3;";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                clinicIDs.add(rs.getInt("clinicID"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
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
        return clinicIDs;
    }

    public List<Date> getDayLimitBooking() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Date> appointmentDays = new ArrayList<>();
        String query = "SELECT clinicID, appointmentDay, slotID, COUNT(*) AS appointmentCount\n"
                + "FROM BOOKING\n"
                + "GROUP BY clinicID, appointmentDay, slotID\n"
                + "HAVING COUNT(*) = 3;";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                appointmentDays.add(rs.getDate("appointmentDay"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
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
        return appointmentDays;
    }

    public List<Integer> getSlotIDLimitBooking() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<Integer> slotIDs = new ArrayList<>();
        String query = "SELECT clinicID, appointmentDay, slotID, COUNT(*) AS appointmentCount\n"
                + "FROM BOOKING\n"
                + "GROUP BY clinicID, appointmentDay, slotID\n"
                + "HAVING COUNT(*) = 3;";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                slotIDs.add(rs.getInt("slotID"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
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
        return slotIDs;
    }

    public List<BookingDTO> getAllBookingClinic1() {
    String sql = """
            SELECT 
                bookingID, createDay, appointmentDay, a.status, a.price, 
                customer.fullName AS customerName, customer.phone, 
                serviceName, timePeriod, dentist.fullName AS dentistName
            FROM 
                booking a
                INNER JOIN account customer ON a.customerID = customer.accountid
                LEFT JOIN account dentist ON a.dentistID = dentist.accountID
                INNER JOIN service c ON a.serviceid = c.serviceid 
                INNER JOIN timeslot d ON a.slotid = d.slotid
            WHERE 
                a.clinicID = 1
            ORDER BY 
                appointmentDay, timePeriod;
            """;

    List<BookingDTO> list = new ArrayList<>();
    try {
        Connection con = utils.DBUtils.getConnection();
        PreparedStatement ps = con.prepareStatement(sql);
        ResultSet rs = ps.executeQuery();
        while (rs.next()) {
            BookingDTO booking = new BookingDTO();
            booking.setBookingID(rs.getString("bookingid"));
            booking.setAppointmentDay(rs.getDate("appointmentDay").toLocalDate());
            booking.setCreateDay(rs.getDate("createday").toLocalDate());
            booking.setPrice(rs.getFloat("price"));
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
            list.add(booking);
        }
        return list;
    } catch (SQLException e) {
        System.out.println("getAllBookingClinic1: " + e.getMessage());
    }
    return null;
}


    public boolean assignDentist(int bookingID, String dentistID) {
        String sql = "update booking set dentistID = ?, status = 1 where bookingID = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, dentistID);
            ps.setInt(2, bookingID);
            ps.executeQuery();
            return true;
        } catch (SQLException e) {
            System.out.println("assignDentist " + e.getMessage());
            return false;
        }
    }

}
