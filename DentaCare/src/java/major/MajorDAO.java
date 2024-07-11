package major;

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

import java.util.List;

public class MajorDAO {

    public List<MajorDTO> getAllMajors() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MajorDTO dto = null;
        List<MajorDTO> list = new ArrayList<>();
        String query = "SELECT * FROM MAJOR";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            rs = stm.executeQuery();
            while (rs.next()) {
                int majorID = rs.getInt("majorID");
                String majorName = rs.getString("majorName");
                String majorDescription = rs.getString("majorDescription");
                dto = new MajorDTO(majorID, majorName, majorDescription);
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

    public List<MajorDTO> getAllDenByMajors(String majorName) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MajorDTO dto = null;
        List<MajorDTO> list = new ArrayList<>();
        String query = "select a.fullName, a.accountID from account a "
                + "join MAJORDETAIL md on a.accountID = md.accountID "
                + "join major m on md.majorID = m.majorID "
                + "where m.majorName like ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + majorName + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                String fullName = rs.getString("fullName");
                String id = rs.getString("accountID");
                dto = new MajorDTO(fullName, id);
                list.add(dto);
            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred124214: ");

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

    public List<MajorDTO> getAllDenNotByMajors(String majorName) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MajorDTO dto = null;
        List<MajorDTO> list = new ArrayList<>();
        String query = "select distinct a.fullName, a.accountID from account a "
                + "where a.accountID like '%DEN%' and a.accountID not in "
                + "(select  a.accountID from account a "
                + "join MAJORDETAIL md on a.accountID = md.accountID "
                + "join major m on md.majorID = m.majorID "
                + "where m.majorName like ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + majorName + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                String fullName = rs.getString("fullName");
                String accountID = rs.getString("accountID");
                dto = new MajorDTO(fullName, accountID);
                list.add(dto);
            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred124214: ");

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

    public int getMajorByName(String majorName) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MajorDTO dto = null;

        String query = "select majorID from MAJOR where majorName like ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, "%" + majorName + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                return rs.getInt("majorID");

            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred124214: ");

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return 0;

    }

    public List<MajorDTO> getDenByID(String ID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MajorDTO dto = null;
        List<MajorDTO> list = new ArrayList<>();
        String query = "select accountID, fullname from ACCOUNT where accountID like ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, ID);
            rs = stm.executeQuery();
            while (rs.next()) {
                String fullName = rs.getString("fullName");
                String accountID = rs.getString("accountID");
                dto = new MajorDTO(fullName, accountID);
                list.add(dto);
                return list;

            }
        } catch (SQLException e) {
            System.out.println("An SQL error occurred124214: ");

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return null;

    }

    public void addNewDenMajor(int majorID, String accountID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MajorDTO dto = null;

        String query = "insert into MAJORDETAIL (majorID,accountID) values (?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setInt(1, majorID);
            stm.setString(2, accountID);

            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("An SQL error occurred124214: ");

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }

    public void deleteDenMajor(int majorID, String accountID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        MajorDTO dto = null;

        String query = " delete from MAJORDETAIL where accountID = ? and majorID = ?";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, accountID);
            stm.setInt(2, majorID);

            stm.executeUpdate();
        } catch (SQLException e) {
            System.out.println("An SQL error occurred124214: ");

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
    }
}
