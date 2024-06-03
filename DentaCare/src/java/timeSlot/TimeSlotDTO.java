/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package timeSlot;

/**
 *
 * @author Admin
 */
public class TimeSlotDTO {

    private int slotID;
    private String timePeriod;

    public TimeSlotDTO() {
    }

    public TimeSlotDTO(int slotID, String timePeriod) {
        this.slotID = slotID;
        this.timePeriod = timePeriod;
    }

    public int getSlotID() {
        return slotID;
    }

    public void setSlotID(int slotID) {
        this.slotID = slotID;
    }

    public String getTimePeriod() {
        return timePeriod;
    }

    public void setTimePeriod(String timePeriod) {
        this.timePeriod = timePeriod;
    }

    @Override
    public String toString() {
        return "TimeSlotDTO{" + "slotID=" + slotID + ", timePeriod=" + timePeriod + '}';
    }

}
