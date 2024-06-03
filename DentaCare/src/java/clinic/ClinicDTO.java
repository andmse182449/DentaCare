/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package clinic;

/**
 *
 * @author Admin
 */
public class ClinicDTO {

    private int clinicID;
    private String clinicName;
    private String clinicAddress;
    private String city;
    private String hotline;

    public ClinicDTO() {
    }

    public ClinicDTO(int clinicID, String clinicName, String clinicAddress, String city, String hotline) {
        this.clinicID = clinicID;
        this.clinicName = clinicName;
        this.clinicAddress = clinicAddress;
        this.city = city;
        this.hotline = hotline;
    }

    public int getClinicID() {
        return clinicID;
    }

    public void setClinicID(int clinicID) {
        this.clinicID = clinicID;
    }

    public String getClinicName() {
        return clinicName;
    }

    public void setClinicName(String clinicName) {
        this.clinicName = clinicName;
    }

    public String getClinicAddress() {
        return clinicAddress;
    }

    public void setClinicAddress(String clinicAddress) {
        this.clinicAddress = clinicAddress;
    }

    public String getCity() {
        return city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    public String getHotline() {
        return hotline;
    }

    public void setHotline(String hotline) {
        this.hotline = hotline;
    }

    @Override
    public String toString() {
        return "clinicDAO{" + "clinicID=" + clinicID + ", clinicName=" + clinicName + ", clinicAddress=" + clinicAddress + ", city=" + city + ", hotline=" + hotline + '}';
    }

}