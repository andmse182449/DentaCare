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
import timeSlot.TimeSlotDTO;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import medicalRecord.MedicalRecordDAO;
import medicalRecord.MedicalRecordDTO;
import utils.DBUtils;

/**
 *
 * @author Admin
 */
public class BookingDAO {

    public boolean createBooking(String bookingID, LocalDate createDay, LocalDate appointmentDay, float price,
            int serviceID, int slotID,
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
                list.add(new BookingDTO(bookingID, createDay, appointmentDay, status, price, serviceID, slotID,
                        customerID, dentistID, clinicID));
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
                BookingDTO booking = new BookingDTO(bookingID, createDay, appointmentDay, status, price, serviceID,
                        slotID, customerID, dentistID, clinicID);
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
                BookingDTO booking = new BookingDTO(bookingID, createDay, appointmentDay, status, price, serviceID,
                        slotID, customerID, dentistID, clinicID);
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
                BookingDTO booking = new BookingDTO(bookingID, createDay, appointmentDay, status, price, serviceID,
                        slotID, customerID, dentistID, clinicID);
                list.add(booking);
            }
        } catch (SQLException ex) {
            System.out.println(ex);
        }
        return list;
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

    public boolean updateExpiredDate(String bookingID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;

        String query = "UPDATE BOOKING SET status = 4 WHERE bookingID = ?";
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

    public List<BookingDTO> getAllBookingClinic(int clinicID, String fullName) {
        String sql = """
                SELECT
                    bookingID, customerID, createDay, appointmentDay, a.status, a.price,
                    customer.fullName AS customerName, customer.phone,
                    serviceName, timePeriod, dentist.fullName AS dentistName
                FROM
                    booking a
                    INNER JOIN account customer ON a.customerID = customer.accountid
                    LEFT JOIN account dentist ON a.dentistID = dentist.accountID
                    INNER JOIN service c ON a.serviceid = c.serviceid
                    INNER JOIN timeslot d ON a.slotid = d.slotid
                WHERE
                    a.clinicID = ? and customer.fullName like ?
                ORDER BY
                    appointmentDay, timePeriod;
                """;

        List<BookingDTO> list = new ArrayList<>();
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, clinicID);
            ps.setString(2, "%" + fullName + "%");
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingDTO booking = new BookingDTO();
                booking.setBookingID(rs.getString("bookingid"));
                booking.setCustomerID(rs.getString("customerid"));
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

   public List<BookingDTO> getAllBookingCustomer(String customerID) {
        String sql = """
              SELECT 
                bookingID, a.clinicID, customerID, createDay, appointmentDay, a.status, a.price, 
                customer.fullName AS customerName, customer.phone, 
                serviceName, timePeriod, dentist.fullName AS dentistName
                            FROM 
                booking as a
                INNER JOIN account customer ON a.customerID = customer.accountid
                LEFT JOIN account dentist ON a.dentistID = dentist.accountID
                INNER JOIN service c ON a.serviceid = c.serviceid 
                INNER JOIN timeslot d ON a.slotid = d.slotid
                            WHERE 
                customerID = ?
            """;

        List<BookingDTO> list = new ArrayList<>();
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, customerID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                BookingDTO booking = new BookingDTO();
                booking.setBookingID(rs.getString("bookingid"));
                booking.setClinicID(rs.getInt("clinicID"));
                booking.setCustomerID(rs.getString("customerid"));
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
            System.out.println("getAllBookingCustomer: " + e.getMessage());
        }
        return null;
    }

   public List<BookingDTO> getAllBookingByIdAndDayForDen(String dentistID) {
        String sql = """
            SELECT * from BOOKING where dentistID = ?
            """;

        List<BookingDTO> list = new ArrayList<>();
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, dentistID);
            ResultSet rs = ps.executeQuery();
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
                dentistID = rs.getString("dentistID");
                int clinicID = rs.getInt("clinicID");
                BookingDTO booking = new BookingDTO(bookingID, createDay, appointmentDay, status, price, serviceID, slotID, customerID, dentistID, clinicID);
                list.add(booking);
            }
            return list;
        } catch (SQLException e) {
            System.out.println("getAllBookingClinic1: " + e.getMessage());
        }
        return null;
    }

   public List<Map<String, Object>> getAllBookingForDen2(String dentistID, String appointmentDay) throws SQLException {
        List<Map<String, Object>> results = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBUtils.getConnection();
            String sql = """
        SELECT 
            bookingID, createDay, appointmentDay, a.status, a.price, 
            customer.fullName AS customerName, 
            serviceName, timePeriod, dentist.fullName AS dentistName
        FROM 
            booking a
            INNER JOIN account customer ON a.customerID = customer.accountid
            LEFT JOIN account dentist ON a.dentistID = dentist.accountID
            INNER JOIN service c ON a.serviceid = c.serviceid 
            INNER JOIN timeslot d ON a.slotid = d.slotid
        WHERE 
            a.dentistID = ? and a.appointmentDay = ?
        ORDER BY 
            appointmentDay, timePeriod;
        """;
            statement = connection.prepareStatement(sql);
            statement.setString(1, dentistID);
            statement.setString(2, appointmentDay);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                Map<String, Object> result = new HashMap<>();
                result.put("bookingID", resultSet.getString("bookingID"));
                result.put("createDay", resultSet.getDate("createDay").toLocalDate().toString());
                result.put("appointmentDay", resultSet.getDate("appointmentDay").toLocalDate().toString());
                result.put("status", resultSet.getInt("status"));
                result.put("price", resultSet.getFloat("price"));
                result.put("customerName", resultSet.getString("customerName"));
                result.put("serviceName", resultSet.getString("serviceName"));
                result.put("timePeriod", resultSet.getString("timePeriod"));
                result.put("dentistName", resultSet.getString("dentistName"));

                results.add(result);
            }
        } finally {
            if (resultSet != null) {
                resultSet.close();
            }
            if (statement != null) {
                statement.close();
            }
            if (connection != null) {
                connection.close();
            }
        }

        return results;
    }

    public boolean assignDentist(String bookingID, String dentistID) {
        String sql = "update booking set dentistID = ?, status = 1 where bookingID = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, dentistID);
            ps.setString(2, bookingID);
            ps.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("assignDentist " + e.getMessage());
            return false;
        }
    }

    public boolean updateStatusBookingComplete(String bookingID, int status) {
        String sql = "update booking set  status = ? where bookingID = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, status);
            ps.setString(2, bookingID);
            ps.execute();
            return true;
        } catch (SQLException e) {
            System.out.println("updateStatusBookingComplete " + e.getMessage());
            return false;
        }
    }

    public List<Map<String, Object>> getTotalTimeSlotsByYearMonth(int year, int month) throws SQLException {
        List<Map<String, Object>> timeResults = new ArrayList<>();
        String query = "WITH AllTimePeriods AS ( "
                + "    SELECT DISTINCT timePeriod "
                + "    FROM TIMESLOT "
                + ") "
                + "SELECT "
                + "    ? AS Year, "
                + "    ? AS Month, "
                + "    COALESCE(SUM(b.slotID), 0) AS TotalTimeSlot, "
                + "    a.timePeriod AS TimePeriod "
                + "FROM "
                + "    AllTimePeriods a "
                + "    LEFT JOIN BOOKING b ON a.timePeriod = (SELECT timePeriod FROM TIMESLOT WHERE TIMESLOT.slotID = b.slotID) "
                + "    AND YEAR(b.createDay) = ? "
                + "    AND MONTH(b.createDay) = ? "
                + "GROUP BY "
                + "    a.timePeriod "
                + "ORDER BY "
                + "    a.timePeriod;";
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

public List<Map<String, Object>> getAccountInfosByDentistID(String dentistID) throws SQLException {
        List<Map<String, Object>> bookingDetailsList = new ArrayList<>();
        String sql = """
                     SELECT acc.email, acc.fullName, acc.phone, 
                                       acc.address, acc.dob, acc.gender, acc.image, s.timePeriod, se.serviceName 
                                       FROM ACCOUNT AS acc 
                                       JOIN BOOKING AS b ON acc.accountID = b.customerID 
                                        JOIN TIMESLOT as s on s.slotID = b.slotID 
                               		JOIN SERVICE as se on se.serviceID = b.serviceID 
                                        WHERE b.dentistID = ? 
                                        AND (b.status = 2 OR b.status = 1)""";
        Connection con = DBUtils.getConnection();
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, dentistID);
            ResultSet rs = st.executeQuery();
            while (rs.next()) {
                Map<String, Object> row = new HashMap<>();
                row.put("email", rs.getString("email"));
                row.put("fullName", rs.getString("fullName"));
                row.put("phone", rs.getString("phone"));
                row.put("address", rs.getString("address"));
                row.put("dob", rs.getDate("dob"));
                row.put("gender", rs.getString("gender"));
                row.put("image", rs.getString("image"));
                row.put("timePeriod", rs.getString("timePeriod"));
                row.put("serviceName", rs.getString("serviceName"));
                bookingDetailsList.add(row);
            }

        } catch (SQLException e) {
            throw new SQLException("Error fetching booking details", e);
        }
        return bookingDetailsList;
    }
    public List<BookingDTO> getBookingListByDenID(String dentistID) {
        String sql = "SELECT \n"
                + "            a.bookingID, createDay, appointmentDay, a.status, a.price, \n"
                + "            customer.fullName AS customerName, \n"
                + "            serviceName, timePeriod, dentist.email, dentist.fullName AS dentistName, medi.results, medi.reExanime\n"
                + "        FROM \n"
                + "            booking a\n"
                + "            INNER JOIN account customer ON a.customerID = customer.accountid\n"
                + "            LEFT JOIN account dentist ON a.dentistID = dentist.accountID\n"
                + "            INNER JOIN service c ON a.serviceid = c.serviceid \n"
                + "            INNER JOIN timeslot d ON a.slotid = d.slotid\n"
                + "			LEFT JOIN MEDIICALRECORDS medi on medi.bookingID = a.bookingID\n"
                + "        WHERE \n"
                + "            a.dentistID = ? \n"
                + "			and (a.status = 2 or a.status = 1)\n"
                + "        ORDER BY \n"
                + "            appointmentDay, timePeriod;";

        List<BookingDTO> list = new ArrayList<>();
        try (Connection con = DBUtils.getConnection(); PreparedStatement stm = con.prepareStatement(sql)) {

            stm.setString(1, dentistID);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                BookingDTO booking = new BookingDTO();
                booking.setBookingID(rs.getString("bookingID"));
                booking.setAppointmentDay(rs.getDate("appointmentDay").toLocalDate());
                booking.setCreateDay(rs.getDate("createDay").toLocalDate());
                booking.setPrice(rs.getFloat("price"));
                booking.setStatus(rs.getInt("status"));
                booking.setFullNameDentist(rs.getString("dentistName"));

                ServiceDTO service = new ServiceDTO();
                service.setServiceName(rs.getString("serviceName"));
                booking.setService(service);

                AccountDTO customer = new AccountDTO();
                customer.setFullName(rs.getString("customerName"));
                booking.setAccount(customer);

                TimeSlotDTO timeSlot = new TimeSlotDTO();
                timeSlot.setTimePeriod(rs.getString("timePeriod"));
                booking.setTimeSlot(timeSlot);

                String results = rs.getString("results");
                String reExamine = rs.getString("reExanime");
                if (results != null || reExamine != null) {
                    MedicalRecordDTO meDTO = new MedicalRecordDTO();
                    meDTO.setResults(results);
                    meDTO.setReExanime(reExamine);
                    booking.setMedicalRecord(meDTO);
                }

                list.add(booking);
            }
        } catch (SQLException ex) {
            ex.printStackTrace();
        }
        return list;
    }

}
