package GoogleLogin;

import account.AccountDAO;
import account.AccountDTO;
import java.io.IOException;
import java.sql.SQLException;
import jakarta.servlet.RequestDispatcher;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.time.Year;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "GoogleLoginServlet", urlPatterns = {"/GoogleLoginServlet"})
public class GoogleLoginServlet extends HttpServlet {

    public GoogleLoginServlet() {
        super();
    }

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String code = request.getParameter("code");

        String url = "userWeb-page.jsp";
        try {
            HttpSession session = request.getSession();

            if (code == null || code.isEmpty()) {
                RequestDispatcher dis = request.getRequestDispatcher("loginGoogle.jsp");
                dis.forward(request, response);
            } else {
                String accessToken = GoogleUtils.getToken(code);
                GoogleDTO googlePojo = GoogleUtils.getUserInfo(accessToken);

                AccountDAO accountDAO = new AccountDAO();
                int numOfUsers = accountDAO.countAccount();
                String accountId = "CUS" + Year.now().getValue() + String.format("%03d", numOfUsers + 1);
                accountDAO.createAccountGG(googlePojo.getId(), googlePojo.getEmail(),accountId);
                AccountDTO checkAccountGG1 = accountDAO.checkAccountGG(googlePojo.getEmail());
                session.setAttribute("account", checkAccountGG1);
                request.getRequestDispatcher(url).forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(GoogleLoginServlet.class.getName()).log(Level.SEVERE, null, ex);
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