/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDAO;
import account.AccountDTO;
import booking.BookingDAO;
import booking.BookingDTO;
import dayOffSchedule.DayOffScheduleDAO;
import dayOffSchedule.DayOffScheduleDTO;
import dentistSchedule.DentistScheduleDAO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import medicalRecord.MedicalRecordDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "LoadPatientOfDenServlet", urlPatterns = {"/LoadPatientOfDenServlet"})
public class LoadPatientOfDenServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        String action = (String) request.getAttribute("action");
        String bookingID1 = request.getParameter("bookingID");
        if (action == null) {
            action = request.getParameter("action");
        }
        String url = "denWeb-Patient.jsp";

        HttpSession session = request.getSession();
        AccountDTO account = (AccountDTO) session.getAttribute("account");
        BookingDAO bookingDAO = new BookingDAO();
        AccountDAO accDao = new AccountDAO();
        LocalDate today = LocalDate.now();
        Date dateToday = java.sql.Date.valueOf(today);

        if (action == null || action == "" || action.equals("load")) {
            List<BookingDTO> bookingList = bookingDAO.getBookingListByDenID(account.getAccountID());
            
            List<AccountDTO> getCusInfo = accDao.getCusInfo(account.getAccountID());

            try {
                for (BookingDTO bookingDTO : bookingList) {
                    if (bookingDTO.getAppointmentDay().isBefore(today)) {
                        try {
                            bookingDAO.updateExpiredDate(bookingDTO.getBookingID());
                        } catch (SQLException ex) {
                            Logger.getLogger(HistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
                        }
                    }
                }
                request.setAttribute("getCusInfo", getCusInfo);
                request.setAttribute("bookingList", bookingList);
                request.getRequestDispatcher(url).forward(request, response);
            } catch (IOException e) {
                System.out.println(e);
            }
        } else if (action.equals("addRecord")) {
            DentistScheduleDAO dentDao = new DentistScheduleDAO();
            MedicalRecordDAO meDao = new MedicalRecordDAO();
            DayOffScheduleDAO offDao = new DayOffScheduleDAO();
            List<DayOffScheduleDTO> offList = offDao.getAllOffDate(account.getClinicID());
            int count = meDao.countRecord();
            String bookingID = request.getParameter("bookingID");
            String result = request.getParameter("result");
            String reExanime = request.getParameter("reExanime");
            String medicalRecordID = "MEDIRE" + count;

            if (reExanime == null || reExanime.isEmpty()) {
                request.setAttribute("message", "The date parameter is missing or empty!");
                return;
            }
            try {
                SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
                Date dateStr = formatter.parse(reExanime);
                System.out.println(dateStr);
                boolean isDayOff = false;
                if (dateStr.before(dateToday)) {
                    String message = "Cannot add the day before today !";
                    request.setAttribute("message", message);
                    System.out.println("true");
                    request.setAttribute("action", "load");
                    request.getRequestDispatcher("LoadPatientOfDenServlet").forward(request, response);
                    return;
                }
                if (meDao.checkExist(bookingID) == null) {
                    String oldReExanime = request.getParameter("reExanime0");
                    for (DayOffScheduleDTO dayOffScheduleDTO : offList) {
                        if (dentDao.checkAlreadyDentistInDenSche(account.getAccountID(), reExanime) == null) {
                            if (dentDao.checkAlreadyDentistInDenSche(account.getAccountID(), oldReExanime) == null) {
                                if (dayOffScheduleDTO.getDayOff().equals(reExanime)) {
                                    request.setAttribute("message", "This day is an day off, please choose another day !");
                                    request.getRequestDispatcher("LoadPatientOfDenServlet").forward(request, response);
                                    return;
                                } else {
                                    boolean addNewRecord = meDao.addNewRecord(medicalRecordID, result, bookingID, reExanime);
                                    boolean addDenToSche = dentDao.addDenToSche(account.getAccountID(), reExanime);
                                    request.setAttribute("message", "Add New Record Completed");
                                }
                            } else {
                                if (dayOffScheduleDTO.getDayOff().equals(reExanime)) {
                                    isDayOff = true;
                                } else {
                                    isDayOff = false;
                                }
                            }
                        } else {
                            if (dayOffScheduleDTO.getDayOff().equals(reExanime)) {
                                isDayOff = true;
                            } else {
                                isDayOff = false;
                            }
                        }
                        request.setAttribute("action", "load");
                    }
                    if (isDayOff) {
                        request.setAttribute("message", "This day is an day off, please choose another day !");
                        request.getRequestDispatcher("LoadPatientOfDenServlet").forward(request, response);
                        return;
                    } else {
                        meDao.modifyEvent(bookingID, result, reExanime);
                        boolean modifyScheduleOfDentist = dentDao.modifyScheduleOfDentist(account.getAccountID(), reExanime, oldReExanime);
                        request.setAttribute("message", "Modify Record Completed");
                    }
                    request.getRequestDispatcher("LoadPatientOfDenServlet").forward(request, response);
                } else {
                    String oldReExanime = request.getParameter("reExanime0");
                    for (DayOffScheduleDTO dayOffScheduleDTO : offList) {
                        if (dentDao.checkAlreadyDentistInDenSche(account.getAccountID(), reExanime) == null) {
                            if (dentDao.checkAlreadyDentistInDenSche(account.getAccountID(), oldReExanime) == null) {
                                if (dayOffScheduleDTO.getDayOff().equals(reExanime)) {
                                    request.setAttribute("message", "This day is an day off, please choose another day !");
                                    request.getRequestDispatcher("LoadPatientOfDenServlet").forward(request, response);
                                    return;
                                } else {
                                    meDao.modifyEvent(bookingID, result, reExanime);
                                    boolean addDenToSche = dentDao.addDenToSche(account.getAccountID(), reExanime);
                                    request.setAttribute("message", "Modify Record Completed");
                                }
                            } else {
                                if (dayOffScheduleDTO.getDayOff().equals(reExanime)) {
                                    isDayOff = true;
                                } else {
                                    isDayOff = false;
                                }
                            }
                        } else {
                            if (dayOffScheduleDTO.getDayOff().equals(reExanime)) {
                                isDayOff = true;
                            } else {
                                isDayOff = false;
                            }
                        }
                        request.setAttribute("action", "load");
                    }
                    if (isDayOff) {
                        request.setAttribute("message", "This day is an day off, please choose another day !");
                        request.getRequestDispatcher("LoadPatientOfDenServlet").forward(request, response);
                        return;
                    } else {
                        meDao.modifyEvent(bookingID, result, reExanime);
                        boolean modifyScheduleOfDentist = dentDao.modifyScheduleOfDentist(account.getAccountID(), reExanime, oldReExanime);
                        request.setAttribute("message", "Modify Record Completed");
                    }
                    request.getRequestDispatcher("LoadPatientOfDenServlet").forward(request, response);
                }
            } catch (SQLException ex) {
                Logger.getLogger(HistoryServlet.class.getName()).log(Level.SEVERE, null, ex);
            } catch (ParseException ex) {
                Logger.getLogger(LoadPatientOfDenServlet.class.getName()).log(Level.SEVERE, null, ex);
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoadPatientOfDenServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(LoadPatientOfDenServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
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
