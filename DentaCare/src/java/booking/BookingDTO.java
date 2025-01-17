/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package booking;

import java.time.LocalDate;
import Service.ServiceDTO;
import account.AccountDTO;
import java.time.LocalDate;
import medicalRecord.MedicalRecordDTO;
import timeSlot.TimeSlotDTO;

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
    private float deposit;
    private int serviceID;
    private int slotID;
    private String customerID;
    private String dentistID;
    private int clinicID;
    private String fullNameDentist;
    private ServiceDTO service;
    private AccountDTO account;
    private TimeSlotDTO timeSlot;
    private MedicalRecordDTO medicalRecord;

    public BookingDTO(String bookingID, LocalDate createDay, LocalDate appointmentDay, int status, float price, float deposit, int serviceID, int slotID, String customerID, String dentistID, int clinicID) {
        this.bookingID = bookingID;
        this.createDay = createDay;
        this.appointmentDay = appointmentDay;
        this.status = status;
        this.price = price;
        this.deposit = deposit;
        this.serviceID = serviceID;
        this.slotID = slotID;
        this.customerID = customerID;
        this.dentistID = dentistID;
        this.clinicID = clinicID;
    }

    public BookingDTO() {
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

    public ServiceDTO getService() {
        return service;
    }

    public AccountDTO getAccount() {
        return account;
    }

    public TimeSlotDTO getTimeSlot() {
        return timeSlot;
    }

    public void setService(ServiceDTO service) {
        this.service = service;
    }

    public void setAccount(AccountDTO account) {
        this.account = account;
    }

    public void setTimeSlot(TimeSlotDTO timeSlot) {
        this.timeSlot = timeSlot;
    }

    public String getFullNameDentist() {
        return fullNameDentist;
    }

    public void setFullNameDentist(String fullNameDentist) {
        this.fullNameDentist = fullNameDentist;
    }

    public float getDeposit() {
        return deposit;
    }

    public void setDeposit(float deposit) {
        this.deposit = deposit;
    }

    public MedicalRecordDTO getMedicalRecord() {
        return medicalRecord;
    }

    public void setMedicalRecord(MedicalRecordDTO medicalRecord) {
        this.medicalRecord = medicalRecord;
    }
    
    @Override
    public String toString() {
        return "bookingDTO{" + "bookingID=" + bookingID + ", createDay=" + createDay + ", appointmentDay=" + appointmentDay + ", status=" + status + ", price=" + price + ", serviceID=" + serviceID + ", slotID=" + slotID + ", customerID=" + customerID + ", dentistID=" + dentistID + ", clinicID=" + clinicID + '}';
    }

}