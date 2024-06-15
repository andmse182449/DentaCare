package controller;

import Service.ServiceDAO;
import account.AccountDAO;
import clinic.ClinicDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ROG STRIX
 */
@WebServlet(name = "LoadDataServlet", urlPatterns = {"/LoadDataServlet"})
public class LoadDataServlet extends HttpServlet {

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
        String url = "index.jsp";
        AccountDAO accountDAO = new AccountDAO();
        ClinicDAO clinicDAO = new ClinicDAO();
        ServiceDAO serviceDAO = new ServiceDAO();
        try {
                request.setAttribute("CLINIC", clinicDAO.getAllClinic());
                request.setAttribute("SERVICE", serviceDAO.listAllServiceActive());
                request.setAttribute("DENTIST", accountDAO.getAllDentists());
    
        } catch (SQLException ex) {
            Logger.getLogger(LoadDataServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        request.getRequestDispatcher(url).forward(request, response);
    }


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
