package account;

import java.io.Serializable;
import java.time.LocalDate;

public class AccountDTO implements Serializable {

    private String accountID;
    private String userName;
    private String password;
    private String email;
    private LocalDate dob;
    private String fullName;
    private String phone;
    private String address;
    private String googleID;
    private String googleName;
    private boolean gender;
    private int roleID;
    private int status;
    private int clinicID;

    public AccountDTO() {
    }

    public AccountDTO(String accountID, String userName, String password, String email, LocalDate dob, String fullName, String phone, String address, boolean gender,String googleID, String googleName, int roleID, int status, int clinicID) {
        this.accountID = accountID;
        this.userName = userName;
        this.password = password;
        this.email = email;
        this.dob = dob;
        this.fullName = fullName;
        this.phone = phone;
        this.address = address;
        this.googleID = googleID;
        this.googleName = googleName;
        this.gender = gender;
        this.roleID = roleID;
        this.status = status;
        this.clinicID = clinicID;
    }

    public String getAccountID() {
        return accountID;
    }

    public void setAccountID(String accountID) {
        this.accountID = accountID;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPassword() {
        return password;
    }

    public void setPassword(String password) {
        this.password = password;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public LocalDate getDob() {
        return dob;
    }

    public void setDob(LocalDate dob) {
        this.dob = dob;
    }

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getAddress() {
        return address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    public String getGoogleID() {
        return googleID;
    }

    public void setGoogleID(String googleID) {
        this.googleID = googleID;
    }

    public String getGoogleName() {
        return googleName;
    }

    public void setGoogleName(String googleName) {
        this.googleName = googleName;
    }

    public boolean isGender() {
        return gender;
    }

    public void setGender(boolean gender) {
        this.gender = gender;
    }

    public int getRoleID() {
    public int isRoleID() {
        return roleID;
    }

    public void setRoleID(int roleID) {
        this.roleID = roleID;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public int getClinicID() {
        return clinicID;
    }

    public void setClinicID(int clinicID) {
        this.clinicID = clinicID;
    }


}
