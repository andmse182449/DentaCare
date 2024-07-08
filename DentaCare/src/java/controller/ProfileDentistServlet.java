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
import jakarta.servlet.http.Part;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "ProfileDentistServlet", urlPatterns = {"/ProfileDentistServlet"})
public class ProfileDentistServlet extends HttpServlet {

    public String getPath() throws UnsupportedEncodingException {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        String pathArr[] = fullPath.split("/build/web/WEB-INF/classes/");
        fullPath = pathArr[0];
        return fullPath;
    }

    private static String removeLeadingSlash(String path) {
        // Check if the path starts with a leading slash and remove it
        if (path.startsWith("/")) {
            return path.substring(1);
        }
        return path;
    }

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
                AccountDTO account = (AccountDTO) session.getAttribute("account");
                request.setAttribute("account", account);
                request.getRequestDispatcher("denWeb-ProfileDentist.jsp").forward(request, response);
            } else if (action.equals("updateProfileDentist")) {
                String accountId = request.getParameter("accountId");
                String userName = request.getParameter("username");
                String fullName = request.getParameter("fullName");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String dobStr = request.getParameter("dob");
                String genderStr = request.getParameter("gender");
                boolean gender = "Male".equals(genderStr);
                String email = request.getParameter("email");
                Part filePart = request.getPart("edit-image");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                String correctedPath = removeLeadingSlash(getPath());

                // If no new file is uploaded, use the existing image
                if (fileName.isEmpty()) {
                    AccountDTO currentAccount = (AccountDTO) session.getAttribute("account");
                    fileName = currentAccount.getImage();
                } else {
                    try {
                        filePart.write(correctedPath + "/web/images/" + fileName);
                    } catch (IOException e) {
                        e.printStackTrace();
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error writing file: " + e.getMessage());
                        return;
                    }
                }

                LocalDate dob = null;
                if (dobStr != null && !dobStr.isEmpty()) {
                    try {
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        dob = LocalDate.parse(dobStr, formatter);
                    } catch (DateTimeParseException e) {
                        try {
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                            dob = LocalDate.parse(dobStr, formatter);
                        } catch (DateTimeParseException ex) {
                            ex.printStackTrace();
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
                staff.setImage(fileName);
                staff.setEmail(email);
                dao.UpdateProfileStaff(staff);

                session.setAttribute("account", staff);
                request.getRequestDispatcher("denWeb-ProfileDentist.jsp").forward(request, response);
            } else if (action.equals("changePassword")) {
                request.getRequestDispatcher("denWeb-ChangePassword.jsp").forward(request, response);
            } else if (action.equals("updatePassword")) {
                AccountDTO staff = (AccountDTO) session.getAttribute("account");
                Encoder encoder = new Encoder();
                String oldPassword = request.getParameter("oldPassword");
                String newPassword1 = request.getParameter("newPassword1");
                String newPassword2 = request.getParameter("newPassword2");

                if (oldPassword == null || newPassword1 == null || newPassword2 == null) {
                    String error = "Fill all fields";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("ProfileDentistServlet?action=changePassword").forward(request, response);
                    return;
                }

                if (!encoder.encode(oldPassword).equals(staff.getPassword())) {
                    String error = "Old password is incorrect";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("ProfileDentistServlet?action=changePassword").forward(request, response);
                    return;
                }

                if (!newPassword1.equals(newPassword2)) {
                    String error = "New passwords do not match";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("ProfileDentistServlet?action=changePassword").forward(request, response);
                    return;
                }

                accountDao.changePasswordFirstLogin(newPassword1, staff.getAccountID());
                request.setAttribute("error", "Update Password Successfully");
                request.getRequestDispatcher("ProfileDentistServlet?action=changePassword").forward(request, response);
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
            Logger.getLogger(ProfileDentistServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(ProfileDentistServlet.class.getName()).log(Level.SEVERE, null, ex);
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
