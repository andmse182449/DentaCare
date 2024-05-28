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
        
        String action = request.getParameter("action");
        
        if (action.equals("create")) {
            String username = request.getParameter("sta-username");
            String mail = request.getParameter("sta-email");
            String pass = request.getParameter("sta-password");
            String fullName = request.getParameter("sta-fullName");
            String phone = request.getParameter("sta-phone");
            String address = request.getParameter("sta-address");
            boolean res = false;
            String url = "coWeb-staff.jsp";

            try {
                AccountDAO accountDAO = new AccountDAO();
                int numOfStas = accountDAO.countStaff();

                if (!phone.matches("\\d+")) { // Changed regex to match one or more digits
                    request.setAttribute("error", "Phone number must contain only digits");
                    request.getRequestDispatcher(url).forward(request, response);
                    return;
                } else {
                    AccountDTO existed = accountDAO.checkExistAccount(username, pass);
                    if (existed == null) {
                        String accountId = "STA" + Year.now().getValue() % 100 + String.format("%05d", numOfStas + 1);
                        accountDAO.createStaff(accountId, username, pass, mail, fullName, phone, address);
                    } else {
                        res = true;
                    }

                    if (res) {
                        request.setAttribute("error", "User Name existed !");
                        request.setAttribute("ac", " active");
                    } else {
                        request.setAttribute("error", "");
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
