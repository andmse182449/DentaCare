/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import clinic.ClinicDAO;
import clinic.ClinicDTO;
import dayOffSchedule.DayOffScheduleDAO;
import dayOffSchedule.DayOffScheduleDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import timeSlot.TimeSlotDAO;
import timeSlot.TimeSlotDTO;

/**
 *
 * @author Admin
 */
public class LoadFromClinicToScheduleServlet extends HttpServlet {

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
            String action = request.getParameter("action");
            String key = request.getParameter("key");

            String id_raw = request.getParameter("clinicByID");
            String yearStr = request.getParameter("year");
            String weekStr = request.getParameter("week");

            String description = request.getParameter("description");
            String offDate = request.getParameter("offDate");

            DayOffScheduleDAO offDao = new DayOffScheduleDAO();

            String url = "";
            int id = 0;
            System.out.println(yearStr);
            System.out.println(weekStr);
            try {
                id = Integer.parseInt(id_raw);
                if (("loadClinicSchedule").equals(action)) {
                    ClinicDAO dao = new ClinicDAO();

                    ClinicDTO clinicByID = dao.getClinicByID(id);
                    if (clinicByID == null) {
                        System.out.println("Clinic with ID " + id + " not found!");
                        request.setAttribute("error", "Clinic not found!");
                        request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                        return;
                    }

                    List<DayOffScheduleDTO> off = offDao.getAllOffDate(id);

                    // Time Slot
                    TimeSlotDAO timeDao = new TimeSlotDAO();
                    List<TimeSlotDTO> getAllTimeSlot = timeDao.getAllTimeSLot();

                    // Send month and year to clinicSchedule.jsp
                    request.setAttribute("yearStr", yearStr);
                    request.setAttribute("weekStr", weekStr);

                    request.setAttribute("off", off);
                    request.setAttribute("clinicID", id);
                    request.setAttribute("clinicByID", clinicByID);
                    request.setAttribute("getAllTimeSlot", getAllTimeSlot);
                    if ("setEvent".equals(key)) {
                        boolean addNewOffDate = offDao.addNewOffDate(offDate, description, id);
                        response.setContentType("application/json");
                        response.setStatus(HttpServletResponse.SC_OK);
                        out.print("{\"success\": true, \"message\": \"Create event successfully !\"}");
                        out.flush();
//                        request.setAttribute("addNewOffDate", addNewOffDate);
                    }
                    if ("modifyEvent".equals(key)) {
                        offDao.modifyEvent(offDate, description, id);
                        response.setContentType("application/json");
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.print("{\"success\": false, \"message\": \"Modify event successfully !\"}");
                        out.flush();
//                        request.setAttribute("modifyEvent", modifyEvent);
                    }
                }
//coWeb-clinic
                request.getRequestDispatcher("coWeb-clinic.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                System.out.println("Parse error");
                e.printStackTrace();
            } catch (SQLException ex) {
                Logger.getLogger(LoadFromClinicToScheduleServlet.class.getName()).log(Level.SEVERE, null, ex);
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
