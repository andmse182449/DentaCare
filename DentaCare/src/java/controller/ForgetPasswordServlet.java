package controller;

import Token.TokenGenerator;
import account.AccountDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

public class ForgetPasswordServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String mail = request.getParameter("key");
        String action = request.getParameter("action");
        try {
            if (action.equalsIgnoreCase("changePage")) {
                String token = request.getParameter("token");
                request.setAttribute("email", mail);
                try {
                    if (TokenGenerator.validateToken(token)) {
                        request.getRequestDispatcher("changePassword.jsp").forward(request, response);
                    } else {
                        request.setAttribute("error", "The token is invalid or has expired.");
                        request.getRequestDispatcher("error.jsp").forward(request, response);
                    }
                } catch (ServletException | IOException e) {
                    request.setAttribute("error", "An error occurred while processing your request.");
                    request.getRequestDispatcher("error.jsp").forward(request, response);
                }
            } else if (action.equalsIgnoreCase("reset")) {
                String password = request.getParameter("register-pass");
                AccountDAO accountDAO = new AccountDAO();
                accountDAO.resetPassword(mail, password);
                request.setAttribute("success", "Password changed successfully!");
                request.getRequestDispatcher("login.jsp").forward(request, response);

            }
        } catch (SQLException ex) {
            Logger.getLogger(ForgetPasswordServlet.class.getName()).log(Level.SEVERE, null, ex);
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
