/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDAO;
import account.AccountDTO;
import clinic.ClinicDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.SQLException;
import java.time.LocalDate;
import java.time.Year;
import java.time.format.DateTimeFormatter;
import java.time.temporal.WeekFields;
import java.util.Locale;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class DentistServlet extends HttpServlet {

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
        AccountDAO accountDAO = new AccountDAO();
        String action = request.getParameter("action");
        if (action == null) {
            action = (String) request.getAttribute("action");
        }

        if (action == null || action.equals("dentistLogin") || action == "") {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("account");
            //            String url = "denWeb-dentitstSchedule.jsp";
            int id = account.getClinicID();
            
            LocalDate now2 = LocalDate.now();
            WeekFields weekFields = WeekFields.of(Locale.getDefault());
            int currentYear2 = now2.getYear();
            int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
            
            String url = "LoadScheduleForEachDentistServlet?action=loadDenSchedule&clinicByID=" + id + "&year=" + currentYear2 + "&week=" + currentWeek2;
            if (account.getStatus() == 2) {
                url = "changePasswordFirstTime.jsp";
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                response.sendRedirect(url);
            }
        } /*CREATE DENTIST ACCOUNT */ else if (action.equals("create")) {
            int numOfDens = accountDAO.countDentist();
            String username = "bs-" + request.getParameter("den-email").trim().split("@")[0] + String.format("%03d", numOfDens + 1);
            String mail = request.getParameter("den-email").trim();
            String pass = "abc@demo";
            String fullName = request.getParameter("den-fullName").trim();
            String phone = request.getParameter("den-phone").trim();
            String address = request.getParameter("den-address").trim();
            int clinicID = Integer.parseInt(request.getParameter("den-clinic"));
            String url = "coWeb-dentist.jsp";
            try {
                if (!phone.matches("\\d+")) { // Changed regex to match one or more digits
                    request.setAttribute("error", "Phone number must contain only digits");
                    request.getRequestDispatcher(url).forward(request, response);
                    return;
                } else {
                    String existed = accountDAO.checkExistName(username);
                    if (existed == null) {
                        if (!mail.equalsIgnoreCase(accountDAO.checkExistEmail(mail))) {
                            String accountId = "DEN" + Year.now().getValue() % 100 + String.format("%05d", numOfDens + 1);
                            if (accountDAO.createDentist(accountId, username, pass, mail, fullName, phone, address, clinicID)) {
                                request.setAttribute("mail", mail);
                                url = "SendEmailAccountInfoServlet";
                            } else {
                                request.setAttribute("error", "Create failed!");
                            }
                        } else {
                            request.setAttribute("error", "Email registed!");
                        }
                    } else {
                        request.setAttribute("error", "Username existed !");
                    }
                }

                request.getRequestDispatcher(url).forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("error", "An error occurred while processing your request.");
                request.getRequestDispatcher(url).forward(request, response);
            }
        } /* UPDATE DENTIST PROFILE */ else if (action.equals("update")) {
            String fullName = request.getParameter("den-fullName").trim();
            String phone = request.getParameter("den-phone").trim();
            String address = request.getParameter("den-address").trim();
            String email = request.getParameter("den-email").trim();
            String dob_raw = request.getParameter("den-dob").trim();
            boolean gender = Boolean.parseBoolean(request.getParameter("den-gender").trim());
            String accountID = request.getParameter("accountID");
            String url = "denWeb-dentistProfile.jsp";
            try {
                if (!phone.matches("\\d+")) { // Changed regex to match one or more digits
                    request.setAttribute("error", "Phone number must contain only digits");
                    request.getRequestDispatcher(url).forward(request, response);
                    return;
                } else {
                    DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                    LocalDate date = LocalDate.parse(dob_raw, formatter);
                    if (!accountDAO.updateDentistProfile(fullName, phone, address, email, date, gender, accountID)) {
                        request.setAttribute("error", "Update failed!");
                    } else {
                        request.setAttribute("message", "Update successfully!");
                    }
                }
                AccountDTO account = accountDAO.searchAccountByID(accountID);
                request.setAttribute("account", account);
                request.getRequestDispatcher(url).forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("error", "An error occurred while processing your request.");
                request.getRequestDispatcher(url).forward(request, response);
            }
        } /* LOAD DENTIST PROFILE */ else if (action.equals("profile")) {
            String accountId = (String) request.getAttribute("accountID");
            if (accountId == null) {
                accountId = request.getParameter("accountID");
            }
            String url = "denWeb-dentistProfile.jsp";
            try {
                AccountDTO account = accountDAO.searchAccountByID(accountId);
                request.setAttribute("account", account);

                ClinicDAO clinicDao = new ClinicDAO();
                String clinicName = clinicDao.getClinicByID(account.getClinicID()).getClinicName();

                request.setAttribute("clinic", clinicName);
                request.getRequestDispatcher(url).forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("error", "An error occurred while processing your request.");
                request.getRequestDispatcher(url).forward(request, response);
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
