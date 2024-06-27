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
import java.text.SimpleDateFormat;
import java.time.LocalDate;
import java.time.ZoneId;
import java.util.Date;
import java.util.List;
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
            String openBookingDetail = null;
            String selectedDate = request.getParameter("bookingDate");
            String customerName = request.getParameter("nameBooking");

            //Assign bác sĩ cho bookingID được gửi về
            if ("assignDentist".equals(action)) {
                String bookingIDStr = request.getParameter("bookingID");
                dentistID = request.getParameter("dentistID");
                openBookingDetail = request.getParameter("openBookingDetail");

                daoBooking.assignDentist(bookingIDStr, dentistID);
                request.setAttribute("bookingID", bookingIDStr);
            } //lấy data invoice và data booking
            if (customerName == null || customerName.isEmpty()) {
                customerName = "";
            }

            List<BookingDTO> listBooking = daoBooking.getAllBookingClinic(staff.getClinicID(), customerName);
            request.setAttribute("listBookingStaff", listBooking);
            
            //Show list bác sĩ đi làm ngày hôm đó và sắp xếp number of booking theo chiều tăng dần
            if (selectedDate != null && !selectedDate.isEmpty()) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date now = dateFormat.parse(selectedDate);
                java.sql.Date sqlDate = new java.sql.Date(now.getTime());
                List<AccountDTO> listNameDentist = daoStaffAccount.listNameDentist1(now, staff.getClinicID());
                request.setAttribute("listNameDentist1", listNameDentist);
            }
            request.setAttribute("selectedDate", selectedDate);
            request.setAttribute("openBookingDetail", openBookingDetail);
            
            if ("viewInvoice".equals(action)) {
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
                }
                //Create new invoice cho booking với invoice date là date now
                else {
                    InvoiceDTO invoice = new InvoiceDTO();
                    LocalDate now = LocalDate.now();
                    Date invoiceDate = Date.from(now.atStartOfDay(ZoneId.systemDefault()).toInstant());
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
