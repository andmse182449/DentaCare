/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDTO;
import booking.BookingDAO;
import booking.BookingDTO;
import feedback.FeedbackDAO;
import feedback.FeedbackDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import medicalRecord.MedicalRecordDAO;
import medicalRecord.MedicalRecordDTO;

/**
 *
 * @author ROG STRIX
 */
public class HistoryServlet extends HttpServlet {

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
        String action = (String) request.getAttribute("action");
        if (action == null) {
            action = request.getParameter("action");
        }
        String url = "userWeb-bookingHistory.jsp";

        HttpSession session = request.getSession();
        AccountDTO account = (AccountDTO) session.getAttribute("account");
        BookingDAO bookingDAO = new BookingDAO();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        MedicalRecordDAO medicalDao = new MedicalRecordDAO();
        
        LocalDate today = LocalDate.now();
        if (action == null || action == "" || action.equals("load")) {
            try {
                List<BookingDTO> bookingList = bookingDAO.getBookingListByCustomerID(account.getAccountID());
                 List<MedicalRecordDTO> recordLists = medicalDao.getAllRecords();
                System.out.println(account.getAccountID() + "and" +bookingList.size());
                List<FeedbackDTO> fbList = feedbackDAO.getAllFeedbacksByUser(account.getAccountID());
                try {
                    for (BookingDTO bookingDTO : bookingList) {
                        if (bookingDTO.getAppointmentDay().isBefore(today) && bookingDTO.getStatus() == 0) {
                            try {
                                bookingDAO.updateExpiredDate(bookingDTO.getBookingID());
                            } catch (SQLException ex) {
                                Logger.getLogger(HistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
                            }
                        }
                    }
                    request.setAttribute("recordList", recordLists);
                    request.setAttribute("bookingList", bookingList);
                    request.setAttribute("feedbackList", fbList);
                    request.getRequestDispatcher(url).forward(request, response);
                } catch (IOException e) {
                    System.out.println(e);
                }
            } catch (SQLException ex) {
                Logger.getLogger(HistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("cancel")) {
            String bookingID = request.getParameter("bookingID");
            try {
                if (bookingDAO.cancelBooking(bookingID)) {
                    request.setAttribute("message", "Cancel Completed");
                    request.setAttribute("action", "load");
                    request.getRequestDispatcher("HistoryServlet").forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(HistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
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
