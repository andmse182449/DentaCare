/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Service.ServiceDTO;
import Service.ServiceDao;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ServiceController", urlPatterns = {"/ServiceController"})
public class ServiceController extends HttpServlet {


    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");

        String action = request.getParameter("action");
        ServiceDao dao = new ServiceDao();
        if (action == null) {
            //Show service
            List<ServiceDTO> listActive = dao.listAllServiceActive();
            List<ServiceDTO> listUnactive = dao.listAllServiceUnactive();
            request.setAttribute("listActive", listActive);
            request.setAttribute("listUnactive", listUnactive);
            request.getRequestDispatcher("admin-front-end/tableList.jsp").forward(request, response);
        } else if (action.equals("update")) {
            //Udpate Service
            int serviceID = Integer.parseInt(request.getParameter("serviceId"));
            String serviceName = request.getParameter("serviceName");
            String serviceType = request.getParameter("serviceType");
            float serviceMoney = Float.parseFloat(request.getParameter("serviceMoney"));
            if (dao.checkService(serviceName)) {
                request.setAttribute("error", "Duplicated service name");
                List<ServiceDTO> listActive = dao.listAllServiceActive();
                List<ServiceDTO> listUnactive = dao.listAllServiceUnactive();
                request.setAttribute("listActive", listActive);
                request.setAttribute("listUnactive", listUnactive);
                request.getRequestDispatcher("admin-front-end/tableList.jsp").forward(request, response);
                return;
            }
            ServiceDTO service = new ServiceDTO(serviceID, serviceName, serviceType, serviceMoney, 0);
            dao.updateService(service);
            List<ServiceDTO> list = dao.listAllServiceActive();
            request.setAttribute("listActive", list);
            List<ServiceDTO> listUnactive = dao.listAllServiceUnactive();
            request.setAttribute("listUnactive", listUnactive);
            request.getRequestDispatcher("admin-front-end/tableList.jsp").forward(request, response);            
        } else if (action.equals("delete")) {
            //Delete Service
            int serviceID = Integer.parseInt(request.getParameter("serviceId"));
            dao.changeStatus(serviceID);
            List<ServiceDTO> listActive = dao.listAllServiceActive();
            List<ServiceDTO> listUnactive = dao.listAllServiceUnactive();
            request.setAttribute("listActive", listActive);
            request.setAttribute("listUnactive", listUnactive);
            request.getRequestDispatcher("admin-front-end/tableList.jsp").forward(request, response);
        } else if (action.equals("add")) {
            //Add service
            String serviceName = request.getParameter("serviceName");
            String serviceType = request.getParameter("serviceType");
            float serviceMoney = Float.parseFloat(request.getParameter("serviceMoney"));
            int serviceId = dao.maxId();
            ServiceDTO service = new ServiceDTO(++serviceId, serviceName, serviceType, serviceMoney, 0);
            dao.addService(service);
            List<ServiceDTO> list = dao.listAllServiceActive();
            List<ServiceDTO> listUnactive = dao.listAllServiceUnactive();
            request.setAttribute("listActive", list);
            request.setAttribute("listUnactive", listUnactive);
            request.getRequestDispatcher("admin-front-end/tableList.jsp").forward(request, response);
        } else if (action.equals("addAgain")) {
            // Add again service
            int serviceID = Integer.parseInt(request.getParameter("serviceId"));
            dao.changeStatusActive(serviceID);
            List<ServiceDTO> listActive = dao.listAllServiceActive();
            List<ServiceDTO> listUnactive = dao.listAllServiceUnactive();
            request.setAttribute("listActive", listActive);
            request.setAttribute("listUnactive", listUnactive);
            request.getRequestDispatcher("admin-front-end/tableList.jsp").forward(request, response);
        }
        System.out.println(action);
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}