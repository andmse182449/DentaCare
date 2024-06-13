/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package dayOffSchedule;

/**
 *
 * @author Admin
 */
public class DayOffScheduleDTO {

    private int dayOffScheduleID;
    private String dayOff;
    private String description;
    private int clinicID;

    public DayOffScheduleDTO() {
    }

    public DayOffScheduleDTO(int dayOffScheduleID, String dayOff, String description, int clinicID) {
        this.dayOffScheduleID = dayOffScheduleID;
        this.dayOff = dayOff;
        this.description = description;
        this.clinicID = clinicID;
    }

    public int getDayOffScheduleID() {
        return dayOffScheduleID;
    }

    public void setDayOffScheduleID(int dayOffScheduleID) {
        this.dayOffScheduleID = dayOffScheduleID;
    }

    public String getDayOff() {
        return dayOff;
    }

    public void setDayOff(String dayOff) {
        this.dayOff = dayOff;
    }

    public String getDescription() {
        return description;
    }

    public void setDescription(String description) {
        this.description = description;
    }

    public int getClinicID() {
        return clinicID;
    }

    public void setClinicID(int clinicID) {
        this.clinicID = clinicID;
    }

    @Override
    public String toString() {
        return "DayOffScheduleDTO{" + "dayOffScheduleID=" + dayOffScheduleID + ", dayOff=" + dayOff + ", description=" + description + ", clinicID=" + clinicID + '}';
    }

}