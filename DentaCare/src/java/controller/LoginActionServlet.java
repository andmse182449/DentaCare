package controller;

import Service.ServiceDAO;
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

public class LoginActionServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String userName = request.getParameter("email");
        String password = request.getParameter("password");
        HttpSession session = request.getSession();
        try {
            AccountDAO dao = new AccountDAO();
            // check email
            AccountDTO checkAccount = dao.checkExistAccount(userName, password);
            String checkPass = dao.checkExistPass(userName);
            // check password
            if (checkAccount != null) {
                ClinicDAO clinicDAO = new ClinicDAO();
                ServiceDAO serviceDAO = new ServiceDAO();
                request.setAttribute("CLINIC", clinicDAO.getAllClinic());
                request.setAttribute("SERVICE", serviceDAO.listAllServiceActive());
                request.setAttribute("DENTIST", dao.getAllDentists());
                switch (checkAccount.isRoleID()) {
                    // admin

                    case 3 -> {
                        session.setAttribute("account", checkAccount);
                        response.sendRedirect("coWeb-dashboard.jsp");
                    }
                    // staff
                    case 2 -> {
                        session.setAttribute("account", checkAccount);
                        response.sendRedirect("staffWeb-page.jsp");
                    }
                    // dentist
                    case 1 -> {
                        session.setAttribute("account", checkAccount);
                        response.sendRedirect("dentistWeb-page.jsp");
                    }
                    default -> {
                        session.setAttribute("account", checkAccount);
                        request.getRequestDispatcher("userWeb-page.jsp").forward(request, response);
                    }
                }
            } else {
                if (!checkPass.equals(password)) {
                    request.setAttribute("error", "Password or Username is not correct!");
                }
                request.getRequestDispatcher("login.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            System.out.println("SQL: " + ex);
        }
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the
    // + sign on the left to edit the code.">
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
