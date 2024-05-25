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

    public ServiceDTO() {
    }

    public ServiceDTO (int serviceID, String serviceName, String serviceType, float serviceMoney, int serviceStatus) {
        this.serviceID = serviceID;
        this.serviceName = serviceName;
        this.serviceType = serviceType;
        this.serviceMoney = serviceMoney;
        this.serviceStatus = serviceStatus;
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
    
    
    
}
