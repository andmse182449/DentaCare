/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import clinic.ClinicDAO;
import clinic.ClinicDTO;
import clinicSchedule.ClinicScheduleDAO;
import clinicSchedule.ClinicScheduleDTO;
import account.AccountDAO;
import account.AccountDTO;
import account.Encoder;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;



public class ChangePasswordServlet extends HttpServlet {

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
        if (action.equals("changePasswordFirst")) {
            String accountId = request.getParameter("accountID");
            String password = request.getParameter("new-password");
            String url = "SignOutServlet";
            try {
                AccountDAO accountDAO = new AccountDAO();
                if (accountDAO.changePasswordFirstLogin(password, accountId)) {
                    request.getRequestDispatcher(url).forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
                request.setAttribute("error", "An error occurred while processing your request.");
                request.getRequestDispatcher(url).forward(request, response);
            }
        } else  if (action.equals("change")) {
            Encoder encode = new Encoder();
            try {
                HttpSession session = request.getSession();
                AccountDTO account = (AccountDTO) session.getAttribute("account");
                String oldPass = request.getParameter("register-pass");

                AccountDAO accountDAO = new AccountDAO();
                if (account.getPassword().equals(encode.encode(oldPass))) {
                    String newPass = request.getParameter("newPass");
                    accountDAO.resetPassword(account.getEmail(), newPass);
//                    request.setAttribute("match", "Password changed successfully!");
                    response.sendRedirect("SignOutServlet");
                } else {
                    request.setAttribute("unmatch", "Old Password does not match !");
                    request.getRequestDispatcher("user-information.jsp").forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(ChangePasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
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
