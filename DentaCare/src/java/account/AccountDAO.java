package account;

import account.AccountDTO;
import java.io.Serializable;
import java.sql.Connection;
import java.sql.Date;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.AbstractList;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import utils.DBUtils;

public class AccountDAO implements Serializable {

    Encoder strE = new Encoder();

    public List<AccountDTO> getListByPage(ArrayList<AccountDTO> list,
            int start, int end) {
        ArrayList<AccountDTO> arr = new ArrayList<>();
        for (int i = start; i < end; i++) {
            arr.add(list.get(i));
        }
        return arr;
    }

    public List<AccountDTO> getAllDentistsByOwner() throws SQLException {
        List<AccountDTO> result = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("select a.accountID, email, fullName, phone, address, dob, gender, image, cl.clinicName, m.majorName, md.introduction, status from account a "
                + "left join MAJORDETAIL md on a.accountID = md.accountID "
                + "left join MAJOR m on md.majorID = m.majorID "
                + "left join CLINIC cl on cl.clinicID = a.clinicID "
                + "where a.roleID = 1");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.executeQuery();
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                String majorName = rs.getString("majorName");
                String introduction = rs.getString("introduction");

                String email = rs.getString("email");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String image = rs.getString("image");
                LocalDate dob = null;
                java.sql.Date dobSql = rs.getDate("dob");
                if (dobSql != null) {
                    dob = dobSql.toLocalDate();
                }
                boolean gender = rs.getBoolean("gender");
                int status = rs.getInt("status");
                String clinicName = rs.getString("clinicName");
                AccountDTO accountDTO = new AccountDTO(accountID, email, dob, fullName, phone, address, image, gender, status, clinicName, majorName, introduction);
                result.add(accountDTO);
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
        return result;
    }

