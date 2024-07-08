/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package medicalRecord;

/**
 *
 * @author Admin
 */
public class MedicalRecordDTO {

    private String medicalRecordID;
    private String results;
    private String bookingID;
    private String reExanime;

    public MedicalRecordDTO() {
    }

    public MedicalRecordDTO(String medicalRecordID, String results, String bookingID, String reExanime) {
        this.medicalRecordID = medicalRecordID;
        this.results = results;
        this.bookingID = bookingID;
        this.reExanime = reExanime;
    }

    public String getMedicalRecordID() {
        return medicalRecordID;
    }

    public void setMedicalRecordID(String medicalRecordID) {
        this.medicalRecordID = medicalRecordID;
    }

    public String getResults() {
        return results;
    }

    public void setResults(String results) {
        this.results = results;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    public String getReExanime() {
        return reExanime;
    }

    public void setReExanime(String reExanime) {
        this.reExanime = reExanime;
    }

    @Override
    public String toString() {
        return "MedicalRecordDTO{" + "medicalRecordID=" + medicalRecordID + ", results=" + results + ", bookingID=" + bookingID + ", reExanime=" + reExanime + '}';
    }

}