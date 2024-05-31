/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package slotDetail;

/**
 *
 * @author Admin
 */
public class SlotDetailDTO {

    private int clinicScheduleID;
    private int slotID;

    public SlotDetailDTO() {
    }

    public SlotDetailDTO(int clinicScheduleID, int slotID) {
        this.clinicScheduleID = clinicScheduleID;
        this.slotID = slotID;
    }

    public int getClinicScheduleID() {
        return clinicScheduleID;
    }

    public void setClinicScheduleID(int clinicScheduleID) {
        this.clinicScheduleID = clinicScheduleID;
    }

    public int getSlotID() {
        return slotID;
    }

    public void setSlotID(int slotID) {
        this.slotID = slotID;
    }

    @Override
    public String toString() {
        return "SlotDetailDTO{" + "clinicScheduleID=" + clinicScheduleID + ", slotID=" + slotID + '}';
    }

}
