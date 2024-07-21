/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dentistSchedule;

/**
 *
 * @author Admin
 */
public class DentistScheduleDTO {

    private int dentistScheduleID;
    private String accountID;
    private String workingDate;

    public DentistScheduleDTO() {
    }

    public DentistScheduleDTO(int dentistScheduleID, String accountID, String workingDate) {
        this.dentistScheduleID = dentistScheduleID;
        this.accountID = accountID;
        this.workingDate = workingDate;
    }

    public int getDentistScheduleID() {
        return dentistScheduleID;
    }

    public void setDentistScheduleID(int dentistScheduleID) {
        this.dentistScheduleID = dentistScheduleID;
    }

    public String getAccountID() {
        return accountID;
    }

    public void setAccountID(String accountID) {
        this.accountID = accountID;
    }

    public String getWorkingDate() {
        return workingDate;
    }

    public void setWorkingDate(String workingDate) {
        this.workingDate = workingDate;
    }

    @Override
    public String toString() {
        return "DentistScheduleDTO{" + "dentistScheduleID=" + dentistScheduleID + ", accountID=" + accountID + ", workingDate=" + workingDate + '}';
    }

}