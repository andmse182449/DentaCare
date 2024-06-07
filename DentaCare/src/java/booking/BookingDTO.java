/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package booking;

import java.time.LocalDate;

/**
 *
 * @author Admin
 */
public class BookingDTO {
    private String bookingID;
    private LocalDate createDay;
    private LocalDate appointmentDay;
    private int status;
    private float price;
    private int serviceID;
    private int slotID;
    private String customerID;
    private String dentistID;
    private int clinicID;

    public BookingDTO(String bookingID, LocalDate createDay, LocalDate appointmentDay, int status, float price, int serviceID, int slotID, String customerID, String dentistID, int clinicID) {
        this.bookingID = bookingID;
        this.createDay = createDay;
        this.appointmentDay = appointmentDay;
        this.status = status;
        this.price = price;
        this.serviceID = serviceID;
        this.slotID = slotID;
        this.customerID = customerID;
        this.dentistID = dentistID;
        this.clinicID = clinicID;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public LocalDate getCreateDay() {
        return createDay;
    }

    public void setCreateDay(LocalDate createDay) {
        this.createDay = createDay;
    }

    public LocalDate getAppointmentDay() {
        return appointmentDay;
    }

    public void setAppointmentDay(LocalDate appointmentDay) {
        this.appointmentDay = appointmentDay;
    }

    public int getStatus() {
        return status;
    }

    public void setStatus(int status) {
        this.status = status;
    }

    public float getPrice() {
        return price;
    }

    public void setPrice(float price) {
        this.price = price;
    }

    public int getServiceID() {
        return serviceID;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public int getSlotID() {
        return slotID;
    }

    public void setSlotID(int slotID) {
        this.slotID = slotID;
    }

    public String getCustomerID() {
        return customerID;
    }

    public void setCustomerID(String customerID) {
        this.customerID = customerID;
    }

    public String getDentistID() {
        return dentistID;
    }

    public void setDentistID(String dentistID) {
        this.dentistID = dentistID;
    }

    public int getClinicID() {
        return clinicID;
    }

    public void setClinicID(int clinicID) {
        this.clinicID = clinicID;
    }

    @Override
    public String toString() {
        return "bookingDTO{" + "bookingID=" + bookingID + ", createDay=" + createDay + ", appointmentDay=" + appointmentDay + ", status=" + status + ", price=" + price + ", serviceID=" + serviceID + ", slotID=" + slotID + ", customerID=" + customerID + ", dentistID=" + dentistID + ", clinicID=" + clinicID + '}';
    }
    
    
}
