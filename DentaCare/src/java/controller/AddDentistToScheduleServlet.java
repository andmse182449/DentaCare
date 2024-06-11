/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDAO;
import account.AccountDTO;
import clinic.ClinicDAO;
import clinic.ClinicDTO;
import clinicSchedule.ClinicScheduleDAO;
import clinicSchedule.ClinicScheduleDTO;
import dentistSchedule.DentistScheduleDAO;
import dentistSchedule.DentistScheduleDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.util.List;

/**
 *
 * @author Admin
 */
@WebServlet(name = "AddDentistToScheduleServlet", urlPatterns = {"/AddDentistToScheduleServlet"})
public class AddDentistToScheduleServlet extends HttpServlet {

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
            String clincScheduleId_raw = request.getParameter("clinicScheduleID");
            String accountID = request.getParameter("accountID");
            String id_raw = request.getParameter("clinicByID");

            int id = 0;
            int clincScheduleID = 0;

            try {
                id = Integer.parseInt(id_raw);
                ClinicDAO cliao = new ClinicDAO();

                ClinicDTO clinicByID = cliao.getClinicByID(id);
                System.out.println(clinicByID);
                if (clinicByID == null) {
                    System.out.println("Clinic with ID " + id + " not found!");
                    request.setAttribute("error", "Clinic not found!");
                    request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                    return;
                }

                clincScheduleID = Integer.parseInt(clincScheduleId_raw);
                //acoutn
                AccountDAO accDao = new AccountDAO();
                List<AccountDTO> denList = accDao.getAccountDentistByRoleID1();   // lay all account Den 

                //clinicSchedule
                ClinicScheduleDAO cliDao = new ClinicScheduleDAO();
                ClinicScheduleDTO getByCliScheID = cliDao.getInfoByClinicScheduleID(clincScheduleID); // nay de lay all Info cua clinicSchedule

                DentistScheduleDAO dao = new DentistScheduleDAO();
                DentistScheduleDTO checkAlreadyDentistInDenSche = dao.checkAlreadyDentistInDenSche(accountID, "1");
                if (checkAlreadyDentistInDenSche != null) {
                    request.setAttribute("alreadyHave", "This dentist is already in this day, please add another dentist !!");
                } else {
                    boolean addDenToSche = dao.addDenToSche(accountID, "1");
                    request.setAttribute("successfully", "Add dentist to the schedule successfully !");
                    request.setAttribute("addDenToSche", addDenToSche);
                }
                request.setAttribute("denList", denList);
                request.setAttribute("clinicByID", clinicByID);
                request.setAttribute("getByCliScheID", getByCliScheID);
                request.getRequestDispatcher("denWeb-addDenToSchedule.jsp").forward(request, response);

            } catch (NumberFormatException e) {
                System.out.println("Invalid input: " + e.getMessage());
            } catch (Exception e) {
                e.printStackTrace();
            }
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
