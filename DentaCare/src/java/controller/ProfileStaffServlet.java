/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDTO;
import account.StaffAccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "ProfileStaffServlet", urlPatterns = {"/ProfileStaffServlet"})
public class ProfileStaffServlet extends HttpServlet {

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
            HttpSession session = request.getSession();
            StaffAccountDAO dao = new StaffAccountDAO();
            if (action == null) {
                session.getAttribute("account");
                request.getRequestDispatcher("staffWeb-ProfileStaff.jsp").forward(request, response);
            } else if (action.equals("updateProfileStaff")) {
                String accountId = request.getParameter("accountId");
                String userName = request.getParameter("username");
                String fullName = request.getParameter("fullName");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String dobStr = request.getParameter("dob");
                String genderStr = request.getParameter("gender");
                boolean gender = "Male".equals(genderStr);
                if (phone == null || address == null || dobStr == null) {
                    phone = "";
                    address = "";
                    dobStr = "";
                }
                LocalDate dob = null;
                if (dobStr != null && !dobStr.isEmpty()) {
                    try {
                        // First, try parsing the date in dd/MM/yyyy format
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        dob = LocalDate.parse(dobStr, formatter);
                    } catch (DateTimeParseException e) {
                        try {
                            // If that fails, try parsing the date in yyyy-MM-dd format
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                            dob = LocalDate.parse(dobStr, formatter);
                        } catch (DateTimeParseException ex) {
                            // Handle the parse exception, for example, by setting a default date or logging an error
                            ex.printStackTrace();
                            // Optionally, you can set a default value or handle the error appropriately
                            // dob = LocalDate.now(); // Example of setting current date as default
                        }
                    }
                }

                AccountDTO staff = new AccountDTO();
                staff.setAccountID(accountId);
                staff.setUserName(userName);
                staff.setFullName(fullName);
                staff.setPhone(phone);
                staff.setAddress(address);
                staff.setDob(dob);
                staff.setGender(gender);
                dao.UpdateProfileStaff(staff);
                session.setAttribute("account", staff);
                request.getRequestDispatcher("staffWeb-ProfileStaff.jsp").forward(request, response);
            }
            System.out.println(action);
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
