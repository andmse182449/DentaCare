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
public class ServiceDao {

    public int maxId() {
        String sql = "select max(serviceid) as max from service";
        try (Connection con = utils.DBUtils.getConnection(); PreparedStatement ps = con.prepareStatement(sql); ResultSet rs = ps.executeQuery()) {

            if (rs.next()) {
                int maxId = rs.getInt("max");
                return maxId;
            }
        } catch (SQLException e) {
            System.out.println("Get max ID: " + e.getMessage());
        }
        return 0;
    }

    public boolean addService(ServiceDTO service) {
        String sql = "INSERT INTO service (serviceid, servicename, servicetype, price, status) VALUES (?,?,?,?,?)";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, service.getServiceID());
            ps.setString(2, service.getServiceName());
            ps.setString(3, service.getServiceType());
            ps.setFloat(4, service.getServiceMoney());
            ps.setFloat(5, service.getServiceStatus());
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
        String sql = "UPDATE service SET servicename = ?, servicetype = ?, price = ?, status = ? WHERE serviceid = ?";
        try {
            Connection con = utils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceType());
            ps.setFloat(3, service.getServiceMoney());
            ps.setInt(4, service.getServiceStatus());
            ps.setInt(5, service.getServiceID());
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
                list.add(service);
            }
        } catch (SQLException e) {
            System.out.println("List all service: " + e.getMessage());
            return null;
        }
        return list;
    }

}
