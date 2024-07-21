/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDAO;
import account.AccountDTO;
import clinic.ClinicDAO;
import clinic.ClinicDTO;
import feedback.FeedbackDTO;
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
import major.MajorDAO;
import major.MajorDTO;

/**
 *
 * @author ROG STRIX
 */
@WebServlet(name = "ForDentistInfo", urlPatterns = {"/ForDentistInfo"})
public class ForDentistInfo extends HttpServlet {

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
        String action = request.getParameter("action");
        try (PrintWriter out = response.getWriter()) {
            AccountDAO dao = new AccountDAO();
            ClinicDAO cdao = new ClinicDAO();
            MajorDAO mdao = new MajorDAO();
            List<AccountDTO> res = dao.getAllDentistsByOwner();
            for (int i = 0; i < res.size(); i++) {
                AccountDTO fr = res.get(i);
                for (int j = i + 1; j < res.size(); j++) {
                    AccountDTO re = res.get(j);
                    if (fr.getAccountID().equals(re.getAccountID())) {
                        String m1 = fr.getMajorName();
                        m1 += ", " + re.getMajorName();
                        fr.setMajorName(m1);
                        res.remove(j);
                        j--;
                    }
                }
            }
            List<MajorDTO> majors = mdao.getAllMajors();
            List<ClinicDTO> clinics = cdao.getAllClinic();
            request.setAttribute("DENTIST", res);
            request.setAttribute("MAJOR", majors);
            request.setAttribute("CLINIC", clinics);
//            int numPs = res.size();
//            int numperPage = 10;
//            int numpage = numPs / numperPage + (numPs % numperPage == 0 ? 0 : 1);
//            int start, end;
//            String tpage = request.getParameter("page");
//            int page;
//            try {
//                page = Integer.parseInt(tpage);
//            } catch (NumberFormatException e) {
//                page = 1;
//            }
//            start = (page - 1) * numperPage;
//            if (page * numperPage > numPs) {
//                end = numPs;
//            } else {
//                end = page * numperPage;
//            }
//            List<AccountDTO> arr = dao.getListByPage((ArrayList<AccountDTO>) res, start, end);
//
//            request.setAttribute("num", numpage);
//            request.setAttribute("page", page);
//            request.setAttribute("DENTIST", arr);
            if (action.equalsIgnoreCase("forward")) {
                request.getRequestDispatcher("coWeb-dentist.jsp").forward(request, response);
            } else if (action.equalsIgnoreCase("edit")) {
                request.setAttribute("defaultDentistId", request.getParameter("denID"));
                 request.getRequestDispatcher("coWeb-dentist.jsp").forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(ForDentistInfo.class.getName()).log(Level.SEVERE, null, ex);
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
