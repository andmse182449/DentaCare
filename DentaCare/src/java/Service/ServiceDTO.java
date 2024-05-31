/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

/**
 *
 * @author ADMIN
 */
public class ServiceDTO {
    private int serviceID;
    private String serviceName;
    private String serviceType;
    private float serviceMoney;
    private int serviceStatus;
    private String serviceDescription;

    public ServiceDTO() {
    }

    public ServiceDTO(String serviceName, String serviceType, float serviceMoney, int serviceStatus, String serviceDescription) {
        this.serviceName = serviceName;
        this.serviceType = serviceType;
        this.serviceMoney = serviceMoney;
        this.serviceStatus = serviceStatus;
        this.serviceDescription = serviceDescription;
    }
    
    
    
    public ServiceDTO (int serviceID, String serviceName, String serviceType, float serviceMoney, int serviceStatus, String serviceDescription) {
        this.serviceID = serviceID;
        this.serviceName = serviceName;
        this.serviceType = serviceType;
        this.serviceMoney = serviceMoney;
        this.serviceStatus = serviceStatus;
        this.serviceDescription = serviceDescription;
    }

    public int getServiceID() {
        return serviceID;
    }

    public String getServiceName() {
        return serviceName;
    }

    public String getServiceType() {
        return serviceType;
    }

    public float getServiceMoney() {
        return serviceMoney;
    }

    public void setServiceID(int serviceID) {
        this.serviceID = serviceID;
    }

    public void setServiceName(String serviceName) {
        this.serviceName = serviceName;
    }

    public void setServiceType(String serviceType) {
        this.serviceType = serviceType;
    }

    public void setServiceMoney(float serviceMoney) {
        this.serviceMoney = serviceMoney;
    }

    public int getServiceStatus() {
        return serviceStatus;
    }

    public void setServiceStatus(int serviceStatus) {
        this.serviceStatus = serviceStatus;
    }

    public String getServiceDescription() {
        return serviceDescription;
    }

    public void setServiceDescription(String serviceDescription) {
        this.serviceDescription = serviceDescription;
    }
    
    
    
}