/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDAO;
import account.AccountDTO;
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
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoadFromClinicScheduleToDentistScheduleServlet", urlPatterns = {"/LoadFromClinicScheduleToDentistScheduleServlet"})
public class LoadFromClinicScheduleToDentistScheduleServlet extends HttpServlet {

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

            String accountID = request.getParameter("accountID");
            String oldAccountID = request.getParameter("oldAccountID");
            String offDate = request.getParameter("offDate");

            DayOffScheduleDAO offDao = new DayOffScheduleDAO();

            int id = 0;
            try {
                id = Integer.parseInt(id_raw);
                if (("loadDenSchedule").equals(action)) {
                    ClinicDAO dao = new ClinicDAO();
                    ClinicDTO clinicByID = dao.getClinicByID(id);

                    if (clinicByID == null) {
                        handleClinicNotFound(request, response, id);
                        return;
                    }

                    List<DayOffScheduleDTO> off = offDao.getAllOffDate(id);

                    // dentist
                    DentistScheduleDAO dentDao = new DentistScheduleDAO();
                    List<DentistScheduleDTO> getAllDentist = dentDao.getAccountDentistByRoleID1(id);
                    List<DentistScheduleDTO> getByDate = dentDao.getDenFromDate(offDate, id);  // Check usage

                    // account
                    AccountDAO accDao = new AccountDAO();
                    List<AccountDTO> denList = accDao.searchByDenWorkingDate(offDate);
                    List<AccountDTO> listAllDentist = accDao.getAccountDentistByRoleID1(id);

                    // Set attributes for JSP
                    setRequestAttributes(request, yearStr, weekStr, id, off, clinicByID, getAllDentist, listAllDentist, denList);

                    // Handle actions based on 'key'
                    handleKeyActions(key, dentDao, accountID, offDate, oldAccountID, out, response);

                }
                // Always forward after processing all logic
                request.getRequestDispatcher("denWeb-Schedule.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(LoadFromClinicScheduleToDentistScheduleServlet.class.getName()).log(Level.SEVERE, null, ex);
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
                out.print("{\"success\": false, \"message\": \"An SQL error occurred: " + ex.getMessage() + "\"}");
                out.flush();
            }
        }
    }

    private void handleClinicNotFound(HttpServletRequest request, HttpServletResponse response, int id) throws ServletException, IOException {
        System.out.println("Clinic with ID " + id + " not found!");
        request.setAttribute("error", "Clinic not found!");
        request.getRequestDispatcher("errorPage.jsp").forward(request, response);
    }

    private void setRequestAttributes(HttpServletRequest request, String yearStr, String weekStr, int id, List<DayOffScheduleDTO> off, ClinicDTO clinicByID, List<DentistScheduleDTO> getAllDentist, List<AccountDTO> listAllDentist, List<AccountDTO> denList) {
        request.setAttribute("yearStr", yearStr);
        request.setAttribute("weekStr", weekStr);
        request.setAttribute("clinicID", id);
        request.setAttribute("off", off);
        request.setAttribute("clinicByID", clinicByID);
        request.setAttribute("getAllDentist", getAllDentist);
        request.setAttribute("listAllDentist", listAllDentist);
        request.setAttribute("denList", denList);
    }

    private void handleKeyActions(String key, DentistScheduleDAO dentDao, String accountID, String offDate, String oldAccountID, PrintWriter out, HttpServletResponse response) throws SQLException {
        if ("addDenToSchedule".equals(key)) {
            if (dentDao.checkAlreadyDentistInDenSche(accountID, offDate) == null) {
                boolean addDenToSche = dentDao.addDenToSche(accountID, offDate);
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_OK);
                out.print("{\"success\": true, \"message\": \"Add dentist successfully!\"}");
                out.flush();
            } else {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Dentist is already scheduled for this date!\"}");
                out.flush();
            }
        }
        if ("modifyDenToSchedule".equals(key)) {
            if (dentDao.checkAlreadyDentistInDenSche(oldAccountID, offDate) != null) {
                boolean modifyDentistSchedule = dentDao.modifyDentistSchedule(accountID, offDate, oldAccountID);
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_OK);
                out.print("{\"success\": true, \"message\": \"Modify dentist successfully!\"}");
                out.flush();
            } else {
                response.setContentType("application/json");
                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                out.print("{\"success\": false, \"message\": \"Dentist is not already scheduled for this date!\"}");
                out.flush();
            }
        }
    }

    // Other required methods (e.g., doGet, doPost) would be implemented here

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
