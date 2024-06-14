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
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("account");
            System.out.println(account);
            String id_raw = request.getParameter("clinicByID");
            String action = request.getParameter("action");

            String yearStr = request.getParameter("year");
            String weekStr = request.getParameter("week");

            System.out.println(yearStr);
            System.out.println(weekStr);
            int id = 0;

//
//            String offDate = request.getParameter("offDate");
            DayOffScheduleDAO offDao = new DayOffScheduleDAO();

            try {
                id = Integer.parseInt(id_raw);
                if (("loadDenSchedule").equals(action)) {
                    ClinicDAO dao = new ClinicDAO();

                    ClinicDTO clinicByID = dao.getClinicByID(id);
                    if (clinicByID == null) {
                        System.out.println("Clinic with ID " + id + " not found!");
                        request.setAttribute("error", "Clinic not found!");
                        request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                        return;
                    }

                    List<DayOffScheduleDTO> off = offDao.getAllOffDate(id);

                    // dentist
                    DentistScheduleDAO dentDao = new DentistScheduleDAO();
                    List<DentistScheduleDTO> getEachdentist = dentDao.checkSesssionDen(account.getAccountID()); // null

                    List<DentistScheduleDTO> getAllDentist = dentDao.getAccountDentistByRoleID1(id);

                    // account
//                    AccountDAO accDao = new AccountDAO();

                    request.setAttribute("yearStr", yearStr);
                    request.setAttribute("weekStr", weekStr);
                    request.setAttribute("off", off);
                    request.setAttribute("getAllDentist", getAllDentist);
                    request.setAttribute("getEachdentist", getEachdentist);
                                        request.setAttribute("clinicByID", clinicByID);

                }

//denWeb-dentitstSchedule
                request.getRequestDispatcher("denWeb-dentitstSchedule.jsp").forward(request, response);
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
