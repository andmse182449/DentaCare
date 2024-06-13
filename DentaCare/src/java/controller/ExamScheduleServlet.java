/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import Service.ServiceDAO;
import Service.ServiceDTO;
import account.AccountDAO;
import account.AccountDTO;
import booking.BookingDAO;
import booking.BookingDTO;
import clinic.ClinicDAO;
import clinic.ClinicDTO;
import dayOffSchedule.DayOffScheduleDAO;
import dayOffSchedule.DayOffScheduleDTO;
import dentistSchedule.DentistScheduleDAO;
import dentistSchedule.DentistScheduleDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.Date;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import timeSlot.TimeSlotDAO;
import timeSlot.TimeSlotDTO;

/**
 *
 * @author ROG STRIX
 */
@WebServlet(name = "ExamScheduleServlet", urlPatterns = {"/ExamScheduleServlet"})
public class ExamScheduleServlet extends HttpServlet {

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
        String url = "userWeb-examSchedule.jsp";
        ClinicDAO clinicDAO = new ClinicDAO();
        ServiceDAO serviceDAO = new ServiceDAO();
        TimeSlotDAO timeslotDAO = new TimeSlotDAO();
        AccountDAO accountDAO = new AccountDAO();
        BookingDAO bookingDAO = new BookingDAO();
        
        HttpSession session = request.getSession();
        AccountDTO account = (AccountDTO) session.getAttribute("account");
        

        try {
            List<ClinicDTO> listClinic = clinicDAO.getAllClinic();
            List<ServiceDTO> listService = serviceDAO.listAllServiceActive();
            List<TimeSlotDTO> listTimeSlot = timeslotDAO.getAllTimeSLot();
            List<AccountDTO> listDoctor = accountDAO.getAllDentists();
            List<BookingDTO> listBooking = bookingDAO.getBookingListByCustomerIDAndStatus(account.getAccountID());

            
            request.setAttribute("clinics", listClinic);
            request.setAttribute("services", listService);
            request.setAttribute("timeslots", listTimeSlot);
            request.setAttribute("doctors", listDoctor);
            request.setAttribute("listBooking", listBooking);
            
            request.getRequestDispatcher(url).forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
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
