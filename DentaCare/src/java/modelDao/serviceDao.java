/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package modelDao;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import model.Service;

/**
 *
 * @author ADMIN
 */
public class serviceDao {

    public boolean addService(Service service) throws ClassNotFoundException {
        String sql = "INSERT INTO service (serviceid, servicename, servicetype, price) VALUES (?,?,?,?)";
        try {
            Connection con = DBUtils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, service.getServiceID());
            ps.setString(2, service.getServiceName());
            ps.setString(3, service.getServiceType());
            ps.setFloat(4, service.getServiceMoney());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("Add service: " + e.getMessage());
            return false;
        }
        return true;
    }

    public boolean deleteService(int serviceID) throws ClassNotFoundException {
        String sql = "DELETE FROM service WHERE serviceid = ?";
        try {
            Connection con = DBUtils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, serviceID);
            ps.execute();
        } catch (SQLException e) {
            System.out.println("Delete service: " + e.getMessage());
            return false;
        }
        return true;
    }

    public boolean updateService(Service service) throws ClassNotFoundException {
        String sql = "UPDATE service SET servicename = ?, servicetype = ?, price = ? WHERE serviceid = ?";
        try {
            Connection con = DBUtils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setString(1, service.getServiceName());
            ps.setString(2, service.getServiceType());
            ps.setFloat(3, service.getServiceMoney());
            ps.setInt(4, service.getServiceID());
            ps.execute();
        } catch (SQLException e) {
            System.out.println("Update service: " + e.getMessage());
            return false;
        }
        return true;
    }

    public boolean checkService(int serviceID) throws ClassNotFoundException {
        String sql = "SELECT * FROM service WHERE serviceid = ?";
        try {
            Connection con = DBUtils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ps.setInt(1, serviceID);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service();
                service.setServiceID(rs.getInt("serviceid"));
                service.setServiceName(rs.getString("servicename"));
                service.setServiceType(rs.getString("servicetype"));
                service.setServiceMoney(rs.getFloat("price"));
            }
        } catch (SQLException e) {
            System.out.println("Check service: " + e.getMessage());
            return false;
        }
        return true;
    }

    public List<Service> listAllService() throws ClassNotFoundException {
        String sql = "SELECT * FROM service";
        List<Service> list = new ArrayList<>();
        try {
            Connection con = DBUtils.DBUtils.getConnection();
            PreparedStatement ps = con.prepareStatement(sql);
            ResultSet rs = ps.executeQuery();
            while (rs.next()) {
                Service service = new Service();
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
