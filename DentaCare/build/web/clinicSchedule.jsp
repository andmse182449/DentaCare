<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="clinicSchedule.ClinicScheduleDTO" %>
<%@ page import="java.util.List" %>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Clinic Schedule</title>
        <style>
            body {
                font-family: Arial, sans-serif;
                background-color: #f0f8ff;
                color: #333;
            }
            .form-container {
                margin: 20px;
                padding: 20px;
                background-color: #ffffff;
                border-radius: 8px;
                box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
            }
            table {
                width: 100%;
                border-collapse: collapse;
                margin-top: 20px;
            }
            th, td {
                border: 1px solid #ddd;
                text-align: center;
                padding: 10px;
                font-size: 14px;
            }
            th {
                background-color: #2f89fc;
                color: white;
            }
            .working-day {
                background-color: #99ffff;
                color: #3c763d;
                font-weight: bold;
            }
            select {
                padding: 5px;
                margin: 5px;
                font-size: 14px;
                border: 1px solid #ccc;
                border-radius: 4px;
                background-color: #f9f9f9;
            }
            input[type="button"] {
                padding: 10px 20px;
                margin: 10px 5px;
                font-size: 14px;
                cursor: pointer;
                background-color: #2f89fc;
                color: white;
                border: none;
                border-radius: 4px;
                transition: background-color 0.3s ease;
            }
            input[type="button"]:hover {
                background-color: #2f89fc;
            }
            h1 {
                color: #333;
                font-size: 24px;
            }
            a {
                text-decoration: none;
            }
        </style>
    </head>
    <body>
        <div class="form-container">
            <h1>Clinic Schedule</h1>
            <form method="post" action="LoadFromClinicToScheduleServlet?clinicByID=${clinicByID.clinicID}">
                <table>
                    <tr>
                        <th>
                            YEAR 
                            <select name="year" onchange="this.form.submit()">
                                <option value="">Select Year</option>
                                <% 
                                    int currentYear = Calendar.getInstance().get(Calendar.YEAR);
                                    String selectedYear = request.getParameter("year");
                                    for (int i = currentYear - 5; i <= currentYear + 5; i++) {
                                        String selected = (selectedYear != null && Integer.toString(i).equals(selectedYear)) ? " selected" : "";
                                        out.println("<option value=\"" + i + "\"" + selected + ">" + i + "</option>");
                                    }
                                %>
                            </select> 
                            <br>
                            WEEK
                            <select name="week" onchange="this.form.submit()">
                                <option value="">Select Week</option>
                                <% 
                                    String selectedWeek = request.getParameter("week");
                                    if (selectedYear != null && !selectedYear.isEmpty()) {
                                        int year = Integer.parseInt(selectedYear);
                                        Calendar calendar = new GregorianCalendar();
                                        SimpleDateFormat sdf = new SimpleDateFormat("dd/MM");
                                
                                        for (int i = 1; i <= 52; i++) {
                                            calendar.set(Calendar.YEAR, year);
                                            calendar.set(Calendar.WEEK_OF_YEAR, i);
                                            calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);
                                    
                                            String startDate = sdf.format(calendar.getTime());
                                            calendar.add(Calendar.DAY_OF_MONTH, 6);  // Move to the end of the week
                                            String endDate = sdf.format(calendar.getTime());
                                    
                                            String weekLabel = i + " (" + startDate + " - " + endDate + ")";
                                            String selected = (selectedWeek != null && Integer.toString(i).equals(selectedWeek)) ? " selected" : "";
                                            out.println("<option value=\"" + i + "\"" + selected + ">" + weekLabel + "</option>");
                                        }
                                    }
                                %>
                            </select>
                        </th>

                        <th>MON</th>
                        <th>TUE</th>
                        <th>WED</th>
                        <th>THU</th>
                        <th>FRI</th>
                        <th>SAT</th>
                        <th>SUN</th>
                    </tr>
                    <th>
                        <% 
                            String yearStr = (String) request.getAttribute("yearStr");
                            String weekStr = (String) request.getAttribute("weekStr");
                            int clinicID = (int) request.getAttribute("clinicID");
                        
                            List<ClinicScheduleDTO> workingDayByID = (List<ClinicScheduleDTO>) request.getAttribute("getAllClinicSchedule");

                            if (yearStr != null && !yearStr.isEmpty() && weekStr != null && !weekStr.isEmpty()) {
                                int year = Integer.parseInt(yearStr);
                                int week = Integer.parseInt(weekStr);

                                Calendar calendar = new GregorianCalendar();
                                calendar.set(Calendar.YEAR, year);
                                calendar.set(Calendar.WEEK_OF_YEAR, week);
                                calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                for (int i = 0; i < 7; i++) {
                                    String currentDate = sdf.format(calendar.getTime());
                                    out.println("<td>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</td>");
                                    calendar.add(Calendar.DAY_OF_MONTH, 1);
                                }
                            } else {
                                for (int i = 0; i < 7; i++) {
                                    out.println("<td></td>");
                                }
                            }
                        %>
                    </th>
                    <tr>
                        <% 
                            if (yearStr != null && !yearStr.isEmpty() && weekStr != null && !weekStr.isEmpty()) {
                                int year = Integer.parseInt(yearStr);
                                int week = Integer.parseInt(weekStr);

                                Calendar calendar = new GregorianCalendar();
                                calendar.set(Calendar.YEAR, year);
                                calendar.set(Calendar.WEEK_OF_YEAR, week);
                                calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

                                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                for (int i = 0; i < 7; i++) {
                                    String currentDate = sdf.format(calendar.getTime());
                                    boolean isWorkingDay = false;
                                    String workingDayInfo = "";
                                    for (ClinicScheduleDTO schedule : workingDayByID) {
                                    //can get schedule.getClinicID()
                                        if (schedule.getWorkingDay().equals(currentDate) && clinicID == schedule.getClinicID()) {
                                            isWorkingDay = true;
                                            workingDayInfo = "Clinic Schedule ID: " + schedule.getClinicScheduleID() + "<br><br>" + schedule.getDescription();
                                            break;
                                        }
                                    }
                                    if (isWorkingDay) {
                                        out.println("<td class=\"working-day\">" + workingDayInfo + "</td>");
                                    } else {
                                        out.println("<td></td>");
                                    }
                                    calendar.add(Calendar.DAY_OF_MONTH, 1);
                                }
                            } else {
                                for (int i = 0; i < 7; i++) {
                                    out.println("<td></td>");
                                }
                            }
                        %>
                    </tr>
                </table>
                <a href="LoadFromClinicScheduleToAddServlet?clinicByID=${clinicByID.clinicID}"><input type="button" name="" value="Add new schedule"></a>
                <a href="LoadFromClinicScheduleToModifyServlet?clinicByID=${clinicByID.clinicID}"><input type="button" name="" value="Modify new schedule"></a>

            </form>  
        </div>
    </body>
</html>
