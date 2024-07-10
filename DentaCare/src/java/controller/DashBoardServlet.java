
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDAO;
import booking.BookingDAO;
import booking.BookingDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.text.DecimalFormat;
import java.time.LocalDate;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

/**
 *
 * @author Admin
 */
@WebServlet(name = "DashBoardServlet", urlPatterns = {"/DashBoardServlet"})
public class DashBoardServlet extends HttpServlet {

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
        String action = request.getParameter("action");
        int yearS1 = 0;
        int yearS2 = 0;
        int monthS = 0;

        try (PrintWriter out = response.getWriter()) {
            if (action.equalsIgnoreCase("Table")) {
                String year1 = request.getParameter("year1");
                String year2 = request.getParameter("year2");
                String monthStr = request.getParameter("month");
//                String key = request.getParameter("key");

                yearS1 = Integer.parseInt(year1);
                yearS2 = Integer.parseInt(year2);
                monthS = Integer.parseInt(monthStr);

//                System.out.println(yearS1);
//                System.out.println(yearS2);
//                System.out.println(monthS);
                //
                AccountDAO accDao = new AccountDAO();

                // count
                int countDentist = accDao.countDentist();
                int countStaff = accDao.countStaff();
                int countUserAccount = accDao.countUserAccount();

                // total Price
                BookingDAO bookDao = new BookingDAO();
                List<Map<String, Object>> results = bookDao.getTotalPriceByYearMonth(yearS1);
                List<Map<String, Object>> allPriceInYear = bookDao.getTotalPriceByYear(yearS1);

                // Total Time Slot
                List<Map<String, Object>> timeResults = bookDao.getTotalTimeSlotsByYearMonth(yearS2, monthS);
                System.out.println(timeResults);
                // count female / male
                List<Map<String, Object>> male = accDao.getAgeGroupStatisticsForMale();
                List<Map<String, Object>> female = accDao.getAgeGroupStatisticsForFemale();

                request.setAttribute("year1", year1);
                request.setAttribute("year2", year2);
                request.setAttribute("month", monthStr);
                request.setAttribute("monthStr", monthStr);
                request.setAttribute("countDentist", countDentist);
                request.setAttribute("countStaff", countStaff);
                request.setAttribute("countUserAccount", countUserAccount);
                request.setAttribute("male", male);
                request.setAttribute("female", female);
                request.setAttribute("timeResults", timeResults);
                request.setAttribute("results", results);
                request.setAttribute("allPriceInYear", allPriceInYear);

            } else if (action.equals("dashboardAction")) {
                String year1 = request.getParameter("year1");
                String year2 = request.getParameter("year2");
                String month = request.getParameter("month");
                monthS = Integer.parseInt(month);
                yearS1 = Integer.parseInt(year1);
                yearS2 = Integer.parseInt(year2);
                AccountDAO accDao = new AccountDAO();

                // count
                int countDentist = accDao.countDentist();
                int countStaff = accDao.countStaff();
                int countUserAccount = accDao.countUserAccount();

                // total Price
                BookingDAO bookDao = new BookingDAO();
                List<Map<String, Object>> results = bookDao.getTotalPriceByYearMonth(yearS1);
                List<Map<String, Object>> allPriceInYear = bookDao.getTotalPriceByYear(yearS1);
                // Format the total price
                DecimalFormat df = new DecimalFormat("#");
                String formattedTotalPrice = df.format(allPriceInYear.get(0).get("TotalPrice"));
                StringBuilder formatted_price = new StringBuilder(formattedTotalPrice);
                int length = formattedTotalPrice.length();
                for (int i = length - 3; i > 0; i -= 3) {
                    formatted_price.insert(i, '.');
                }
                // Total Time Slot
                List<Map<String, Object>> timeResults = bookDao.getTotalTimeSlotsByYearMonth(yearS2, monthS);
                System.out.println(timeResults);
                // count female / male
                List<Map<String, Object>> male = accDao.getAgeGroupStatisticsForMale();
                List<Map<String, Object>> female = accDao.getAgeGroupStatisticsForFemale();

//                request.setAttribute("yearStr", yearStr);
//                request.setAttribute("yearStr", yearStr1);
                request.setAttribute("month", month);
                request.setAttribute("year1", year1);
                request.setAttribute("year2", year2);
                request.setAttribute("countDentist", countDentist);
                request.setAttribute("countStaff", countStaff);
                request.setAttribute("countUserAccount", countUserAccount);
                request.setAttribute("male", male);
                request.setAttribute("female", female);
                request.setAttribute("timeResults", timeResults);
                request.setAttribute("results", results);
                request.setAttribute("allPriceInYear", formatted_price);

//                if (("timeSlot").equals(key)) {
//                    String yearStr2 = request.getParameter("year2");
//                    String monthStr2 = request.getParameter("month2");
//                }
            }
            request.getRequestDispatcher("coWeb-dashboard.jsp").forward(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(DashBoardServlet.class.getName()).log(Level.SEVERE, null, ex);
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
