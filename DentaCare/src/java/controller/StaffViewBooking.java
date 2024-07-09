package controller;

import account.AccountDAO;
import account.AccountDTO;
import account.StaffAccountDAO;
import booking.BookingDAO;
import booking.BookingDTO;
import clinic.ClinicDTO;
import invoice.InvoiceDAO;
import invoice.InvoiceDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.text.ParseException;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "StaffViewBooking", urlPatterns = {"/StaffViewBooking"})
public class StaffViewBooking extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            BookingDAO daoBooking = new BookingDAO();
            HttpSession session = request.getSession();
            AccountDAO accountDao = new AccountDAO();
            AccountDTO staff = (AccountDTO) session.getAttribute("account");
            StaffAccountDAO daoStaffAccount = new StaffAccountDAO();
            String dentistID = null;
            if ("assignDentist".equals(action)) {
                String bookingIDStr = request.getParameter("bookingID");
                dentistID = request.getParameter("dentistID");
                daoBooking.assignDentist(bookingIDStr, dentistID);
                request.setAttribute("bookingID", bookingIDStr);

                Date now = new Date();
                List<AccountDTO> listNameDentist = daoStaffAccount.listNameDentist1(now, staff.getClinicID());
                request.setAttribute("listNameDentist1", listNameDentist);
                //Show list booking ngay hom nay
                java.sql.Date sqlDate = new java.sql.Date(now.getTime());
                List<BookingDTO> listBooking = daoBooking.getAllBookingClinic(staff.getClinicID(), sqlDate);
                //Show list booking ngày mai
                LocalDate today = LocalDate.now();
                LocalDate nextDay = today.plusDays(1);
                Date nextDate = Date.from(nextDay.atStartOfDay(ZoneId.systemDefault()).toInstant());
                java.sql.Date sqlNextDate = new java.sql.Date(nextDate.getTime());
                List<BookingDTO> listBookingNextDate = daoBooking.getAllBookingClinic(staff.getClinicID(), sqlNextDate);
                 //Show revenue
                Double revenue = daoStaffAccount.getRevenue(now);
                //Set Attribute
                request.setAttribute("style", "none");
                request.setAttribute("dailyRevenue", revenue);
                request.setAttribute("listUpcomingBookings", listBookingNextDate);
                request.setAttribute("listBookingStaff", listBooking);
                request.getRequestDispatcher("staffWeb-ViewBooking.jsp").forward(request, response);
                return;
            }
            //Assign bác sĩ cho bookingID được gửi về

            if (action == null) {
                //Show list bác sĩ đi làm ngày hôm đó và sắp xếp number of booking theo chiều tăng dần
                Date now = new Date();
                List<AccountDTO> listNameDentist = daoStaffAccount.listNameDentist1(now, staff.getClinicID());
                request.setAttribute("listNameDentist1", listNameDentist);
                //Show list booking ngay hom nay
                java.sql.Date sqlDate = new java.sql.Date(now.getTime());
                List<BookingDTO> listBooking = daoBooking.getAllBookingClinic(staff.getClinicID(), sqlDate);
                //Show list booking ngày mai
                LocalDate today = LocalDate.now();
                LocalDate nextDay = today.plusDays(1);
                Date nextDate = Date.from(nextDay.atStartOfDay(ZoneId.systemDefault()).toInstant());
                java.sql.Date sqlNextDate = new java.sql.Date(nextDate.getTime());
                List<BookingDTO> listBookingNextDate = daoBooking.getAllBookingClinic(staff.getClinicID(), sqlNextDate);
                //Show revenue
                Double revenue = daoStaffAccount.getRevenue(now);

                //Set Attribute
                request.setAttribute("style", "none");
                request.setAttribute("dailyRevenue", revenue);
                request.setAttribute("listBookingStaff", listBooking);
                request.setAttribute("listUpcomingBookings", listBookingNextDate);
                request.getRequestDispatcher("staffWeb-ViewBooking.jsp").forward(request, response);
                return;
            } else if ("viewInvoice".equals(action)) {
                InvoiceDAO invoiceDAO = new InvoiceDAO();
                String bookingIDStr = request.getParameter("bookingID");
                String customerID = request.getParameter("customerID");
                // Nếu invoice đã được tạo thì view
                if (invoiceDAO.getInvoice(bookingIDStr) != null) {
                    InvoiceDTO invoice = invoiceDAO.getInvoice(bookingIDStr);
                    BookingDTO bookingInvoice = invoiceDAO.getBookingClinic(bookingIDStr);
                    ClinicDTO clinic = invoiceDAO.getClinic(staff.getClinicID());
                    AccountDTO customer = accountDao.searchAccountByID(customerID);
                    request.setAttribute("invoice", invoice);
                    request.setAttribute("bookingInvoice", bookingInvoice);
                    request.setAttribute("clinic", clinic);
                    request.setAttribute("customer", customer);
                    request.getRequestDispatcher("staffWeb-viewInvoice.jsp").forward(request, response);
                    return;
                } //Create new invoice cho booking với invoice date là date now
                else {
                    InvoiceDTO invoice = new InvoiceDTO();
                    LocalDate nowInvoice = LocalDate.now();
                    Date invoiceDate = Date.from(nowInvoice.atStartOfDay(ZoneId.systemDefault()).toInstant());
                    invoice.setInvoiceID(invoiceDAO.generateInvoiceID());
                    invoice.setInvoiceStatus(0);
                    invoice.setInvoiceDate(new java.sql.Date(invoiceDate.getTime()));
                    invoiceDAO.createInvoice(invoice, bookingIDStr);
                    BookingDTO bookingInvoice = invoiceDAO.getBookingClinic(bookingIDStr);
                    ClinicDTO clinic = invoiceDAO.getClinic(staff.getClinicID());
                    AccountDTO customer = accountDao.searchAccountByID(customerID);
                    request.setAttribute("invoice", invoice);
                    request.setAttribute("bookingInvoice", bookingInvoice);
                    request.setAttribute("clinic", clinic);
                    request.setAttribute("customer", customer);
                    request.getRequestDispatcher("staffWeb-viewInvoice.jsp").forward(request, response);
                    return;
                }
            } else if (action.equals("pastBookingList")) {
                LocalDate today = LocalDate.now();
                List<LocalDate> result = daoStaffAccount.getPreviousDaysInCurrentMonth(today);
                Map<LocalDate, List<BookingDTO>> bookingsByDate = new TreeMap<>(Collections.reverseOrder());
                for (LocalDate date : result) {
                    Date nextDate = Date.from(date.atStartOfDay(ZoneId.systemDefault()).toInstant());
                    java.sql.Date sqlDate = new java.sql.Date(nextDate.getTime());
                    List<BookingDTO> pastListBookingEachDate = daoBooking.getAllBookingClinic(staff.getClinicID(), sqlDate);
                    System.out.println("Date: " + sqlDate + ", Number of bookings: " + pastListBookingEachDate.size());
                    if (!pastListBookingEachDate.isEmpty()) {
                        bookingsByDate.put(date, pastListBookingEachDate);
                    }
                }
                request.setAttribute("style", "block");
                request.setAttribute("bookingsByDate", bookingsByDate);

            } else if (action.equals("closePopUp")) {
                //Show list bác sĩ đi làm ngày hôm đó và sắp xếp number of booking theo chiều tăng dần
                Date now = new Date();
                List<AccountDTO> listNameDentist = daoStaffAccount.listNameDentist1(now, staff.getClinicID());
                request.setAttribute("listNameDentist1", listNameDentist);
                //Show list booking ngay hom nay
                java.sql.Date sqlDate = new java.sql.Date(now.getTime());
                List<BookingDTO> listBooking = daoBooking.getAllBookingClinic(staff.getClinicID(), sqlDate);
                //Show list booking ngày mai
                LocalDate today = LocalDate.now();
                LocalDate nextDay = today.plusDays(1);
                Date nextDate = Date.from(nextDay.atStartOfDay(ZoneId.systemDefault()).toInstant());
                java.sql.Date sqlNextDate = new java.sql.Date(nextDate.getTime());
                List<BookingDTO> listBookingNextDate = daoBooking.getAllBookingClinic(staff.getClinicID(), sqlNextDate);
                //Show revenue
                Double revenue = daoStaffAccount.getRevenue(now);
                //Set Attribute
                request.setAttribute("style", "none");
                request.setAttribute("dailyRevenue", revenue);
                request.setAttribute("listBookingStaff", listBooking);
                request.setAttribute("listUpcomingBookings", listBookingNextDate);
                request.getRequestDispatcher("staffWeb-ViewBooking.jsp").forward(request, response);
                return;
            }
            request.getRequestDispatcher("staffWeb-ViewBooking.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(StaffViewBooking.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StaffViewBooking.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(StaffViewBooking.class.getName()).log(Level.SEVERE, null, ex);
        } catch (SQLException ex) {
            Logger.getLogger(StaffViewBooking.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