    public List<AccountDTO> getAllDentists() throws SQLException {
        List<AccountDTO> result = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("SELECT distinct * FROM ACCOUNT WHERE ROLEID = 1");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.executeQuery();
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                String userName = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String image = rs.getString("image");
                LocalDate dob = null;
                java.sql.Date dobSql = rs.getDate("dob");
                if (dobSql != null) {
                    dob = dobSql.toLocalDate();
                }
                boolean gender = rs.getBoolean("gender");
                String googleID = rs.getString("googleID");
                String googleName = rs.getString("googleName");
                int role = rs.getInt("roleID");
                int status = rs.getInt("status");
                int clinicID = rs.getInt("clinicID");
                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone + "",
                        address, image, gender, googleID, googleName, role, status, clinicID);
                result.add(accountDTO);
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
        return result;
    }

    public AccountDTO updateProfileAccount(String fullName, String phone, boolean gender, String userName, String dob, String addr)
            throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("UPDATE ACCOUNT SET fullName = ?, phone = ?, gender = ?, dob = ?, address = ?"
                + " WHERE USERNAME = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);

            stm.setString(1, fullName);
            stm.setString(2, phone);
            stm.setBoolean(3, gender);
            stm.setString(4, dob);
            stm.setString(5, addr);
            stm.setString(6, userName);

            stm.executeUpdate();

            stm = con.prepareStatement("Select * from account where username = ?");
            stm.setString(1, userName);
            ResultSet rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                String userName2 = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                String fullName2 = rs.getString("fullName");
                String phone2 = rs.getString("phone");
                String address = rs.getString("address");
                String image = rs.getString("image");
                LocalDate dob2 = null;
                java.sql.Date dobSql = rs.getDate("dob");
                if (dobSql != null) {
                    dob2 = dobSql.toLocalDate();
                }
                boolean gender2 = rs.getBoolean("gender");
                String googleID = rs.getString("googleID");
                String googleName = rs.getString("googleName");
                int role = rs.getInt("roleID");
                int status = rs.getInt("status");
                int clinicID = rs.getInt("clinicID");
                AccountDTO accountDTO = new AccountDTO(accountID, userName2, password, email, dob2, fullName2, phone2 + "",
                        address, image, gender2, googleID, googleName, role, status, clinicID);
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
        String query = "INSERT INTO ACCOUNT (accountID, username, password, email, roleID, status) VALUES (?, ?, ?, ?, ?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, accountId);
            stm.setString(2, userNameK);
            stm.setString(3, en_password);
            stm.setString(4, email);
            stm.setInt(5, 0);
            stm.setInt(6, 0);
            stm.executeUpdate();

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
                String image = rs.getString("image");
                LocalDate dob = null;
                java.sql.Date dobSql = rs.getDate("dob");
                if (dobSql != null) {
                    dob = dobSql.toLocalDate();
                }
                boolean gender = rs.getBoolean("gender");
                String googleID = rs.getString("googleID");
                String googleName = rs.getString("googleName");
                int role = rs.getInt("roleID");
                int status = rs.getInt("status");
                int clinicID = rs.getInt("clinicID");
                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone, address, image, gender, googleID, googleName, role, status, clinicID);
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
        StringBuilder query = new StringBuilder("SELECT password FROM ACCOUNT WHERE username = ?");
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
        StringBuilder query = new StringBuilder("SELECT username FROM ACCOUNT WHERE username = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, userNameK);
            rs = stm.executeQuery();
            while (rs.next()) {

                String userName = rs.getString("username");
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
        return null;
    }

    public AccountDTO createAccountGG(String googleID, String googleName, String accountId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO ACCOUNT (accountID, username, email,googleID, googleName, roleID, status) VALUES (?, ?, ?, ?, ?, ?, ?)";
        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, accountId);
            stm.setString(2, googleName);
            stm.setString(3, googleName);
            stm.setString(4, googleID);
            stm.setString(5, googleName);
            stm.setInt(6, 0);
            stm.setInt(7, 0);

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

    public AccountDTO checkAccountGG(String mail) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT * FROM ACCOUNT WHERE email = ?");
        try {
            String sql = String.valueOf(query);

            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, mail);
            rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                String password = rs.getString("password");
                String username = rs.getString("username");
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
                int status = rs.getInt("status");
                int clinicID = rs.getInt("clinicID");
                String image = rs.getString("image");
                AccountDTO accountDTO = new AccountDTO(accountID, username, password, email, dob, fullname, phone, address, image, gender, googleID, googleName, role, status, clinicID);
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

    public AccountDTO findAccountByEmail(String email) {
        AccountDTO acc = null;
        Connection con = DBUtils.getConnection();
        String sql = "SELECT * FROM ACCOUNT WHERE email = ?";
        try {
            PreparedStatement st = con.prepareStatement(sql);
            st.setString(1, email);
            ResultSet rs = st.executeQuery();

            if (rs.next()) {
                LocalDate dob = null;
                java.sql.Date dobSql = rs.getDate("dob");
                if (dobSql != null) {
                    dob = dobSql.toLocalDate();
                }
                acc = new AccountDTO(rs.getString("accountID"), rs.getString("userName"), rs.getString("password"), rs.getString("email"), dob, rs.getString("fullName"), rs.getString("phone"),
                        rs.getString("address"), rs.getString("image"), rs.getBoolean("gender"), rs.getString("googleID"), rs.getString("googleName"), rs.getInt("roleID"), rs.getInt("status"), rs.getInt("clinicID"));
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }

        return acc;
    }

    public AccountDTO searchAccountByID(String accountId) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT * FROM ACCOUNT WHERE accountID = ? ");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, accountId);
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
                int status = rs.getInt("status");
                int clinicID = rs.getInt("clinicID");
                String image = rs.getString("image");

                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone,
                        address, image, gender, googleID, googleName, role, status, clinicID);
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

    public List<AccountDTO> searchByDenWorkingDate(String workingDate) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<AccountDTO> list = new ArrayList<>();

        StringBuilder query = new StringBuilder("select * from ACCOUNT \n"
                + " join DENTISTSCHEDULE on DENTISTSCHEDULE.accountID = ACCOUNT.accountID \n"
                + " where DENTISTSCHEDULE.workingDate = ? and ACCOUNT.status = 0 ");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, workingDate);
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
                int status = rs.getInt("status");
                int clinicID = rs.getInt("clinicID");
                String image = rs.getString("image");

                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone,
                        address, image, gender, googleID, googleName, role, status, clinicID);
                list.add(accountDTO);
                return list;
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
        return list;
    }

    public int countAccount() {
        String sql = "SELECT COUNT(*) AS Numb FROM ACCOUNT WHERE roleID = 0";
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
        String sql = "SELECT COUNT(*) AS Numb FROM ACCOUNT WHERE roleID = 1";
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

    public boolean createDentist(String accountId, String userNameK, String passwordK, String email, String fullName,
            String phone, String address, int clinicID) throws SQLException {
        String en_password = passwordK;
        boolean flag = false;
        try {
            en_password = strE.encode(passwordK);
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO ACCOUNT VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            stm.setString(12, null);
            stm.setInt(13, 1);
            stm.setInt(14, 2);
            stm.setInt(15, clinicID);

            if (stm.executeUpdate() != 0) {
                flag = true;
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());;

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return flag;
    }

    public int countStaff() {
        String sql = "SELECT COUNT(*) AS Numb FROM ACCOUNT WHERE roleID = 2";
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

    public boolean createStaff(String accountId, String userNameK, String passwordK, String email, String fullName,
            String phone, String address, int clinicID) throws SQLException {
        String en_password = passwordK;
        boolean flag = false;
        try {
            en_password = strE.encode(passwordK);
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection con = null;
        PreparedStatement stm = null;
        String query = "INSERT INTO ACCOUNT VALUES (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
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
            stm.setString(12, null);
            stm.setInt(13, 2);
            stm.setInt(14, 2);
            stm.setInt(15, clinicID);

            if (stm.executeUpdate() != 0) {
                flag = true;
            }

        } catch (SQLException e) {
            System.out.println("An SQL error occurred: " + e);
            e.printStackTrace();

        } finally {
            if (stm != null) {
                stm.close();
            }
            if (con != null) {
                con.close();
            }
        }
        return flag;
    }

    public boolean updateDentistProfile(String fullName, String phone, String address, String email, LocalDate date, boolean gender, String accountId)
            throws SQLException {
        boolean flag = false;
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("UPDATE ACCOUNT SET fullName = ?, phone = ?, address = ?, email = ?, dob = ?, gender = ? WHERE accountID = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);

            stm.setString(1, fullName);
            stm.setString(2, phone);
            stm.setString(3, address);
            stm.setString(4, email);
            stm.setDate(5, Date.valueOf(date));
            stm.setBoolean(6, gender);
            stm.setString(7, accountId);

            if (stm.executeUpdate() != 0) {
                flag = true;
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
        return flag;
    }

    public boolean updateDentist(String fullName, String phone, String address, LocalDate dob, boolean gender, String image, int clinicID, String accountId)
            throws SQLException {
        boolean flag = false;
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("UPDATE ACCOUNT SET fullName = ?, phone = ?, address = ?, dob = ?, gender = ?, image = ?, clinicID = ?  WHERE accountID = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);

            stm.setString(1, fullName);
            stm.setString(2, phone);
            stm.setString(3, address);
            stm.setDate(4, Date.valueOf(dob));
            stm.setBoolean(5, gender);
            stm.setString(6, image);
            stm.setInt(7, clinicID);
            stm.setString(8, accountId);

            if (stm.executeUpdate() != 0) {
                flag = true;
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
        return flag;
    }

    public boolean updateDentistBio(String bio, String accountId)
            throws SQLException {
        boolean flag = false;
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("UPDATE MAJORDETAIL SET introduction = ? WHERE accountID = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);

            stm.setString(1, bio);
            stm.setString(2, accountId);

            if (stm.executeUpdate() != 0) {
                flag = true;
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
        return flag;
    }

    public boolean changePasswordFirstLogin(String password, String accountId)
            throws SQLException {
        boolean flag = false;
        String en_pass = new Encoder().encode(password);
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("UPDATE ACCOUNT SET password = ?, status = ? WHERE accountID = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);

            stm.setString(1, en_pass);
            stm.setInt(2, 0);
            stm.setString(3, accountId);

            if (stm.executeUpdate() != 0) {
                flag = true;
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
        return flag;
    }

    public List<AccountDTO> listAllDentist() throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("SELECT * FROM ACCOUNT WHERE ROLE = 1");
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

    public void resetPassword(String email, String password) throws SQLException {
        String en_password = password;
        try {
            en_password = strE.encode(password);
        } catch (Exception ex) {
            Logger.getLogger(AccountDAO.class.getName()).log(Level.SEVERE, null, ex);
        }
        Connection con = null;
        PreparedStatement stm = null;
        String query = "UPDATE ACCOUNT SET PASSWORD = ? WHERE EMAIL = ?";

        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);

            stm.setString(1, en_password);
            stm.setString(2, email);

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
    }

    public List<AccountDTO> getAccountDentistByRoleID1(int clinicID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        List<AccountDTO> list = new ArrayList<>();
        StringBuilder query = new StringBuilder("select ACCOUNT.* from ACCOUNT where roleID = 1 and status = 0 and clinicID = ?");
        try {
            String sql = null;
            sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setInt(1, clinicID);
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
                int status = rs.getInt("status");
                clinicID = rs.getInt("clinicID");
                String image = rs.getString("image");

                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone, address, image, gender, googleID, googleName, role, status, clinicID);
                list.add(accountDTO);
            }
        } catch (SQLException e) {
            System.out.println("SQL: ");
            e.printStackTrace();
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
        return list;
    }

    public AccountDTO getAccountIdByName(String fullName) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("select accountID from ACCOUNT WHERE fullName = ? AND roleID = 2");
        try {
            String sql = null;
            sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, fullName);
            rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                String userName = rs.getString("username");
                String password = rs.getString("password");
                String email = rs.getString("email");
                fullName = rs.getString("fullName");
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
                int status = rs.getInt("status");
                int clinicID = rs.getInt("clinicID");
                String image = rs.getString("image");
                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone, address, image, gender, googleID, googleName, role, status, clinicID);
                return accountDTO;
            }
        } catch (SQLException e) {
            System.out.println("SQL: ");
            e.printStackTrace();
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

    public int countUserAccount() {
        String sql = "SELECT COUNT(*) AS Numb FROM ACCOUNT Where accountID LIKE 'CUS%'";
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

    public AccountDTO getDentistByID(String dentistID) throws SQLException {
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("select * from ACCOUNT WHERE accountID = ?");
        try {
            String sql = null;
            sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, dentistID);
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
                int status = rs.getInt("status");
                int clinicID = rs.getInt("clinicID");
                String image = rs.getString("image");
                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone, address, image, gender, googleID, googleName, role, status, clinicID);
                return accountDTO;
            }
        } catch (SQLException e) {
            System.out.println("SQL: ");
            e.printStackTrace();
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

    public List<AccountDTO> searchDentists(String name) throws SQLException {
        List<AccountDTO> result = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        StringBuilder query = new StringBuilder("select a.accountID, email, fullName, phone, address, dob, gender, image, cl.clinicName, m.majorName, md.introduction, status from account a "
                + "LEFT JOIN  MAJORDETAIL md on a.accountID = md.accountID "
                + "LEFT JOIN  MAJOR m on md.majorID = m.majorID "
                + "LEFT JOIN  CLINIC cl on cl.clinicID = a.clinicID "
                + "where a.roleID = 1 and status = 0 and fullName like ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, "%" + name + "%");
            rs = stm.executeQuery();
            while (rs.next()) {
                String accountID = rs.getString("accountID");
                String majorName = rs.getString("majorName");
                String introduction = rs.getString("introduction");

                String email = rs.getString("email");
                String fullName = rs.getString("fullName");
                String phone = rs.getString("phone");
                String address = rs.getString("address");
                String image = rs.getString("image");
                LocalDate dob = null;
                java.sql.Date dobSql = rs.getDate("dob");
                if (dobSql != null) {
                    dob = dobSql.toLocalDate();
                }
                boolean gender = rs.getBoolean("gender");
                int status = rs.getInt("status");
                String clinicName = rs.getString("clinicName");
                AccountDTO accountDTO = new AccountDTO(accountID, email, dob, fullName, phone, address, image, gender, status, clinicName, majorName, introduction);
                result.add(accountDTO);

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
        return result;
    }

    public boolean disableDentist(String accountId) throws SQLException {
        boolean flag = false;
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("UPDATE ACCOUNT SET status = 1 WHERE accountID = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);
            stm.setString(1, accountId);

            if (stm.executeUpdate() != 0) {
                flag = true;
            }

        } catch (SQLException e) {
            System.out.println(e.getMessage());

        } finally {

        }

        return flag;
    }

    public List<Map<String, Object>> getAgeGroupStatisticsForMale() throws SQLException {
        List<Map<String, Object>> results = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBUtils.getConnection();;
            String sql = "SELECT \n"
                    + "    CASE \n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 0 AND 10 THEN '0-10'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 11 AND 20 THEN '11-20'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 21 AND 30 THEN '21-30'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 31 AND 40 THEN '31-40'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 41 AND 50 THEN '41-50'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 51 AND 60 THEN '51-60'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 61 AND 70 THEN '61-70'\n"
                    + "        ELSE '71+' \n"
                    + "    END AS age_range, \n"
                    + "    COUNT(gender) AS Numb\n"
                    + "FROM ACCOUNT \n"
                    + "WHERE gender = 1 \n"
                    + "AND roleID = 0 \n"
                    + "GROUP BY CASE \n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 0 AND 10 THEN '0-10'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 11 AND 20 THEN '11-20'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 21 AND 30 THEN '21-30'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 31 AND 40 THEN '31-40'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 41 AND 50 THEN '41-50'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 51 AND 60 THEN '51-60'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 61 AND 70 THEN '61-70'\n"
                    + "             ELSE '71+' \n"
                    + "         END";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String ageRange = resultSet.getString("age_range");
                int count = resultSet.getInt("Numb");

                Map<String, Object> result = new HashMap<>();
                result.put("age_range", ageRange);
                result.put("count", count);

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

    public List<Map<String, Object>> getAgeGroupStatisticsForFemale() throws SQLException {
        List<Map<String, Object>> results = new ArrayList<>();
        Connection connection = null;
        PreparedStatement statement = null;
        ResultSet resultSet = null;

        try {
            connection = DBUtils.getConnection();;
            String sql = "SELECT \n"
                    + "    CASE \n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 0 AND 10 THEN '0-10'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 11 AND 20 THEN '11-20'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 21 AND 30 THEN '21-30'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 31 AND 40 THEN '31-40'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 41 AND 50 THEN '41-50'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 51 AND 60 THEN '51-60'\n"
                    + "        WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 61 AND 70 THEN '61-70'\n"
                    + "        ELSE '71+' \n"
                    + "    END AS age_range, \n"
                    + "    COUNT(gender) AS Numb\n"
                    + "FROM ACCOUNT \n"
                    + "WHERE gender = 0 \n"
                    + "AND roleID = 0 \n"
                    + "GROUP BY CASE \n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 0 AND 10 THEN '0-10'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 11 AND 20 THEN '11-20'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 21 AND 30 THEN '21-30'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 31 AND 40 THEN '31-40'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 41 AND 50 THEN '41-50'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 51 AND 60 THEN '51-60'\n"
                    + "             WHEN YEAR(GETDATE()) - YEAR(dob) BETWEEN 61 AND 70 THEN '61-70'\n"
                    + "             ELSE '71+' \n"
                    + "         END";
            statement = connection.prepareStatement(sql);
            resultSet = statement.executeQuery();

            while (resultSet.next()) {
                String ageRange = resultSet.getString("age_range");
                int count = resultSet.getInt("Numb");

                Map<String, Object> result = new HashMap<>();
                result.put("age_range", ageRange);
                result.put("count", count);

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

    public List<AccountDTO> getCusInfo(String dentistID) throws SQLException {
        List<AccountDTO> list = new ArrayList<>();
        Connection con = null;
        PreparedStatement stm = null;
        ResultSet rs = null;
        String query = """
                       SELECT acc.accountID, acc.username, acc.password, acc.email, acc.fullName, 
                              acc.phone, acc.address, acc.dob, acc.gender, acc.googleID, 
                              acc.googleName, acc.roleID, acc.status, acc.clinicID, acc.image
                       FROM ACCOUNT AS acc
                       JOIN BOOKING AS b ON acc.accountID = b.customerID
                       WHERE b.dentistID = ? 
                         AND (b.status = 2 OR b.status = 1)
                       """;

        try {
            con = DBUtils.getConnection();
            stm = con.prepareStatement(query);
            stm.setString(1, dentistID);
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
                int status = rs.getInt("status");
                int clinicID = rs.getInt("clinicID");
                String image = rs.getString("image");

                AccountDTO accountDTO = new AccountDTO(accountID, userName, password, email, dob, fullName, phone, address, image, gender, googleID, googleName, role, status, clinicID);
                list.add(accountDTO);
            }
        } catch (SQLException e) {
            System.out.println("SQL Error: ");
            e.printStackTrace();
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
        return list;
    }

    public boolean restoreDentist(String accountId)
            throws SQLException {
        boolean flag = false;
        Connection con = null;
        PreparedStatement stm = null;
        StringBuilder query = new StringBuilder("UPDATE ACCOUNT SET status = 0  WHERE accountID = ?");
        try {
            String sql = String.valueOf(query);
            con = DBUtils.getConnection();
            stm = con.prepareStatement(sql);

            stm.setString(1, accountId);

            if (stm.executeUpdate() != 0) {
                flag = true;
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
        return flag;
    }

    public boolean updateProfileDentist(AccountDTO staff) {
        String sql = "UPDATE account SET username = ?, fullname = ?, phone = ?, address = ?, dob = ?, gender = ?, image = ? WHERE accountId = ?";
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {

            ps.setString(1, staff.getUserName());
            ps.setString(2, staff.getFullName());
            ps.setString(3, staff.getPhone());
            ps.setString(4, staff.getAddress());
            ps.setDate(5, java.sql.Date.valueOf(staff.getDob()));
            ps.setBoolean(6, staff.isGender());
            ps.setString(7, staff.getImage());
            ps.setString(8, staff.getAccountID());

            int rowsUpdated = ps.executeUpdate();
            return rowsUpdated > 0;

        } catch (SQLException e) {
            e.getMessage();
            return false;
        }
    }
}
