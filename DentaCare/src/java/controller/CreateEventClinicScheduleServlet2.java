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
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "CreateEventClinicScheduleServlet2", urlPatterns = {"/CreateEventClinicScheduleServlet2"})
public class CreateEventClinicScheduleServlet2 extends HttpServlet {

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
//            String clincScheduleId_raw = request.getParameter("clinicScheduleID");
            String id_raw = request.getParameter("clinicByID");
            String workingDay = request.getParameter("workingDay");
            String description = request.getParameter("description");

            int id = 0;
            int clinic = 0;
            int clincScheduleID = 0;

            try {
                id = Integer.parseInt(id_raw);
//                clinic = Integer.parseInt(clinicID_raw);
//                clincScheduleID = Integer.parseInt(clincScheduleId_raw);

                ClinicDAO clinicDao = new ClinicDAO();
                ClinicDTO clinicByID = clinicDao.getClinicByID(id);

                if (clinicByID != null) {
                    request.setAttribute("clinicByID", clinicByID);

                    ClinicScheduleDAO dao = new ClinicScheduleDAO();
                    List<ClinicScheduleDTO> listGetAll = dao.getAllClinicSchedule();

                    //clinicSchedule
                    ClinicScheduleDTO getByCliScheID = dao.getInfoByClinicScheduleID(clincScheduleID); // nay de lay all Info cua clinicSchedule
                    request.setAttribute("getByCliScheID", getByCliScheID);

                    boolean workingDayExists = false;
                    for (ClinicScheduleDTO clinicScheduleDTO : listGetAll) {
                        if (clinicScheduleDTO.getWorkingDay().equals("07:00 AM - 05:00 PM")) {
                            workingDayExists = true;
                            break;
                        }
                    }
                    if (!workingDayExists) {
                        boolean createEventClinicSchedule = dao.createEventClinicSchedule2(description, workingDay);
                        request.setAttribute("createEventClinicSchedule", createEventClinicSchedule);
                    } else {
                        request.setAttribute("eventAlready", "This day is an event ! Choose another days");
                    }

                } else {
                    System.out.println("Clinic with ID " + id + " not found.");
                }
                request.getRequestDispatcher("coWeb-createEventClinic2.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                System.out.println("Invalid input: " + e.getMessage());
            } catch (Exception e) {
                e.printStackTrace();
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
