/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import clinic.ClinicDAO;
import clinic.ClinicDTO;
import clinicSchedule.ClinicScheduleDAO;
import clinicSchedule.ClinicScheduleDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoadFromClinicScheduleToCreateEventServlet", urlPatterns = {"/LoadFromClinicScheduleToCreateEventServlet"})
public class LoadFromClinicScheduleToCreateEventServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String id_raw = request.getParameter("clinicByID");
            String clincScheduleId_raw = request.getParameter("clinicScheduleID");

            int clincScheduleID = 0;
            int id = 0;
            try {
                clincScheduleID = Integer.parseInt(clincScheduleId_raw);
                id = Integer.parseInt(id_raw);
                ClinicDAO dao = new ClinicDAO();
                ClinicDTO clinicByID = null;
                clinicByID = dao.getClinicByID(id);

                //clinicSchedule
                ClinicScheduleDAO cliDao = new ClinicScheduleDAO();
                ClinicScheduleDTO getByCliScheID = cliDao.getInfoByClinicScheduleID(clincScheduleID); // nay de lay all Info cua clinicSchedule
                request.setAttribute("getByCliScheID", getByCliScheID);

                if (clinicByID != null) {
                    request.setAttribute("clinicByID", clinicByID);
                } else {
                    System.out.println("kh co clinicByID ne` !");
                }
                request.getRequestDispatcher("coWeb-createEventClinic.jsp").forward(request, response);
                request.getRequestDispatcher("coWeb-createEventClinic2.jsp").forward(request, response);

            } catch (SQLException ex) {
                Logger.getLogger(LoadFromClinicScheduleToAddServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        }
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
