/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package GoogleVerify;

import Service.ServiceDAO;
import Token.TokenGenerator;
import account.AccountDAO;
import account.AccountDTO;
import booking.BookingDAO;
import booking.BookingDTO;
import clinic.ClinicDAO;
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
import java.text.NumberFormat;
import java.time.LocalDate;
import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.Enumeration;
import java.util.HashMap;
import java.util.Locale;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
import payment.Config;
import payment.PaymentDAO;
import payment.PaymentDTO;
import timeSlot.TimeSlotDAO;

/**
 *
 * @author Admin
 */
@WebServlet(name = "SendEmailBookingServlet", urlPatterns = {"/SendEmailBookingServlet"})
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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");

        HttpSession session = request.getSession();
        AccountDTO account = (AccountDTO) session.getAttribute("account");
        BookingDAO bookingDAO = new BookingDAO();
        LocalDate today = LocalDate.now();
        String bookingID = "BK" + (today.getYear() % 100) + String.format("%02d", today.getMonthValue()) + String.format("%02d", today.getDayOfMonth()) + String.format("%02d", bookingDAO.countBooking() + 1);
        BookingDTO bookingDTO = bookingDAO.getBookingByID(bookingID);

        ClinicDAO clinicDAO = new ClinicDAO();
        ServiceDAO serviceDAO = new ServiceDAO();
        TimeSlotDAO timeSlotDAO = new TimeSlotDAO();

        AccountDAO dao = new AccountDAO();
        if (account == null) {
            request.setAttribute("error", "Your email has not been registered !");
            request.setAttribute("action", "load");
            request.getRequestDispatcher("HistoryServlet").forward(request, response);
            return;
        }
        Map fields = new HashMap();
        for (Enumeration params = request.getParameterNames(); params.hasMoreElements();) {
            String fieldName = URLEncoder.encode((String) params.nextElement(), StandardCharsets.US_ASCII.toString());
            String fieldValue = URLEncoder.encode(request.getParameter(fieldName), StandardCharsets.US_ASCII.toString());
            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                fields.put(fieldName, fieldValue);
            }
        }
        String vnp_TransactionStatus = request.getParameter("vnp_TransactionStatus");

        String vnp_SecureHash = request.getParameter("vnp_SecureHash");
        if (fields.containsKey("vnp_SecureHashType")) {
            fields.remove("vnp_SecureHashType");
        }
        if (fields.containsKey("vnp_SecureHash")) {
            fields.remove("vnp_SecureHash");
        }
        String signValue = Config.hashAllFields(fields);
        String ms = "";
        String final_price = "";

        PaymentDTO payment = new PaymentDTO();
        if (signValue.equals(vnp_SecureHash)) {
            if ("00".equals(vnp_TransactionStatus)) {
                String vnp_TxnRef = request.getParameter("vnp_TxnRef");
                String vnp_OrderInfo = request.getParameter("vnp_OrderInfo");
                String vnp_Amount = request.getParameter("vnp_Amount");
                String vnp_ResponseCode = request.getParameter("vnp_ResponseCode");
                String vnp_TransactionNo = request.getParameter("vnp_TransactionNo");
                String vnp_BankCode = request.getParameter("vnp_BankCode");
                String vnp_PayDate = request.getParameter("vnp_PayDate");

                String orderInfoList[] = vnp_OrderInfo.trim().split(" ");
                String appointmentDay_raw = orderInfoList[0].trim();
                String price = orderInfoList[1].replaceAll("[^\\d]", "").trim();
                int clinicID = Integer.parseInt(orderInfoList[2].trim());
                String serviceID = orderInfoList[3].trim();
                String slotID = orderInfoList[4].trim();

                DateTimeFormatter formatter2 = DateTimeFormatter.ofPattern("yyyy-MM-dd HH:mm:ss");
                LocalDateTime createTime = LocalDateTime.now();
                String now_raw = createTime.format(formatter2).trim();
                String now[] = now_raw.split(" ");

                String clinic = clinicDAO.getClinicByID(clinicID).getClinicName();
                String clinicAddress = clinicDAO.getClinicByID(clinicID).getClinicAddress();

                String service = serviceDAO.getServiceByID(Integer.parseInt(serviceID)).getServiceName();
                String timeSlot = timeSlotDAO.getTimeSLotByID(Integer.parseInt(slotID)).getTimePeriod();

                DateTimeFormatter payFormatter = DateTimeFormatter.ofPattern("yyyyMMddHHmmss");
                LocalDate paydate = LocalDate.parse(vnp_PayDate, payFormatter);

                StringBuilder formatted_price = new StringBuilder(price);
                int length = price.length();
                for (int i = length - 3; i > 0; i -= 3) {
                    formatted_price.insert(i, '.');
                }
                
                int x = Integer.parseInt(vnp_Amount) / 100;
                
                StringBuilder formatted_deposit = new StringBuilder(Integer.toString(x));
                int length1 = Integer.toString(x).length();
                for (int i = length1 - 3; i > 0; i -= 3) {
                    formatted_deposit.insert(i, '.');
                }
                //String payTime = paydate.format(formatter2);

                Locale currentLocale = new Locale("vi", "VN");
                NumberFormat currencyFormatter = NumberFormat.getCurrencyInstance(currentLocale);

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
                        + "            <p>We confirm that you have successfully booked dental service at <strong>" + now[1] + " " + now[0] + ".</strong></p>\n"
                        + "            <p>Your booking details are as follows:</p>\n"
                        + "            <div class=\"section\" >\n"
                        + "                <h2>Booking Details</h2>\n"
                        + "                <p><strong>Booking Code:</strong> " + bookingID + "</p>\n"
                        + "                <p><strong>Customer:</strong> " + account.getFullName() + "</p>\n"
                        + "                <p><strong>Name of service:</strong> " + service + "</p>\n"
                        + "                <p><strong>Address:</strong> " + clinic + " - " + clinicAddress + "</p>\n"
                        + "                <p><strong>Appointment Time:</strong> " + timeSlot + " on " + appointmentDay_raw + "</p>\n"
                        + "                <p><strong>Service Price:</strong> " + formatted_price + " VND" + "</p>\n"
                        + "            </div>\n"
                        + "            <div class=\"section\" >\n"
                        + "                <h2>Transaction Detail</h2>\n"
                        + "                <p><strong>Transaction ID:</strong> " + vnp_TxnRef + "</p>\n"
                        + "                <p><strong>Deposit:</strong> " + formatted_deposit + " VND" + "</p>\n"
                        + "                <p><strong>Transaction No at VNPAY-QR GATEWAY:</strong> " + vnp_TransactionNo + "</p>\n"
                        + "                <p><strong>Payment Time:</strong> " + paydate + "</p>\n"
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
                DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                System.out.println(appointmentDay_raw);
                LocalDate appointmentDay = LocalDate.parse(appointmentDay_raw, formatter);

                bookingDAO.createBooking(bookingID, LocalDate.now(), appointmentDay, Float.parseFloat(price), Float.parseFloat(vnp_Amount) / 100, Integer.parseInt(serviceID), Integer.parseInt(slotID), account.getAccountID(), null, clinicID);

                PaymentDAO paymentDAO = new PaymentDAO();
                paymentDAO.createPayment(vnp_TxnRef, Float.parseFloat(vnp_Amount) / 100, vnp_OrderInfo, Integer.parseInt(vnp_ResponseCode), vnp_TransactionNo, vnp_BankCode, paydate, bookingID);

                request.setAttribute("message", "Booking successfull. Please check your email!");
            }
            request.setAttribute("action", "load");
            request.getRequestDispatcher("HistoryServlet").forward(request, response);
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
            Logger.getLogger(SendEmailBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
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
            Logger.getLogger(SendEmailBookingServlet.class.getName()).log(Level.SEVERE, null, ex);
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
