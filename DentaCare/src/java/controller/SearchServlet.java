/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Service.ServiceDAO;
import account.AccountDAO;
import account.AccountDTO;
import clinic.ClinicDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ROG STRIX
 */
@WebServlet(name = "SearchServlet", urlPatterns = {"/SearchServlet"})
public class SearchServlet extends HttpServlet {

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
        String searchValue = request.getParameter("searchValue");
        try {
            AccountDAO accountDAO = new AccountDAO();
            ClinicDAO clinicDAO = new ClinicDAO();
//            ServiceDAO serviceDAO = new ServiceDAO();
//            request.setAttribute("CLINIC", clinicDAO.getAllClinic());
            List<AccountDTO> list = accountDAO.searchDentists(searchValue);
            if (list.isEmpty()) {
                request.setAttribute("show", "none");
                request.setAttribute("founded", "block");
                request.setAttribute("searchValue", searchValue);
                request.setAttribute("noRes", "There is no results!");
            } else {
                request.setAttribute("show", "block");
                request.setAttribute("founded", "none");
                request.setAttribute("searchValue", searchValue);
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
                request.setAttribute("numberOfResults", list.size());
                request.setAttribute("dentistList", arr);
            
            }
            request.getRequestDispatcher("doctors.jsp").forward(request, response);
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
