/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package booking;

import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;
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

    public BookingDTO getBookingByID(String bookingID) {
        String sql = "SELECT * FROM BOOKING WHERE bookingID = ?";
        Connection con = DBUtils.getConnection();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, bookingID);
            ResultSet rs = stm.executeQuery();
            if (rs.next()) {

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
                BookingDTO booking = new BookingDTO(bookingID, createDay, appointmentDay, status, price, serviceID, slotID, customerID, dentistID, clinicID);
                return booking;
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return null;
    }

    public List<BookingDTO> getBookingListByCustomerID(String customerID) {
        String sql = "SELECT * FROM BOOKING WHERE customerID = ?";
        Connection con = DBUtils.getConnection();
        List<BookingDTO> list = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, customerID);
            ResultSet rs = stm.executeQuery();
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
                String dentistID = rs.getString("dentistID");
                int clinicID = rs.getInt("clinicID");
                BookingDTO booking = new BookingDTO(bookingID, createDay, appointmentDay, status, price, serviceID, slotID, customerID, dentistID, clinicID);
                list.add(booking);
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
        String query = "  SELECT clinicID, appointmentDay, slotID, COUNT(*) AS appointmentCount, status \n"
                + "  FROM BOOKING\n"
                + "  WHERE NOT status = 3\n"
                + "  GROUP BY clinicID, appointmentDay, slotID, status\n"
                + "  HAVING COUNT(*) = 3 ";
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
        String query = "  SELECT clinicID, appointmentDay, slotID, COUNT(*) AS appointmentCount, status \n"
                + "  FROM BOOKING\n"
                + "  WHERE NOT status = 3\n"
                + "  GROUP BY clinicID, appointmentDay, slotID, status\n"
                + "  HAVING COUNT(*) = 3 ";
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
        String query = "  SELECT clinicID, appointmentDay, slotID, COUNT(*) AS appointmentCount, status \n"
                + "  FROM BOOKING\n"
                + "  WHERE NOT status = 3\n"
                + "  GROUP BY clinicID, appointmentDay, slotID, status\n"
                + "  HAVING COUNT(*) = 3 ";
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

    public boolean cancelBooking(String bookingID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        String query = "UPDATE BOOKING SET status = 3 WHERE bookingID = ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, bookingID);
            int rowsUpdated = stm.executeUpdate();

            return rowsUpdated > 0;
        } catch (SQLException e) {
            System.out.println(e.getMessage());
            return false;
        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public List<BookingDTO> getBookingListByCustomerIDAndStatus(String customerID) {
        String sql = "SELECT * FROM BOOKING WHERE customerID = ? AND ((NOT status = 3) AND (NOT status = 2))";
        Connection con = DBUtils.getConnection();
        List<BookingDTO> list = new ArrayList<>();
        try {
            PreparedStatement stm = con.prepareStatement(sql);
            stm.setString(1, customerID);
            ResultSet rs = stm.executeQuery();
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
                String dentistID = rs.getString("dentistID");
                int clinicID = rs.getInt("clinicID");
                BookingDTO booking = new BookingDTO(bookingID, createDay, appointmentDay, status, price, serviceID, slotID, customerID, dentistID, clinicID);
                list.add(booking);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
    }

}
