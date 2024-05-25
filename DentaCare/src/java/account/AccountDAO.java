package account;

import utils.DBUtils;

import java.io.Serializable;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class AccountDAO implements Serializable {

    Encoder strE = new Encoder();

    public AccountDTO updateProfileAccount(String fullName, String phone, boolean gender, String userName)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("UPDATE ACCOUNT SET FULLNAME = ?, PHONENUMBER = ?, GENDER = ?"
                + " WHERE USERNAME = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);

            stm.setString(1, fullName);
            stm.setString(2, phone);
            stm.setBoolean(3, gender);
            stm.setString(4, userName);

            stm.executeUpdate();

            stm = con.prepareStatement("Select * from account where username = ?");
            stm.setString(1, userName);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                String password = rs.getString("password");
                String email = rs.getString("email");

                String address = rs.getString("address");
                LocalDate dob = rs.getDate("dob").toLocalDate();
                String googleID = rs.getString("googleID");
                String googleName = rs.getString("googleName");
                int role = rs.getInt("role");

                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone + "",
                        address, gender, googleID, googleName, role);
                return accountDTO;
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
        return null;
    }

    public AccountDTO createAnNormalAccount(String userNameK, String passwordK, String email, String accountId)
            throws SQLException {
        String en_password = passwordK;
        try {
            en_password = strE.encode(passwordK);
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO ACCOUNT VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, accountId);
            stm.setString(2, userNameK);
            stm.setString(3, en_password);
            stm.setString(4, email);
            stm.setString(5, null);
            stm.setString(6, null);
            stm.setString(7, null);
            stm.setDate(8, null);
            stm.setString(9, null);
            stm.setString(10, null);
            stm.setString(11, null);
            stm.setInt(12, 0);
            stm.executeUpdate();

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
        return null;
    }

    public AccountDTO checkExistAccount(String userNameK, String passwordK) throws SQLException {
        String en_password = passwordK;
        try {
            en_password = strE.encode(passwordK);
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT * FROM ACCOUNT WHERE USERNAME = ? AND PASSWORD = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, userNameK);
            stm.setString(2, en_password);
            rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                String userName = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                LocalDate dob = null;
                java.sql.Date dobSql = rs.getDate("dob");
                if (dobSql != null) {
                    dob = dobSql.toLocalDate();
                }
                boolean gender = rs.getBoolean("gender");
                String googleID = rs.getString("googleID");
                String googleName = rs.getString("googleName");
                int role = rs.getInt("roleID");

                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone, address, gender, googleID, googleName, role);
                return accountDTO;
            }
        } catch (SQLException e) {
            System.out.println("SQL: " + e);

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
        return null;
    }

    public String checkExistPass(String userNameK) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT password FROM ACCOUNT WHERE USERNAME = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, userNameK);
            rs = stm.executeQuery();
            while (rs.next()) {
                String password = rs.getString("password");
                return password;
            }
        } catch (SQLException e) {
            System.out.println("SQL: " + e);

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
        return "";
    }

    public String checkExistEmail(String email) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT email FROM ACCOUNT WHERE email = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, email);
            rs = stm.executeQuery();
            while (rs.next()) {
                String gmail = rs.getString("email");
                return gmail;
            }
        } catch (SQLException e) {
            System.out.println("SQL: " + e);

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
        return "";
    }

    public String checkExistName(String userNameK) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT userName FROM ACCOUNT WHERE USERNAME = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, userNameK);
            rs = stm.executeQuery();
            while (rs.next()) {
                String userName = rs.getString("userName");
                return userName;
            }
        } catch (SQLException e) {
            System.out.println("SQL: " + e);

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
        return "";
    }

    public AccountDTO createAccountGG(String googleID, String googleName, String accountId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO ACCOUNT VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, accountId);
            stm.setString(2, googleName);
            stm.setString(3, null);
            stm.setString(4, googleName);
            stm.setString(5, null);
            stm.setString(6, null);
            stm.setString(7, null);
            stm.setDate(8, null);
            stm.setString(9, null);
            stm.setString(10, googleID);
            stm.setString(11, googleName);
            stm.setInt(12, 0);
            stm.executeUpdate();

        } catch (SQLException e) {
            System.out.println("An SQL error occurred: " + e);
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

    public AccountDTO checkAccountGG(String userName) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT * FROM ACCOUNT WHERE USERNAME = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, userName);
            rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String fullname = rs.getString("fullName");
                LocalDate dob = null;
                java.sql.Date dobSql = rs.getDate("dob");
                if (dobSql != null) {
                    dob = dobSql.toLocalDate();
                }
                boolean gender = rs.getBoolean("gender");
                String googleID = rs.getString("googleID");
                String googleName = rs.getString("googleName");
                int role = rs.getInt("roleID");

                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullname, phone, address, gender, googleID, googleName, role);
                return accountDTO;
            }
        } catch (SQLException e) {
            System.out.println("SQL: " + e);
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
        return null;
    }

    // public AccountDTO findAccountByEmail(String email) {
    // AccountDTO acc = null;
    // Connection con = DBUtils.getConnection();
    // String sql = "SELECT * FROM ACCOUNT WHERE email = ?";
    // try {
    // PreparedStatement st = con.prepareStatement(sql);
    // st.setString(1, email);
    // ResultSet rs = st.executeQuery();
    //
    // if (rs.next()) {
    // acc = new AccountDTO(rs.getString("userName"), rs.getString("password"),
    // null, null, null, rs.getString("email"), null, null, true);
    // }
    // } catch (SQLException e) {
    // System.out.println(e);
    // }
    //
    // return acc;
    // }
    public int countAccount() {
        String sql = "SELECT COUNT(*) AS Numb FROM ACCOUNT";
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

    public int countDentist() {
        String sql = "SELECT COUNT(*) AS Numb FROM ACCOUNT WHERE ROLE = 1";
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

    public AccountDTO createDentist(String accountId, String userNameK, String passwordK, String email, String fullName,
            String phone, String address) throws SQLException {
        String en_password = passwordK;
        try {
            en_password = strE.encode(passwordK);
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO ACCOUNT VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, accountId);
            stm.setString(2, userNameK);
            stm.setString(3, en_password);
            stm.setString(4, email);
            stm.setString(5, fullName);
            stm.setString(6, phone);
            stm.setString(7, address);
            stm.setDate(8, null);
            stm.setString(9, null);
            stm.setString(10, null);
            stm.setString(11, null);
            stm.setInt(12, 1);

            stm.executeUpdate();

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
        return null;
    }

    public int countStaff() {
        String sql = "SELECT COUNT(*) AS Numb FROM ACCOUNT WHERE ROLE = 1";
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

    public AccountDTO createStaff(String accountId, String userNameK, String passwordK, String email, String fullName,
            String phone, String address) throws SQLException {
        String en_password = passwordK;
        try {
            en_password = strE.encode(passwordK);
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO ACCOUNT VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, accountId);
            stm.setString(2, userNameK);
            stm.setString(3, en_password);
            stm.setString(4, email);
            stm.setString(5, fullName);
            stm.setString(6, phone);
            stm.setString(7, address);
            stm.setDate(8, null);
            stm.setString(9, null);
            stm.setString(10, null);
            stm.setString(11, null);
            stm.setInt(12, 2);

            stm.executeUpdate();

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
        return null;
    }

    public List<AccountDTO> listAllDentist() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT * FROM ACCOUNT WHERE ROLE = 2");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            rs = stm.executeQuery();
            while (rs.next()) {
                String userName = rs.getString("userName");
            }
        } catch (SQLException e) {
            System.out.println("SQL: " + e);

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
        return null;
    }
}
