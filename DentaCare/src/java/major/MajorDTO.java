/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package major;

/**
 *
 * @author ROG STRIX
 */
public class MajorDTO {

    private int majorID;
    private String majorName;
    private String majorDescription;
    private String accountFullName;
    private String accountID;

    public MajorDTO(String accountFullName, String accountID) {

        this.accountFullName = accountFullName;
        this.accountID = accountID;
    }

    public MajorDTO(String accountFullName) {

        this.accountFullName = accountFullName;

    }

    public MajorDTO(int majorID, String majorName, String majorDescription) {
        this.majorID = majorID;
        this.majorName = majorName;
        this.majorDescription = majorDescription;
    }

    public String getAccountID() {
        return accountID;
    }

    public void setAccountID(String accountID) {
        this.accountID = accountID;
    }

    public String getAccountFullName() {
        return accountFullName;
    }

    public void setAccountFullName(String accountFullName) {
        this.accountFullName = accountFullName;
    }

    public MajorDTO() {
    }

    public int getMajorID() {
        return majorID;
    }

    public void setMajorID(int majorID) {
        this.majorID = majorID;
    }

    public String getMajorName() {
        return majorName;
    }

    public void setMajorName(String majorName) {
        this.majorName = majorName;
    }

    public String getMajorDescription() {
        return majorDescription;
    }

    public void setMajorDescription(String majorDescription) {
        this.majorDescription = majorDescription;
    }

    @Override
    public String toString() {
        return super.toString(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

}
