/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package Service;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

/**
 *
 * @author ADMIN
 */
public class ServiceDAO {

    public boolean addService(ServiceDTO service) {
        String sql = "INSERT INTO service (servicename, servicetype, price, status, description) VALUES (?,?,?,?,?)";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceType());
            ps.setFloat(3, service.getServiceMoney());
            ps.setFloat(4, service.getServiceStatus());
            ps.setString(5, service.getServiceDescription());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("Add service: " + e.getMessage());
            return false;
        }
        return true;
    }

    public boolean changeStatus(int serviceID) {
        String sql = "update service set status = 1 WHERE serviceid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, serviceID);
            ps.execute();
        } catch (SQLException e) {
            System.out.println("Status service: " + e.getMessage());
            return false;
        }
        return true;
    }

    public boolean changeStatusActive(int serviceID) {
        String sql = "update service set status = 0 WHERE serviceid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, serviceID);
            ps.execute();
        } catch (SQLException e) {
            System.out.println("Status service: " + e.getMessage());
            return false;
        }
        return true;
    }

    public boolean updateService(ServiceDTO service) {
        String sql = "UPDATE service SET servicename = ?, servicetype = ?, price = ?, status = ?, description = ? WHERE serviceid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceType());
            ps.setFloat(3, service.getServiceMoney());
            ps.setInt(4, service.getServiceStatus());
            ps.setString(5, service.getServiceDescription());
            ps.setInt(6, service.getServiceID());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("Update service: " + e.getMessage());
            return false;
        }
        return true;
    }

    public boolean checkService(String serviceName) {
        String sql = "SELECT * FROM service WHERE servicename = ?";
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql)) {
            ps.setString(1, serviceName);
            ResultSet rs = ps.executeQuery();
            return rs.next();
        } catch (SQLException e) {
            System.out.println("Check service: " + e.getMessage());
        }
        return false;
    }

    public int countServiceName(String serviceName) {
        String sql = "select count(serviceId) from service where servicename = ? group by servicename";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, serviceName);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                return rs.getInt(1);
            }
        } catch (SQLException e) {
            System.out.println(e.getMessage());
        }
        return 0;
    }

    public List<ServiceDTO> listAllServiceActive() {
        String sql = "SELECT * FROM service where status = 0";
        List<ServiceDTO> list = new ArrayList<>();
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ServiceDTO service = new ServiceDTO();
                service.setServiceID(rs.getInt("serviceid"));
                service.setServiceName(rs.getString("servicename"));
                service.setServiceType(rs.getString("servicetype"));
                service.setServiceMoney(rs.getFloat("price"));
                service.setServiceDescription(rs.getString("description"));
                list.add(service);
            }
        } catch (SQLException e) {
            System.out.println("List all service: " + e.getMessage());
            return null;
        }
        return list;
    }

    public List<ServiceDTO> listAllServiceUnactive() {
        String sql = "SELECT * FROM service where status = 1";
        List<ServiceDTO> list = new ArrayList<>();
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                ServiceDTO service = new ServiceDTO();
                service.setServiceID(rs.getInt("serviceid"));
                service.setServiceName(rs.getString("servicename"));
                service.setServiceType(rs.getString("servicetype"));
                service.setServiceMoney(rs.getFloat("price"));
                service.setServiceDescription(rs.getString("description"));
                list.add(service);
            }
        } catch (SQLException e) {
            System.out.println("List all service: " + e.getMessage());
            return null;
        }
        return list;
    }

    public List<String> listServiceType() {
        String sql = "select servicetype from service group by servicetype";
        List<String> listServiceType = new ArrayList<>();
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                String serviceType = rs.getString("servicetype");
                listServiceType.add(serviceType);
            }
        } catch (SQLException e) {
            System.out.println("List Service Type: " + e.getMessage());
        }
        return listServiceType;
    }

    public ServiceDTO getServiceByID(int serviceID) {
        String sql = "SELECT * FROM SERVICE WHERE serviceID = ? ";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            if (rs.next()) {
                String serviceName = rs.getString("serviceName");
                String serviceType = rs.getString("serviceType");
                String description = rs.getString("description");
                float price = rs.getFloat("price");
                int status = rs.getInt("status");
                ServiceDTO service = new ServiceDTO(serviceID, serviceName, serviceType, price, status, description);
                return service;
            }
        } catch (SQLException e) {
            System.out.println("List Service Type: " + e.getMessage());
        }
        return null;
    }

}
