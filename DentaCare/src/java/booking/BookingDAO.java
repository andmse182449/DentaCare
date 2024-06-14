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
import java.util.HashMap;
import java.util.List;
import java.util.Map;
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

    public List<Map<String, Object>> getTotalPriceByYearMonth(int year) {
        String sql = "SELECT\n"
                + "    YEAR(createDay) AS Year,\n"
                + "    MONTH(createDay) AS Month,\n"
                + "    SUM(price) AS TotalPrice\n"
                + "FROM\n"
                + "    dbo.BOOKING\n"
                + "where YEAR(createDay) = ? \n"
                + "GROUP BY\n"
                + "    YEAR(createDay),\n"
                + "    MONTH(createDay)\n"
                + "ORDER BY\n"
                + "    Year ASC,\n"
                + "    Month ASC;";
        Connection con = DBUtils.getConnection();
        List<Map<String, Object>> resultList = new ArrayList<>();
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setInt(1, year);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("Year", rs.getInt("Year"));
                row.put("Month", rs.getInt("Month"));
                row.put("TotalPrice", rs.getFloat("TotalPrice"));
                resultList.add(row);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return resultList;
    }

    public List<Map<String, Object>> getTotalTimeSlotsByYearMonth(int year, int month) throws SQLException {
        List<Map<String, Object>> timeResults = new ArrayList<>();
        String query = "WITH AllTimePeriods AS ( " +
                       "    SELECT DISTINCT timePeriod " +
                       "    FROM TIMESLOT " +
                       ") " +
                       "SELECT " +
                       "    ? AS Year, " +
                       "    ? AS Month, " +
                       "    COALESCE(SUM(b.slotID), 0) AS TotalTimeSlot, " +
                       "    a.timePeriod AS TimePeriod " +
                       "FROM " +
                       "    AllTimePeriods a " +
                       "    LEFT JOIN BOOKING b ON a.timePeriod = (SELECT timePeriod FROM TIMESLOT WHERE TIMESLOT.slotID = b.slotID) " +
                       "    AND YEAR(b.createDay) = ? " +
                       "    AND MONTH(b.createDay) = ? " +
                       "GROUP BY " +
                       "    a.timePeriod " +
                       "ORDER BY " +
                       "    a.timePeriod;";
        Connection con = DBUtils.getConnection();

        try {
            PreparedStatement st = con.prepareStatement(query);
            st.setInt(1, year);
            st.setInt(2, month);
            st.setInt(3, year);
            st.setInt(4, month);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                    row.put("Year", rs.getInt("Year"));
                    row.put("Month", rs.getInt("Month"));
                    row.put("TotalTimeSlot", rs.getInt("TotalTimeSlot"));
                    row.put("TimePeriod", rs.getString("TimePeriod"));
                    timeResults.add(row);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return timeResults;
    }
}
