/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package GoogleVerify;

import Token.TokenGenerator;
import account.AccountDAO;
import account.AccountDTO;
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
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author ADMIN
 */
@WebServlet(name = "SendBookingNotificationServlet", urlPatterns = {"/SendBookingNotificationServlet"})
public class SendEmailInvoiceServlet extends HttpServlet {

    private static final long TOKEN_EXPIRATION_TIME = 60000;
    final String subject = "[DentaCare] INVOICE BOOKING";

    private String formatMoney(double amount) {
        return String.format("%,d VND", (long) amount);
    }

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
        try (PrintWriter out = response.getWriter()) {
            //Get parameter từ jsp
            HttpSession session = request.getSession();
            AccountDTO staff = (AccountDTO) session.getAttribute("account");
            String bookingID = request.getParameter("bookingInvoiceID");
            String customerID = request.getParameter("customerID");

            //Khao báo DAO
            InvoiceDAO invoiceDao = new InvoiceDAO();
            AccountDAO accountDao = new AccountDAO();
            BookingDAO bookingDao = new BookingDAO();

            //Khai báo DTO
            InvoiceDTO invoice = invoiceDao.getInvoice(bookingID);
            BookingDTO booking = invoiceDao.getBookingClinic(bookingID);
            AccountDTO customer = accountDao.searchAccountByID(customerID);
            ClinicDTO clinic = invoiceDao.getClinic(staff.getClinicID());

            double total = booking.getPrice() - booking.getDeposit();
            try {
                if (invoice.getInvoiceStatus() == 1) {
                    request.setAttribute("icon", "fa fa-exclamation-triangle");
                    request.setAttribute("css", "border: 1px solid red;\n"
                            + "                background-color: #f8d7da;");
                    request.setAttribute("error", "This invoice has already been sent to the customer.");
                    request.setAttribute("invoice", invoice);
                    request.setAttribute("bookingInvoice", booking);
                    request.setAttribute("clinic", clinic);
                    request.setAttribute("customer", customer);
                    request.getRequestDispatcher("staffWeb-viewInvoice.jsp").forward(request, response);
                    return;
                }
                String token = TokenGenerator.generateToken(TOKEN_EXPIRATION_TIME);
                //set status của invoice từ 0 sang 1 (Complete)
                invoiceDao.setStatusInvoice(invoice.getInvoiceID());
                //set status của booking từ 1 sang 2 (Complete)
                bookingDao.updateStatusBookingComplete(bookingID, 2);
                String body = "<html>\n"
                        + "    <head>\n"
                        + "        <meta http-equiv=\"Content-Type\" content=\"text/html; charset=UTF-8\">\n"
                        + "        <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                        + "        <link rel=\"stylesheet\" href=\"https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css\"\n"
                        + "              integrity=\"sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==\"\n"
                        + "              crossorigin=\"anonymous\" referrerpolicy=\"no-referrer\" />\n"
                        + "        <style>\n"
                        + "            body {\n"
                        + "                font-family: Arial, sans-serif;\n"
                        + "                margin: 0;\n"
                        + "                padding: 0;\n"
                        + "                display: flex;\n"
                        + "                justify-content: center;\n"
                        + "                align-items: center;\n"
                        + "                background-color: #f4f4f4;\n"
                        + "            }\n"
                        + "            .invoice {\n"
                        + "                width: 80%;\n"
                        + "                max-width: 900px;\n"
                        + "                background: #fff;\n"
                        + "                padding: 20px;\n"
                        + "                box-shadow: 0 0 10px rgba(0,0,0,0.1);\n"
                        + "                box-sizing: border-box;\n"
                        + "            }\n"
                        + "            .header {\n"
                        + "                display: flex;\n"
                        + "                justify-content: center;\n"
                        + "                align-items: center;\n"
                        + "                gap: 20px;\n"
                        + "                margin-bottom: 30px;\n"
                        + "            }\n"
                        + "            .header i {\n"
                        + "                font-size: 50px;\n"
                        + "            }\n"
                        + "            .header h1 {\n"
                        + "                font-size: 24px;\n"
                        + "                text-align: center;\n"
                        + "            }\n"
                        + "            .bill-info {\n"
                        + "                display: flex;\n"
                        + "                justify-content: space-between;\n"
                        + "                flex-wrap: wrap;\n"
                        + "                margin-bottom: 20px;\n"
                        + "            }\n"
                        + "            .bill-from, .bill-to, .invoice-details {\n"
                        + "                width: 100%;\n"
                        + "                max-width: 300px;\n"
                        + "                margin-bottom: 20px;\n"
                        + "            }\n"
                        + "            .bill-from h2, .bill-to h2 {\n"
                        + "                margin-bottom: 10px;\n"
                        + "                border-bottom: 1px solid #000;\n"
                        + "                display: inline-block;\n"
                        + "            }\n"
                        + "            table {\n"
                        + "                width: 100%;\n"
                        + "                border-collapse: collapse;\n"
                        + "                margin-bottom: 20px;\n"
                        + "            }\n"
                        + "            table th, table td {\n"
                        + "                border: 1px solid #ddd;\n"
                        + "                padding: 10px;\n"
                        + "                text-align: left;\n"
                        + "            }\n"
                        + "            table th {\n"
                        + "                background-color: #2d87f0;\n"
                        + "                color: #fff;\n"
                        + "            }\n"
                        + "            .totals {\n"
                        + "                text-align: right;\n"
                        + "                margin-bottom: 20px;\n"
                        + "            }\n"
                        + "            .totals p {\n"
                        + "                margin: 5px 0;\n"
                        + "            }\n"
                        + "            .terms {\n"
                        + "                text-align: center;\n"
                        + "                margin-top: 20px;\n"
                        + "            }\n"
                        + "            .terms p {\n"
                        + "                border-top: 1px solid #000;\n"
                        + "                display: inline-block;\n"
                        + "                padding-top: 10px;\n"
                        + "            }\n"
                        + "            .export {\n"
                        + "                padding: 10px 20px;\n"
                        + "                font-size: 1em;\n"
                        + "                cursor: pointer;\n"
                        + "                background-color: #007bff;\n"
                        + "                color: #fff;\n"
                        + "                border: none;\n"
                        + "                border-radius: 5px;\n"
                        + "                transition: background-color 0.3s ease;\n"
                        + "            }\n"
                        + "            .export:hover {\n"
                        + "                background-color: #333;\n"
                        + "            }\n"
                        + ".money-format::before {\n"
                        + "    content: '₫';\n"
                        + "}\n"
                        + "\n"
                        + ".money-format {\n"
                        + "    font-family: 'Courier New', Courier, monospace;\n"
                        + "    text-align: right;\n"
                        + "}\n"
                        + "\n"
                        + ".money-format::after {\n"
                        + "    content: ' VND';\n"
                        + "}"
                        + "            @media (max-width: 600px) {\n"
                        + "                .invoice {\n"
                        + "                    width: 100%;\n"
                        + "                    padding: 10px;\n"
                        + "                }\n"
                        + "                .header i {\n"
                        + "                    font-size: 40px;\n"
                        + "                }\n"
                        + "                .header h1 {\n"
                        + "                    font-size: 20px;\n"
                        + "                }\n"
                        + "                .bill-from, .bill-to, .invoice-details {\n"
                        + "                    max-width: 100%;\n"
                        + "                    text-align: center;\n"
                        + "                }\n"
                        + "                .totals {\n"
                        + "                    text-align: center;\n"
                        + "                }\n"
                        + "            }\n"
                        + "        </style>\n"
                        + "    </head>\n"
                        + "    <body>\n"
                        + "        <div class=\"invoice\">\n"
                        + "            <div class=\"header\">\n"
                        + "                <i class=\"fa-solid fa-tooth\"></i>\n"
                        + "                <h1>DENTAL INVOICE</h1>\n"
                        + "            </div>\n"
                        + "            <div class=\"bill-info\">\n"
                        + "                <div class=\"bill-from\">\n"
                        + "                    <h2>Bill From</h2>\n"
                        + "                    <p>Name: " + booking.getFullNameDentist() + "</p>\n"
                        + "                    <p>Clinic Name: " + clinic.getClinicName() + "</p>\n"
                        + "                    <p>Street Address: " + clinic.getClinicAddress() + "</p>\n"
                        + "                    <p>City, ST ZIP Code: " + clinic.getCity() + "</p>\n"
                        + "                    <p>Phone: " + clinic.getHotline() + "</p>\n"
                        + "                </div>\n"
                        + "                <div class=\"bill-to\">\n"
                        + "                    <h2>Bill To</h2>\n"
                        + "                    <p>Name: " + customer.getFullName() + "</p>\n"
                        + "                    <p>Street Address: " + customer.getAddress() + "</p>\n"
                        + "                    <p>Phone: " + customer.getPhone() + "</p>\n"
                        + "                </div>\n"
                        + "                <div class=\"invoice-details\">\n"
                        + "                    <p>Invoice No. " + invoice.getInvoiceID() + "</p>\n"
                        + "                    <p>Invoice Date: " + invoice.getInvoiceDate() + "</p>\n"
                        + "                    <p>Booking ID: " + booking.getBookingID() + "</p>\n"
                        + "                </div>\n"
                        + "            </div>\n"
                        + "            <table>\n"
                        + "                <thead>\n"
                        + "                    <tr>\n"
                        + "                        <th>Description</th>\n"
                        + "                        <th>Appointment Time/Date</th>\n"
                        + "                        <th>Price (VND)</th>\n"
                        + "                    </tr>\n"
                        + "                </thead>\n"
                        + "                <tbody>\n"
                        + "                    <tr>\n"
                        + "                        <td>" + booking.getService().getServiceName() + "</td>\n"
                        + "                        <td>" + booking.getAppointmentDay() + " " + booking.getTimeSlot().getTimePeriod() + "</td>\n"
                        + "                        <td>" + formatMoney(booking.getPrice()) + "</td>\n"
                        + "                    </tr>\n"
                        + "                </tbody>\n"
                        + "            </table>\n"
                        + "            <div class=\"totals\">\n"
                        + "                <p style=\"text-align: right;\">Subtotal: " + formatMoney(booking.getPrice()) + "</p>\n"
                        + "                <p style=\"text-align: right;\">Deposit: " + formatMoney(booking.getDeposit()) + "</p>\n"
                        + "                <p style=\"text-align: right;\">Total: " + formatMoney(total) + "</p>\n"
                        + "            </div>\n"
                        + "            <div class=\"terms\">\n"
                        + "                <p>Terms and Conditions</p>\n"
                        + "            </div>\n"
                        + "        </div>\n"
                        + "    </body>\n"
                        + "</html>";

                SendEmail send = new SendEmail(customer.getEmail(), subject, body);
                request.getRequestDispatcher("StaffViewBooking").forward(request, response);
            } catch (Exception e) {
                // Log the error for debugging
                e.printStackTrace();
                // Optionally, forward to an error page
                request.setAttribute("error", "An error occurred while processing your request.");
                request.getRequestDispatcher("error.jsp").forward(request, response);
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
            Logger.getLogger(SendEmailInvoiceServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SendEmailInvoiceServlet.class.getName()).log(Level.SEVERE, null, ex);
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
