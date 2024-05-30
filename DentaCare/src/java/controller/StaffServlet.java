/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDAO;
import account.AccountDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.sql.SQLException;
import java.time.Year;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
public class StaffServlet extends HttpServlet {

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
        
        if (action == null || action.equals("staffLogin") || action == "") {
            HttpSession session = request.getSession();
            AccountDTO account = (AccountDTO) session.getAttribute("account");
            String url = "staWeb-abc.jsp";
            if (account.getStatus() == 2) {
                url = "changePasswordFirstTime.jsp";
                request.getRequestDispatcher(url).forward(request, response);
            } else {
                response.sendRedirect(url);
            }
        }
        else if (action.equals("create")) {
            int numOfStas = accountDAO.countStaff();
            String username = "nv-" + request.getParameter("sta-email").trim().split("@")[0] + String.format("%03d", numOfStas + 1);
            String mail = request.getParameter("sta-email").trim();
            String pass = "abc@demo";
            String fullName = request.getParameter("sta-fullName").trim();
            String phone = request.getParameter("sta-phone").trim();
            String address = request.getParameter("sta-address").trim();
            int clinicID = Integer.parseInt(request.getParameter("sta-clinic"));
            String url = "coWeb-staff.jsp";

            try {
                if (!phone.matches("\\d+")) { // Changed regex to match one or more digits
                    request.setAttribute("error", "Phone number must contain only digits");
                    request.getRequestDispatcher(url).forward(request, response);
                    return;
                } else {
                    String existed = accountDAO.checkExistName(username);
                    if (existed == null) {
                        if (!mail.equalsIgnoreCase(accountDAO.checkExistEmail(mail))) {
                            String accountId = "STA" + Year.now().getValue() % 100 + String.format("%05d", numOfStas + 1);
                            if (accountDAO.createStaff(accountId, username, pass, mail, fullName, phone, address, clinicID)) {
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
