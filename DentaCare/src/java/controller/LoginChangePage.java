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
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

public class LoginChangePage extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String action = request.getParameter("action");
        String url = "";
        try {
            switch (action) {
                case "login" ->
                    response.sendRedirect("login.jsp");
                case "home" -> {
                    AccountDAO accountDAO = new AccountDAO();
                    ClinicDAO clinicDAO = new ClinicDAO();
                    ServiceDAO serviceDAO = new ServiceDAO();
                    request.setAttribute("CLINIC", clinicDAO.getAllClinic());
                    request.setAttribute("SERVICE", serviceDAO.listAllServiceActive());
                    request.setAttribute("DENTIST", accountDAO.getAllDentists());
                    HttpSession session = request.getSession();
                    url = "userWeb-page.jsp";
//                    session.setAttribute("account", session.getAttribute("account"));
                }
                case "service" -> {
                    HttpSession session = request.getSession();
                    ClinicDAO clinicDAO = new ClinicDAO();
                    ServiceDAO serviceDAO = new ServiceDAO();

                    request.setAttribute("CLINIC", clinicDAO.getAllClinic());
                    request.setAttribute("SERVICE", serviceDAO.listAllServiceActive());

                    url = "service.jsp";

                }
                case "doctor" -> {
                    AccountDAO accountDAO = new AccountDAO();
                    ClinicDAO clinicDAO = new ClinicDAO();
                    ServiceDAO serviceDAO = new ServiceDAO();
                    request.setAttribute("CLINIC", clinicDAO.getAllClinic());
                    request.setAttribute("SERVICE", serviceDAO.listAllServiceActive());
                    List<AccountDTO> list = accountDAO.getAllDentists();
                    int numPs = list.size();
                    int numperPage = 4;
                    int numpage = numPs / numperPage + (numPs % numperPage == 0 ? 0 : 1);
                    int start, end;
                    String tpage = request.getParameter("page");
                    int page;
                    try {
                        page = Integer.parseInt(tpage);
                    } catch (NumberFormatException e) {
                        page = 1;
                    }
                    start = (page - 1) * numperPage;
                    if (page * numperPage > numPs) {
                        end = numPs;
                    } else {
                        end = page * numperPage;
                    }
                    List<AccountDTO> arr = accountDAO.getListByPage((ArrayList<AccountDTO>) list, start, end);
                   
                    request.setAttribute("num", numpage);
                    request.setAttribute("page", page);
                    request.setAttribute("dentistList", arr);
                    url = "doctors.jsp";
                }
                default -> {
                    request.setAttribute("ac", " active");
                    url = "login.jsp";
                }
            }
            request.getRequestDispatcher(url).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoginChangePage.class.getName()).log(Level.SEVERE, null, ex);
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
