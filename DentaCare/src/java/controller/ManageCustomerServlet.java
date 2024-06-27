/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDAO;
import account.AccountDTO;
import account.StaffAccountDAO;
import booking.BookingDAO;
import booking.BookingDTO;
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
 * @author ADMIN
 */
@WebServlet(name = "ManageCustomerServlet", urlPatterns = {"/ManageCustomerServlet"})
public class ManageCustomerServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            /* TODO output your page here. You may use following sample code. */
            String action = request.getParameter("action");
            StaffAccountDAO customerDao = new StaffAccountDAO();
            BookingDAO bookingDao = new BookingDAO();
            AccountDAO accountDao = new AccountDAO();
            if (action == null) {
                List<AccountDTO> listCustomerActive = customerDao.listAccount(0, 0);
                List<AccountDTO> listCustomerUnactive = customerDao.listAccount(0, 1);
                request.setAttribute("listAccountActive", listCustomerActive);
                request.setAttribute("listAccountUnactive", listCustomerUnactive);
                request.setAttribute("style", "none");
                request.getRequestDispatcher("coWeb-tableListCustomer.jsp").forward(request, response);
            } else if (action.equals("deteleCustomer")) {
                String customerUserName = request.getParameter("customerUserName");
                customerDao.updateStaffAccountUnactive(customerUserName);
                List<AccountDTO> listCustomerActive = customerDao.listAccount(0, 0);
                List<AccountDTO> listCustomerUnactive = customerDao.listAccount(0, 1);
                request.setAttribute("listAccountActive", listCustomerActive);
                request.setAttribute("listAccountUnactive", listCustomerUnactive);
                request.setAttribute("style", "none");
                request.getRequestDispatcher("coWeb-tableListCustomer.jsp").forward(request, response);
            } else if (action.equals("addAgainStaff")) {
                String customerUserName = request.getParameter("customerUserName");
                customerDao.updateStaffAccountActive(customerUserName);
                List<AccountDTO> listCustomerActive = customerDao.listAccount(0, 0);
                List<AccountDTO> listCustomerUnactive = customerDao.listAccount(0, 1);
                request.setAttribute("listAccountActive", listCustomerActive);
                request.setAttribute("listAccountUnactive", listCustomerUnactive);
                request.setAttribute("style", "none");
                request.getRequestDispatcher("coWeb-tableListCustomer.jsp").forward(request, response);
            } else if (action.equals("viewBookingOfCustomer")) {
                String customerID = request.getParameter("customerID");
                AccountDTO customer = accountDao.searchAccountByID(customerID);
                request.setAttribute("customer", customer);
                List<BookingDTO> listBooking = bookingDao.getAllBookingCustomer(customerID);
                request.setAttribute("listBookingOfCustomer", listBooking);
                List<AccountDTO> listCustomerActive = customerDao.listAccount(0, 0);
                List<AccountDTO> listCustomerUnactive = customerDao.listAccount(0, 1);
                request.setAttribute("listAccountActive", listCustomerActive);
                request.setAttribute("listAccountUnactive", listCustomerUnactive);
                request.setAttribute("style", "block");
                request.getRequestDispatcher("coWeb-tableListCustomer.jsp").forward(request, response);
            } else if (action.equals("closePopUp")) {
                List<AccountDTO> listCustomerActive = customerDao.listAccount(0, 0);
                List<AccountDTO> listCustomerUnactive = customerDao.listAccount(0, 1);
                request.setAttribute("listAccountActive", listCustomerActive);
                request.setAttribute("listAccountUnactive", listCustomerUnactive);
                request.setAttribute("style", "none");
                request.getRequestDispatcher("coWeb-tableListCustomer.jsp").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageCustomerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ManageCustomerServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
