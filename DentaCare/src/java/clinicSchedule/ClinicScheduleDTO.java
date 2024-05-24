/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clinicSchedule;

import java.time.LocalDate;
import java.util.Date;

/**
 *
 * @author Admin
 */
public class ClinicScheduleDTO {

    private int clinicScheduleID;
    private String startTimeClinic;
    private String endTimeClinic;
    private String workingDay;
    private int clinicID;
    private String description;

    public ClinicScheduleDTO() {
    }

    public ClinicScheduleDTO(int clinicScheduleID, String startTimeClinic, String endTimeClinic, String workingDay, int clinicID, String description) {
        this.clinicScheduleID = clinicScheduleID;
        this.startTimeClinic = startTimeClinic;
        this.endTimeClinic = endTimeClinic;
        this.workingDay = workingDay;
        this.clinicID = clinicID;
        this.description = description;
    }

    public int getClinicScheduleID() {
        return clinicScheduleID;
    }

    public void setClinicScheduleID(int clinicScheduleID) {
        this.clinicScheduleID = clinicScheduleID;
    }

    public String getStartTimeClinic() {
        return startTimeClinic;
    }

    public void setStartTimeClinic(String startTimeClinic) {
        this.startTimeClinic = startTimeClinic;
    }

    public String getEndTimeClinic() {
        return endTimeClinic;
    }

    public void setEndTimeClinic(String endTimeClinic) {
        this.endTimeClinic = endTimeClinic;
    }

    public String getWorkingDay() {
        return workingDay;
    }

    public void setWorkingDay(String workingDay) {
        this.workingDay = workingDay;
    }

    public int getClinicID() {
        return clinicID;
    }

    public void setClinicID(int clinicID) {
        this.clinicID = clinicID;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

}
