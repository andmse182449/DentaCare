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
import com.google.gson.Gson;
import com.google.gson.JsonObject;
import dayOffSchedule.DayOffScheduleDAO;
import dayOffSchedule.DayOffScheduleDTO;
import dentistSchedule.DentistScheduleDAO;
import dentistSchedule.DentistScheduleDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.sql.Date;
import java.text.NumberFormat;
import java.text.SimpleDateFormat;
import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.Currency;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Locale;
import java.util.Map;
import java.util.TimeZone;
import java.util.logging.Level;
import java.util.logging.Logger;
import timeSlot.TimeSlotDAO;
import timeSlot.TimeSlotDTO;
import payment.Config;

/**
 *
 * @author Admin
 */
@WebServlet(name = "BookingServlet", urlPatterns = {"/BookingServlet"})
public class BookingServlet extends HttpServlet {

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
        ClinicDAO clinicDAO = new ClinicDAO();
        ServiceDAO serviceDAO = new ServiceDAO();
        TimeSlotDAO timeslotDAO = new TimeSlotDAO();
        AccountDAO accountDAO = new AccountDAO();
        BookingDAO bookingDAO = new BookingDAO();
        DentistScheduleDAO dentistScheduleDAO = new DentistScheduleDAO();
        DayOffScheduleDAO dayOffDAO = new DayOffScheduleDAO();

        HttpSession session = request.getSession();
        AccountDTO a = (AccountDTO) session.getAttribute("account");
        if (a == null) {
            response.sendRedirect("login.jsp");
            return;
        }
        
        if (action == null || action == "" || action.equals("book")) {
            try {
                List<ClinicDTO> listClinic = clinicDAO.getAllClinic();
                List<ServiceDTO> listService = serviceDAO.listAllServiceActive();
                List<TimeSlotDTO> listTimeSlot = timeslotDAO.getAllTimeSLot();
                List<AccountDTO> listDoctor = accountDAO.getAllDentists();
                List<DentistScheduleDTO> listDenSchedule = dentistScheduleDAO.getAccountDentistByRoleID2();
                List<DayOffScheduleDTO> listDayOff = dayOffDAO.getAllOffDate2();

                List<Integer> listClinicLimit = bookingDAO.getClinicIDLimitBooking();
                List<Integer> listSlotLimit = bookingDAO.getSlotIDLimitBooking();
                List<Date> listDayLimit = bookingDAO.getDayLimitBooking();

                request.setAttribute("clinics", listClinic);
                request.setAttribute("services", listService);
                request.setAttribute("timeslots", listTimeSlot);
                request.setAttribute("doctors", listDoctor);
                request.setAttribute("listDenSchedule", listDenSchedule);
                request.setAttribute("listDayOff", listDayOff);

                request.setAttribute("clinicLimit", listClinicLimit);
                request.setAttribute("slotLimit", listSlotLimit);
                request.setAttribute("dayLimit", listDayLimit);

                request.getRequestDispatcher("userWeb-booking.jsp").forward(request, response);
            } catch (SQLException ex) {
                Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
        } else if (action.equals("confirm")) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            
            String appointmentDay_raw = request.getParameter("date");
            LocalDate appointmentDay = LocalDate.parse(appointmentDay_raw, formatter);
            Date sqlDate = Date.valueOf(appointmentDay);

            float price = Float.parseFloat(request.getParameter("price"));
            Locale currentLocale = new Locale("vi", "VN");
            NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(currentLocale);

            // Format the price and display
            String formattedPrice = currencyFormatter.format(price);
            
            int percent = bookingDAO.getDepositPercent();
            System.out.println(percent);
            String formattedDeposit = currencyFormatter.format(price * percent / 100);            
            int serviceID = Integer.parseInt(request.getParameter("serviceID"));
            int slotID = Integer.parseInt(request.getParameter("slotID"));
            String customerID = request.getParameter("accountID");
            int clinicID = Integer.parseInt(request.getParameter("clinicID"));
            String email = request.getParameter("email");
            String clinic_address = request.getParameter("clinic-address");
            String clinic = request.getParameter("clinic");
            String service = request.getParameter("service");
            String timeslot = request.getParameter("timeslot");

            try {
                List<Integer> listClinicLimit = bookingDAO.getClinicIDLimitBooking();
                List<Integer> listSlotLimit = bookingDAO.getSlotIDLimitBooking();
                List<Date> listDayLimit = bookingDAO.getDayLimitBooking();
                List<BookingDTO> list = bookingDAO.getAllBookingList();
                for (BookingDTO booking : list) {
                    if (booking.getCustomerID().equals(customerID) && booking.getSlotID() == slotID && booking.getServiceID() == serviceID && booking.getAppointmentDay().equals(appointmentDay) && booking.getClinicID() == clinicID) {
                        request.setAttribute("error", "You have already booked this service");
                        request.setAttribute("action", "book");
                        request.getRequestDispatcher("BookingServlet").forward(request, response);
                        return;
                    } else if (booking.getCustomerID().equals(customerID) && booking.getSlotID() == slotID && booking.getAppointmentDay().equals(appointmentDay) && booking.getStatus() != 3) {
                        request.setAttribute("error", "You cannot book serveral services in one slot");
                        request.setAttribute("action", "book");
                        request.getRequestDispatcher("BookingServlet").forward(request, response);
                        return;
                    }
                }
                
                if (listClinicLimit.contains(clinicID) && listSlotLimit.contains(slotID) && listDayLimit.contains(sqlDate)) {
                    request.setAttribute("error", "Something Wrong");
                    request.getRequestDispatcher("userWeb-page.jsp").forward(request, response);
                    return;
                } else {
                    
                    request.setAttribute("mail", email);
                    request.setAttribute("clinicAddress", clinic_address);
                    request.setAttribute("clinic", clinic);
                    
                    request.setAttribute("serviceID", serviceID);
                    request.setAttribute("clinicID", clinicID);
                    request.setAttribute("slotID", slotID);
                    
                    request.setAttribute("timeslot", timeslot);
                    request.setAttribute("service", service);
                    request.setAttribute("price", formattedPrice);
                    request.setAttribute("deposit", formattedDeposit);
                    request.setAttribute("appointmentDay", appointmentDay_raw);
                    request.getRequestDispatcher("userWeb-purchase.jsp").forward(request, response);

                }
            } catch (SQLException ex) {
                Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            //request.setAttribute("action", "book");
            //request.getRequestDispatcher(url).forward(request, response);
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