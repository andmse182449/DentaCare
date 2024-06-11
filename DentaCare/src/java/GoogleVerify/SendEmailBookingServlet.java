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
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class SendEmailBookingServlet extends HttpServlet {

    private static final long TOKEN_EXPIRATION_TIME = 60000;
    final String subject = "[DentaCare] BOOKING SERVICE INFORMATION";

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
        String bookingID = (String) request.getAttribute("bookingID");
        BookingDAO bookingDAO = new BookingDAO();
        BookingDTO bookingDTO = bookingDAO.getBookingByID(bookingID);

        String mail_raw = (String) request.getAttribute("mail");
        String clinicAddress = (String) request.getAttribute("clinicAddress");
        String clinic = (String) request.getAttribute("clinic");
        String now_raw = (String) request.getAttribute("createTime");
        String service = (String) request.getAttribute("service");
        String timeslot = (String) request.getAttribute("timeslot");
        String doctor = (String) request.getAttribute("doctor");
        String now[] = now_raw.split(" ");

        AccountDAO dao = new AccountDAO();
        AccountDTO account = dao.findAccountByEmail(mail_raw);
        if (account == null) {
            request.setAttribute("error", "Your email has not been registered !");
        } else {
            String token = TokenGenerator.generateToken(TOKEN_EXPIRATION_TIME);
            String body = "<!DOCTYPE html>\n"
                    + "<html lang=\"en\">\n"
                    + "<head>\n"
                    + "    <meta charset=\"UTF-8\">\n"
                    + "    <meta name=\"viewport\" content=\"width=device-width, initial-scale=1.0\">\n"
                    + "    <title>Booking Confirmation</title>\n"
                    + "    <style>\n"
                    + "        body {\n"
                    + "            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;\n"
                    + "            background-color: #f8f8f8;\n"
                    + "            margin: 0;\n"
                    + "            align-items: center;\n"
                    + "            justify-content: center;\n"
                    + "            height: 100vh;\n"
                    + "        }\n"
                    + "        .container {\n"
                    + "            background-color: #fff;\n"
                    + "            border: 2px solid #2f89fc;\n "
                    + "            padding: 40px;\n"
                    + "            border-radius: 10px;\n"
                    + "            margin: auto;\n"
                    + "            box-shadow: 0 6px 12px rgba(0,0,0,0.1);\n"
                    + "            max-width: 630px;\n"
                    + "            width: 100%;\n"
                    + "            display: flex;\n"
                    + "            flex-direction: row;\n"
                    + "            justify-content: space-between;\n"
                    + "        }\n"
                    + "        .details {\n"
                    + "            width: 100%;\n"
                    + "        }\n"
                    + "        h1 span{\n"
                    + "            color: #2f89fc;\n"
                    + "            text-align: left;\n"
                    + "            font-size: 28px;\n"
                    + "            font-weight: 700;\n"
                    + "        }\n"
                    + "        h1 {\n"
                    + "            color: #2f89fc;\n"
                    + "            font-size: 28px;\n"
                    + "            text-align: left;\n"
                    + "            font-weight: 350;\n"
                    + "        }\n"
                    + "        p {\n"
                    + "            line-height: 1.4;\n"
                    + "            margin-bottom: 20px;\n"
                    + "            color: #333;\n"
                    + "        }\n"
                    + "        .details .section {\n"
                    + "            margin-bottom: 20px;\n"
                    + "        }\n"
                    + "        .details .section h2 {\n"
                    + "            font-size: 20px;\n"
                    + "            color: #2f89fc;\n"
                    + "            border-bottom: 1px solid #ddd;\n"
                    + "            padding-bottom: 5px;\n"
                    + "            margin-bottom: 10px;\n"
                    + "        }\n"
                    + "        .details .section {\n"
                    + "            margin: 5px 0;\n"
                    + "        }\n"
                    + "        \n"
                    + "    </style>\n"
                    + "</head>\n"
                    + "<body>\n"
                    + "    <div class=\"container\">\n"
                    + "        <div class=\"details\">\n"
                    + "            <h1>DENTA<span>CARE</span></h1>\n"
                    + "            <div class=\"section\" >\n"
                    + "                <h2></h2>\n"
                    + "            </div>\n"
                    + "            <p>Hello <strong>" + account.getFullName() + "</strong>,</p>\n"
                    + "            <p>Thank you for using our service!</p>\n"
                    + "            <p>We confirm that you have successfully booked dental service at <strong>" + now[1] + " " + now[0] +".</strong></p>\n"
                    + "            <p>Your booking details are as follows:</p>\n"
                    + "            <div class=\"section\" >\n"
                    + "                <h2>Booking Details</h2>\n"
                    + "                <p><strong>Booking code:</strong> " + bookingID + "</p>\n"
                    + "                <p><strong>Customer:</strong> " + account.getFullName() + "</p>\n"
                    + "                <p><strong>Name of service:</strong> " + service + "</p>\n"
                    + "                <p><strong>Address:</strong> " + clinic + " - " + clinicAddress +"</p>\n"
                    + "                <p><strong>Appointment Time:</strong> " + timeslot + " on " + bookingDTO.getAppointmentDay() + "</p>\n"
                    + "                <p><strong>Dentist:</strong> " + doctor + "</p>\n"
                    + "            </div>\n"
                    + "            <div class=\"section\">\n"
                    + "                <h2></h2>\n"
                    + "                <p>Please arrive exactly as scheduled!</p>\n"
                    + "                <p>Thank you,<br>DentaCare Team</p>\n"
                    + "                \n"
                    + "            </div>\n"
                    + "        </div>\n"
                    + "    </div>\n"
                    + "</body>\n"
                    + "</html>";

            SendEmail send = new SendEmail(account.getEmail(), subject, body);
            request.setAttribute("message", "Booking successfull. Please check your email!");
        }
        request.setAttribute("action", "book");
        request.getRequestDispatcher("HistoryServlet").forward(request, response);
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
