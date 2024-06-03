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

    private String accountID;
    private int clinicScheduleID;

    public DentistScheduleDTO() {
    }

    public DentistScheduleDTO(String accountID, int clinicScheduleID) {
        this.accountID = accountID;
        this.clinicScheduleID = clinicScheduleID;
    }

    public String getAccountID() {
        return accountID;
    }

    public void setAccountID(String accountID) {
        this.accountID = accountID;
    }

    public int getClinicScheduleID() {
        return clinicScheduleID;
    }

    public void setClinicScheduleID(int clinicScheduleID) {
        this.clinicScheduleID = clinicScheduleID;
    }

    @Override
    public String toString() {
        return "DentistScheduleDTO{" + "accountID=" + accountID + ", clinicScheduleID=" + clinicScheduleID + '}';
    }

}
