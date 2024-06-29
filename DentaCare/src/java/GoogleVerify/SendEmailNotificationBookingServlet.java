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
@WebServlet(name = "SendEmailNotificationBookingServlet", urlPatterns = {"/SendEmailNotificationBookingServlet"})
public class SendEmailNotificationBookingServlet extends HttpServlet {

    private static final long TOKEN_EXPIRATION_TIME = 60000;
    final String subject = "[DentaCare] Appointment Reminder";

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
            BookingDTO booking = invoiceDao.getBookingClinic(bookingID);
            AccountDTO customer = accountDao.searchAccountByID(customerID);
            ClinicDTO clinic = invoiceDao.getClinic(staff.getClinicID());

            try {
                String token = TokenGenerator.generateToken(TOKEN_EXPIRATION_TIME);
                if (booking.getStatus() != 0) {
                    request.getRequestDispatcher("StaffViewBooking").forward(request, response);
                    return;
                }
                //set booking status thanh 4
                bookingDao.updateStatusBookingComplete(bookingID, 4);
                String body = "<html>\n"
                        + "<head>\n"
                        + "    <meta charset=\"UTF-8\">\n"
                        + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                        + "    <title>Booking Reminder</title>\n"
                        + "    <style>\n"
                        + "        body {\n"
                        + "            font-family: Arial, sans-serif;\n"
                        + "            background-color: #f6f6f6;\n"
                        + "            margin: 0;\n"
                        + "            padding: 0;\n"
                        + "        }\n"
                        + "        .email-container {\n"
                        + "            width: 100%;\n"
                        + "            max-width: 600px;\n"
                        + "            margin: 0 auto;\n"
                        + "            background-color: #ffffff;\n"
                        + "            border: 1px solid #dddddd;\n"
                        + "            padding: 20px;\n"
                        + "        }\n"
                        + "        .header {\n"
                        + "            background-color: #0073e6;\n"
                        + "            color: #ffffff;\n"
                        + "            padding: 10px;\n"
                        + "            text-align: center;\n"
                        + "        }\n"
                        + "        .content {\n"
                        + "            padding: 20px;\n"
                        + "        }\n"
                        + "        .content p {\n"
                        + "            margin: 0 0 10px;\n"
                        + "        }\n"
                        + "        .footer {\n"
                        + "            padding: 10px;\n"
                        + "            text-align: center;\n"
                        + "            font-size: 12px;\n"
                        + "            color: #888888;\n"
                        + "        }\n"
                        + "        .button {\n"
                        + "            display: inline-block;\n"
                        + "            background-color: #0073e6;\n"
                        + "            color: #ffffff;\n"
                        + "            padding: 10px 20px;\n"
                        + "            text-decoration: none;\n"
                        + "            border-radius: 5px;\n"
                        + "            margin-top: 20px;\n"
                        + "        }\n"
                        + "    </style>\n"
                        + "</head>\n"
                        + "<body>\n"
                        + "    <div class=\"email-container\">\n"
                        + "        <div class=\"header\">\n"
                        + "            <h2>Appointment Reminder</h2>\n"
                        + "        </div>\n"
                        + "        <div class=\"content\">\n"
                        + "            <p>Dear " + customer.getFullName() + ",</p>\n"
                        + "            <p>This is a friendly reminder about your upcoming appointment at DentaCare.</p>\n"
                        + "            <p><strong>Booking ID:</strong> " + booking.getBookingID() + "</p>\n"
                        + "            <p><strong>Service Name:</strong> " + booking.getService().getServiceName() + "</p>\n"
                        + "            <p><strong>Appointment Date:</strong> " + booking.getAppointmentDay() + "</p>\n"
                        + "            <p><strong>Appointment Time:</strong> " + booking.getTimeSlot().getTimePeriod() + "</p>\n"
                        + "            <p><strong>Clinic Addess:</strong> " + clinic.getClinicAddress() + "</p>\n"
                        + "            <p>Please make sure to arrive on time.</p>\n"
                        + "            <p>If you need to reschedule or have any questions, please contact us at " + clinic.getHotline() + ".</p>\n"
                        + "        </div>\n"
                        + "        <div class=\"footer\">\n"
                        + "            <p>Thank you for choosing DentaCare.</p>\n"
                        + "            <p>DentaCare - Your Trusted Dental Care</p>\n"
                        + "        </div>\n"
                        + "    </div>\n"
                        + "</body>\n"
                        + "</html>";

                SendEmail send = new SendEmail(customer.getEmail(), subject, body);
                request.getRequestDispatcher("StaffViewBooking").forward(request, response);
            } catch (IOException e) {
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
            Logger.getLogger(SendEmailNotificationBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SendEmailNotificationBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
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
