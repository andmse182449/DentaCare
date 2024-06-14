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
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.sql.Date;
import java.time.LocalDateTime;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import timeSlot.TimeSlotDAO;
import timeSlot.TimeSlotDTO;

/**
 *
 * @author Admin
 */
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

        if (action == null || action == "" || action.equals("book")) {
            try {
                List<ClinicDTO> listClinic = clinicDAO.getAllClinic();
                List<ServiceDTO> listService = serviceDAO.listAllServiceActive();
                List<TimeSlotDTO> listTimeSlot = timeslotDAO.getAllTimeSLot();
                List<AccountDTO> listDoctor = accountDAO.getAllDentists();
                List<DentistScheduleDTO> listDenSchedule = dentistScheduleDAO.getAccountDentistByRoleID1();
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
        } else if (action.equals("create")) {
            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
            DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
            LocalDate today = LocalDate.now();
            String bookingID = "BK" + (today.getYear() % 100) + String.format("%02d", today.getMonthValue()) + String.format("%02d", today.getDayOfMonth()) + String.format("%02d", bookingDAO.countBooking() + 1);

            LocalDate createDay = today;
            LocalDateTime createTime = LocalDateTime.now();
            String appointmentDay_raw = request.getParameter("date");
            LocalDate appointmentDay = LocalDate.parse(appointmentDay_raw, formatter);
            Date sqlDate = Date.valueOf(appointmentDay);
            float price = Float.parseFloat(request.getParameter("price"));
            int serviceID = Integer.parseInt(request.getParameter("serviceID"));
            int slotID = Integer.parseInt(request.getParameter("slotID"));
            String customerID = request.getParameter("accountID");
            String dentistID = request.getParameter("dentistID");
            int clinicID = Integer.parseInt(request.getParameter("clinicID"));
            String email = request.getParameter("email");
            String clinic_address = request.getParameter("clinic-address");
            String clinic = request.getParameter("clinic");
            String service = request.getParameter("service");
            String timeslot = request.getParameter("timeslot");
            String doctor = request.getParameter("doctor");
            String url = "";

            try {
                List<Integer> listClinicLimit = bookingDAO.getClinicIDLimitBooking();
                List<Integer> listSlotLimit = bookingDAO.getSlotIDLimitBooking();
                List<Date> listDayLimit = bookingDAO.getDayLimitBooking();
                List<BookingDTO> list = bookingDAO.getAllBookingList();
                System.out.println(list);
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
                } else {
                    if (bookingDAO.createBooking(bookingID, createDay, appointmentDay, price, serviceID, slotID, customerID, dentistID, clinicID)) {
                        String now_raw = createTime.format(formatter2);
                        request.setAttribute("createTime", now_raw);
                        request.setAttribute("bookingID", bookingID);
                        request.setAttribute("mail", email);
                        request.setAttribute("clinicAddress", clinic_address);
                        request.setAttribute("clinic", clinic);
                        request.setAttribute("timeslot", timeslot);
                        request.setAttribute("service", service);
                        request.setAttribute("doctor", doctor);
                        url = "SendEmailBookingServlet";
                    }
                }
            } catch (SQLException ex) {
                Logger.getLogger(BookingServlet.class.getName()).log(Level.SEVERE, null, ex);
            }
            //request.setAttribute("action", "book");
            request.getRequestDispatcher(url).forward(request, response);
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
