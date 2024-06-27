/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDTO;
import booking.BookingDAO;
import clinic.ClinicDAO;
import clinic.ClinicDTO;
import dayOffSchedule.DayOffScheduleDAO;
import dayOffSchedule.DayOffScheduleDTO;
import dentistSchedule.DentistScheduleDAO;
import dentistSchedule.DentistScheduleDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoadScheduleForEachDentistServlet", urlPatterns = {"/LoadScheduleForEachDentistServlet"})
public class LoadScheduleForEachDentistServlet extends HttpServlet {

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
        response.setContentType("application/json");

        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("account");
            System.out.println(account);
            String id_raw = request.getParameter("clinicByID");
            String action = request.getParameter("action");

            String yearStr = request.getParameter("year");
            String weekStr = request.getParameter("week");

//            String selectedDateDisplay = request.getParameter("selectedDateDisplay");
            System.out.println(yearStr);
            System.out.println(weekStr);
            int id = 0;

            // Initialize DAO objects
            DayOffScheduleDAO offDao = new DayOffScheduleDAO();
            ClinicDAO dao = new ClinicDAO();
            DentistScheduleDAO dentDao = new DentistScheduleDAO();
            BookingDAO bookDao = new BookingDAO();

            try {
                id = Integer.parseInt(id_raw);
                if (("loadDenSchedule").equals(action)) {
                    // Get clinic details
                    ClinicDTO clinicByID = dao.getClinicByID(id);
                    if (clinicByID == null) {
                        System.out.println("Clinic with ID " + id + " not found!");
                        request.setAttribute("error", "Clinic not found!");
                        request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                        return;
                    }
                    List<DayOffScheduleDTO> off = offDao.getAllOffDate(id);

                    List<DentistScheduleDTO> getEachdentist = dentDao.checkSesssionDen(account.getAccountID()); // null
                    List<DentistScheduleDTO> getAllDentist = dentDao.getAccountDentistByRoleID1(id);

                    request.setAttribute("yearStr", yearStr);
                    request.setAttribute("weekStr", weekStr);
                    request.setAttribute("off", off);
                    request.setAttribute("getAllDentist", getAllDentist);
                    request.setAttribute("getEachdentist", getEachdentist);
                    request.setAttribute("clinicByID", clinicByID);

                }
                request.getRequestDispatcher("denWeb-dentitstSchedule.jsp").forward(request, response);

            } catch (Exception ex) {
                Logger.getLogger(LoadFromClinicScheduleToDentistScheduleServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\": false, \"message\": \"An SQL error occurred: " + ex.getMessage() + "\"}");
                out.flush();
            }
        }
    }

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
