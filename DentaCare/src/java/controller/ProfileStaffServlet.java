/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDAO;
import account.AccountDTO;
import account.Encoder;
import account.StaffAccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            StaffAccountDAO dao = new StaffAccountDAO();
            AccountDAO accountDao = new AccountDAO();
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
            } else if (action.equals("changePassword")) {
                request.getRequestDispatcher("staffWeb-ChangePassword.jsp").forward(request, response);
            } else if (action.equals("updatePassword")) {
                AccountDTO staff = (AccountDTO) session.getAttribute("account");
                Encoder encoder = new Encoder();
                String oldPassword = request.getParameter("oldPassword");
                String newPassword1 = request.getParameter("newPassword1");
                String newPassword2 = request.getParameter("newPassword2");

                if (oldPassword == null || newPassword1 == null || newPassword2 == null) {
                    String error = "Fill all fields";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("ProfileStaffServlet?action=changePassword").forward(request, response);
                    return; 
                }

                if (!encoder.encode(oldPassword).equals(staff.getPassword())) {
                    String error = "Old password is incorrect";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("ProfileStaffServlet?action=changePassword").forward(request, response);
                    return; 
                }

                if (!newPassword1.equals(newPassword2)) {
                    String error = "New passwords do not match";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("ProfileStaffServlet?action=changePassword").forward(request, response);
                    return; 
                }

                accountDao.changePasswordFirstLogin(newPassword1, staff.getAccountID());
                request.setAttribute("error", "Update Password Successfully");
                request.getRequestDispatcher("ProfileStaffServlet?action=changePassword").forward(request, response);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProfileStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ProfileStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
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
