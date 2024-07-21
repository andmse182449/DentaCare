
/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import clinic.ClinicDAO;
import clinic.ClinicDTO;
import dayOffSchedule.DayOffScheduleDAO;
import dayOffSchedule.DayOffScheduleDTO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import timeSlot.TimeSlotDAO;
import timeSlot.TimeSlotDTO;

/**
 *
 * @author Admin
 */
public class LoadFromClinicToScheduleServlet extends HttpServlet {

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
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            String key = request.getParameter("key");

            String id_raw = request.getParameter("clinicByID");
            String yearStr = request.getParameter("year");
            String weekStr = request.getParameter("week");

            String description = request.getParameter("description");
            String offDate = request.getParameter("offDate");

            String timePeriod = request.getParameter("timePeriod");
            String timePeriod1 = request.getParameter("timePeriod1");
            String timePeriod2 = request.getParameter("timePeriod2");

            String oldTimePeriod = request.getParameter("oldTimePeriod");

            DayOffScheduleDAO offDao = new DayOffScheduleDAO();

            String url = "";
            int id = 0;
            System.out.println(yearStr);
            System.out.println(weekStr);
            try {
                id = Integer.parseInt(id_raw);
                if (("loadClinicSchedule").equals(action)) {
                    ClinicDAO dao = new ClinicDAO();

                    ClinicDTO clinicByID = dao.getClinicByID(id);
                    if (clinicByID == null) {
                        System.out.println("Clinic with ID " + id + " not found!");
                        request.setAttribute("error", "Clinic not found!");
                        request.getRequestDispatcher("errorPage.jsp").forward(request, response);
                        return;
                    }

                    List<DayOffScheduleDTO> off = offDao.getAllOffDate(id);

                    // Time Slot
                    TimeSlotDAO timeDao = new TimeSlotDAO();
                    List<TimeSlotDTO> getAllTimeSlot = timeDao.getAllTimeSLot();

                    // Send month and year to clinicSchedule.jsp
                    request.setAttribute("yearStr", yearStr);
                    request.setAttribute("weekStr", weekStr);

                    request.setAttribute("off", off);
                    request.setAttribute("clinicID", id);
                    request.setAttribute("clinicByID", clinicByID);
                    request.setAttribute("getAllTimeSlot", getAllTimeSlot);
                    if ("setEvent".equals(key)) {
                        boolean addNewOffDate = offDao.addNewOffDate(offDate, description, id);
                        response.setContentType("application/json");
                        response.setStatus(HttpServletResponse.SC_OK);
                        out.print("{\"success\": true, \"message\": \"Create event successfully !\"}");
                        out.flush();
//                        request.setAttribute("addNewOffDate", addNewOffDate);
                    }
                    if ("modifyEvent".equals(key)) {
                        offDao.modifyEvent(offDate, description, id);
                        response.setContentType("application/json");
                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                        out.print("{\"success\": false, \"message\": \"Modify event successfully !\"}");
                        out.flush();
//                        request.setAttribute("modifyEvent", modifyEvent);
                    } // chua hoan thien
                    if ("timeSlot".equals(key)) {
                        if (timePeriod1 != null && timePeriod2 != null) {
                            //                            String[] timeSplit = timePeriod.split("-");
                            //
                            //                            String time1 = timeSplit[0].trim();
                            //                            String time2 = timeSplit[1].trim();
                            //
                            //                            String[] splitHandM1 = time1.split(":");
                            //                            String[] splitHandM2 = time2.split(":");
                            //
                            //                            String hour1 = splitHandM1[0].trim();
                            //                            String minute1 = splitHandM1[1].trim();
                            //
                            //                            String hour2 = splitHandM2[0].trim();
                            //                            String minute2 = splitHandM2[1].trim();
                            //
                            //                            int h1 = Integer.parseInt(hour1);
                            //                            int h2 = Integer.parseInt(hour2);
                            //                            int m1 = Integer.parseInt(minute1);
                            //                            int m2 = Integer.parseInt(minute2);

                            String[] timeSplit1 = timePeriod1.split(":");
                            String hour1 = timeSplit1[0].trim();
                            String minute1 = timeSplit1[1].trim();

                            String[] timeSplit2 = timePeriod2.split(":");
                            String hour2 = timeSplit2[0].trim();
                            String minute2 = timeSplit2[1].trim();

                            int h1 = Integer.parseInt(hour1);
                            int h2 = Integer.parseInt(hour2);
                            int m1 = Integer.parseInt(minute1);
                            int m2 = Integer.parseInt(minute2);

                            if (h2 < h1) {
                                response.setContentType("application/json");
                                response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                                out.print("{\"success\": false, \"message\": \"The starting time can not greater  than the ending time !\"}");
                                out.flush();
                            } else if (h1 == h2) {
                                if (m2 < m1) {
                                    response.setContentType("application/json");
                                    response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                                    out.print("{\"success\": false, \"message\": \"The starting time can not greater than the ending time !\"}");
                                    out.flush();
                                }
                            } else {
                                List<TimeSlotDTO> listTime = timeDao.getAllTimeSLot();
                                boolean isModified = false;

                                for (TimeSlotDTO timeSlotDTO : listTime) {
                                    if (timeSlotDTO.getTimePeriod().contains(timePeriod1) || timeSlotDTO.getTimePeriod().contains(timePeriod2)) {
                                        response.setContentType("application/json");
                                        response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
                                        out.print("{\"success\": false, \"message\": \"This time slot is already exist !\"}");
                                        out.flush();
                                        return; // Exit the loop and method if the time period is already present
                                    }
                                }

                                if (!isModified) {
                                    boolean modifyTime = timeDao.modifyTime(timePeriod1 + "-" + timePeriod2, oldTimePeriod);
                                    response.setContentType("application/json");
                                    response.setStatus(HttpServletResponse.SC_OK);
                                    out.print("{\"success\": true, \"message\": \"Modify event successfully !\"}");
                                    out.flush();
                                }
                            }
                        }
                    }
                }
//coWeb-clinic
                request.getRequestDispatcher("coWeb-clinic.jsp").forward(request, response);
            } catch (NumberFormatException e) {
                System.out.println("Parse error");
                e.printStackTrace();
            } catch (SQLException ex) {
                Logger.getLogger(LoadFromClinicToScheduleServlet.class.getName()).log(Level.SEVERE, null, ex);
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
