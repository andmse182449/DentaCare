package controller;

import account.AccountDTO;
import account.StaffAccountDAO;
import booking.BookingDAO;
import booking.BookingDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "StaffViewBooking", urlPatterns = {"/StaffViewBooking"})
public class StaffViewBooking extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException, ParseException {
        response.setContentType("text/html;charset=UTF-8");

        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            BookingDAO daoBooking = new BookingDAO();
            HttpSession session = request.getSession();
            AccountDTO staff = (AccountDTO) session.getAttribute("account");
            StaffAccountDAO daoStaffAccount = new StaffAccountDAO();
            String dentistID = null;
            String openBookingDetail = null;
            String selectedDate = request.getParameter("bookingDate");
            String customerName = request.getParameter("nameBooking");
            if ("assignDentist".equals(action)) {
                String bookingIDStr = request.getParameter("bookingID");
                dentistID = request.getParameter("dentistID");
                openBookingDetail = request.getParameter("openBookingDetail");
                
                daoBooking.assignDentist(bookingIDStr, dentistID);  
                request.setAttribute("bookingID", bookingIDStr);
            }
            if(customerName == null || customerName.isEmpty()){
                customerName = "";
            }
            
            List<BookingDTO> listBooking = daoBooking.getAllBookingClinic(staff.getClinicID(),customerName);
            request.setAttribute("listBookingStaff", listBooking);

            if (selectedDate != null && !selectedDate.isEmpty()) {
                SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
                Date now = dateFormat.parse(selectedDate);
                java.sql.Date sqlDate = new java.sql.Date(now.getTime());
                List<AccountDTO> listNameDentist = daoStaffAccount.listNameDentist1(now);
                request.setAttribute("listNameDentist1", listNameDentist);
            }
            request.setAttribute("selectedDate", selectedDate);
            request.setAttribute("openBookingDetail", openBookingDetail);

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
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (ParseException ex) {
            Logger.getLogger(StaffViewBooking.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
