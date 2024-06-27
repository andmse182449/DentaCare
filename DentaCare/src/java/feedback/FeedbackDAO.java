package feedback;

import java.sql.Timestamp;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.Duration;
import java.util.ArrayList;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import utils.DBUtils;

/**
 *
 * @author ROG STRIX
 */
public class FeedbackDAO {

    public List<FeedbackDTO> getListByPage(ArrayList<FeedbackDTO> list,
            int start, int end) {
        ArrayList<FeedbackDTO> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    private static long calculateMinutesAgo(LocalDateTime pastDateTime) {
        LocalDateTime now = LocalDateTime.now();
        Duration duration = Duration.between(pastDateTime, now);
        return duration.toMinutes();
    }

    private static String formatTimeAgo(LocalDateTime pastDateTime, long minutesAgo) {
        LocalDateTime now = LocalDateTime.now();

        // Calculate the difference in years, months, and days
        long yearsAgo = now.getYear() - pastDateTime.getYear();
        long monthsAgo = now.getMonthValue() - pastDateTime.getMonthValue();
        long daysAgo = now.getDayOfMonth() - pastDateTime.getDayOfMonth();

        if (yearsAgo > 0) {
            // More than a year ago
            return yearsAgo + " year" + (yearsAgo > 1 ? "s" : "") + " ago";
        } else if (monthsAgo > 0) {
            // Between 1 month and 1 year ago
            return monthsAgo + " month" + (monthsAgo > 1 ? "s" : "") + " ago";
        } else if (daysAgo > 0) {
            // Between 1 day and 1 month ago
            return daysAgo + " day" + (daysAgo > 1 ? "s" : "") + " ago";
        } else if (minutesAgo < 60) {
            // Less than an hour ago
            return minutesAgo + " minute" + (minutesAgo > 1 ? "s" : "") + " ago";
        } else {
            // Less than a day ago
            long hoursAgo = minutesAgo / 60;
            return hoursAgo + " hour" + (hoursAgo > 1 ? "s" : "") + " ago";
        }
    }

    public List<FeedbackDTO> getAllFeedbacks(String rw_accountID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        FeedbackDTO dto = null;
        List<FeedbackDTO> list = new ArrayList<>();
        String query = "SELECT feedbackID, feedbackDay, feedbackContent, fullName, bookingID FROM FEEDBACK fb join ACCOUNT ac on fb.accountID = ac.accountID ORDER BY CASE WHEN ac.accountID = ? THEN 0 ELSE 1 END, feedbackDay DESC;";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, rw_accountID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String feedbackID = rs.getString("feedbackID");
                LocalDateTime feedbackDay = rs.getTimestamp("feedbackDay").toLocalDateTime();
                String feedbackContent = rs.getString("feedbackContent");
                String fullName = rs.getString("fullName");
                String bookingID = rs.getString("bookingID");

                LocalDateTime pastDateTime = LocalDateTime.parse(feedbackDay.toString(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                long minutesAgo = calculateMinutesAgo(pastDateTime);
                String timeAgo = formatTimeAgo(pastDateTime, minutesAgo);

                dto = new FeedbackDTO(feedbackID, timeAgo, feedbackContent, fullName, bookingID);
                list.add(dto);
            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred: ");

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }

    public boolean addComment(String feedbackID, LocalDateTime feedbackDate, String text, String author, String bookingID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO FEEDBACK VALUES (?, ?, ?, ?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, feedbackID);                     // Feedback ID
            stm.setTimestamp(2, Timestamp.valueOf(feedbackDate)); // Feedback Date (LocalDateTime to Timestamp)
            stm.setString(3, text);                           // Comment Text
            stm.setString(4, author);                         // Author                     // Clinic ID
            stm.setString(5, bookingID);

            int rowsAffected = stm.executeUpdate();
            if (rowsAffected > 0) {
                return true;
            }

        } catch (SQLException e) {
            System.out.println("Error occurred: " + e.getMessage());
        } finally {
            // Close resources in finally block to ensure they are always closed
            try {
                if (stm != null) {
                    stm.close();
                }
                if (con != null) {
                    con.close();
                }
            } catch (SQLException e) {
                System.out.println("Error closing resources: " + e.getMessage());
            }
        }
        return false;
    }

    public List<FeedbackDTO> getFeedbackByBookingID(String rw_accountID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        FeedbackDTO dto = null;
        List<FeedbackDTO> list = new ArrayList<>();
        String query = "SELECT feedbackID, feedbackDay, feedbackContent, username, bookingID FROM FEEDBACK fb join ACCOUNT ac on fb.accountID = ac.accountID WHERE bookingID = ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, rw_accountID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String feedbackID = rs.getString("feedbackID");
                LocalDateTime feedbackDay = rs.getTimestamp("feedbackDay").toLocalDateTime();
                String feedbackContent = rs.getString("feedbackContent");
                String fullName = rs.getString("username");
                String bookingID = rs.getString("bookingID");

                LocalDateTime pastDateTime = LocalDateTime.parse(feedbackDay.toString(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
//                long minutesAgo = calculateMinutesAgo(pastDateTime);
//                String timeAgo = formatTimeAgo(pastDateTime, minutesAgo);

                dto = new FeedbackDTO(feedbackID, pastDateTime.toString(), feedbackContent, fullName, bookingID);
                list.add(dto);
            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred: ");

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }

    public List<FeedbackDTO> getAllFeedbacksByUser(String rw_accountID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        FeedbackDTO dto = null;
        List<FeedbackDTO> list = new ArrayList<>();
        String query = "SELECT feedbackID, feedbackDay, feedbackContent, accountID, bookingID FROM FEEDBACK WHERE accountID = ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, rw_accountID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String feedbackID = rs.getString("feedbackID");
                LocalDateTime feedbackDay = rs.getTimestamp("feedbackDay").toLocalDateTime();
                String feedbackContent = rs.getString("feedbackContent");
                String accountID = rs.getString("accountID");
                String bookingID = rs.getString("bookingID");

                LocalDateTime pastDateTime = LocalDateTime.parse(feedbackDay.toString(), DateTimeFormatter.ISO_LOCAL_DATE_TIME);
                long minutesAgo = calculateMinutesAgo(pastDateTime);
                String timeAgo = formatTimeAgo(pastDateTime, minutesAgo);

                dto = new FeedbackDTO(feedbackID, timeAgo, feedbackContent, accountID, bookingID);
                list.add(dto);
            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred: ");

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return list;
    }
}
