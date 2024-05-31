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
            .create-button {
                background-color: #4CAF50; /* Green */
                color: white;
                padding: 10px 20px;
                margin-top: 10px;
                border: none;
                border-radius: 5px;
                font-size: 16px;

            }

            .create-button:hover {
                background-color: #45a049;
                cursor: pointer;
            }

            .popup {
                position: absolute;
                top: -150%;
                left: 50%;
                opacity: 0;
                transform: translate(-50%, -50%) scale(1.25);
                width: 300px;
                padding: 10px 60px;
                background: #fff;
                box-shadow: 2px 2px 5px 5px rgba(0, 0, 0, 0.15);
                border-radius: 10px;
                transition: top 0ms ease-in-out 200ms,
                    opacity 200ms ease-in-out 0ms,
                    transform 200ms ease-in-out 0ms;
            }

            .popup.active {
                top: 50%;
                opacity: 1;
                transform: translate(-50%, -50%) scale(1);
                transition: top 0ms ease-in-out 0ms,
                    opacity 200ms ease-in-out 0ms,
                    transform 200ms ease-in-out 0ms;
            }

            .popup .close-btn {
                position: absolute;
                top: 10px;
                right: 10px;
                width: 15px;
                height: 15px;
                background-color: #888;
                color: #eee;
                text-align: center;
                line-height: 15px;
                border-radius: 15px;
                cursor: pointer;
            }

            .popup .form h2 {
                text-align: center;
                color: #222;
                margin: 10px 0px 20px;
                font-size: 25px;
            }

            .popup .form .form-element {
                margin: 15px 0px;
            }

            .popup .form .form-element label {
                font-size: 14px;
                color: #222;
            }

            .popup .form .form-element input[type="submit"] {
                width: 50%;
                height: 40px;
                border: none;
                outline: none;
                font-size: 18px;
                background: #4CAF50;
                color: #f4f4f4;
                border-radius: 10px;
                cursor: pointer;
            }

            label {
                display: block;
                margin-bottom: 5px;
                font-weight: bold;
            }

            input[type="date"],
            input[type="text"],
            select {
                width: 100%;
                padding: 8px;
                border-radius: 3px;
                border: 1px solid #ccc;
            }

            input[type="submit"] {
                background-color: #007bff;
                color: #fff;
                border: none;
                padding: 10px 15px;
                border-radius: 3px;
                cursor: pointer;
            }

            input[type="submit"]:hover {
                background-color: #0056b3;
            }

            /* Style the form heading */
            h2 {
                text-align: center;
                margin-bottom: 20px;
            }
            select {
                width: 200px;
                padding: 8px;
                border-radius: 5px;
                border: 1px solid #ccc;
                cursor: pointer;
            }

            /* Style option items */
            select option {
                padding: 5px;
            }

            /* Style the select container */
            .select-container {
                margin-bottom: 15px;
            }

            /* Style the select labels */
            .label {
                font-weight: bold;
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
                            for (int i = 0; i < 8; i++) {
                                out.println("<td></td>");
                            }
                        }
                        %>
                    </th>                                  
                    <tr>
                        <% 
                            out.println("<th></th>");
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

                <!-- END POPUP -->

                <a href="LoadFromClinicScheduleToAddServlet?clinicByID=${clinicByID.clinicID}"><input type="button" name="" value="Add new schedule"></a>
                <a href="LoadFromClinicScheduleToModifyServlet?clinicByID=${clinicByID.clinicID}"><input type="button" name="" value="Modify new schedule"></a>

            </form>  
            <!-- MAIN -->
            <div class="main-container">
                <div class="main-header">
                    <button id="create-button" class="create-button">CREATE CLINIC SCHEDULE</button>
                </div>
                <!-- FORM POPUP-->
                <div class="popup">
                    <div class="close-btn">&times;</div>
                    <div class="form">
                        <h2>CREATE CLINIC SCHEDULE</h2>
                        <form action="AddClinicScheduleServlet?clinicID=${clinicByID.clinicID}" method="get">
                            <div class="form-element">
                                <label for="username">workingDay</label>
                                <input type="date" name="workingDay" required>
                            </div> 
                            <div class="form-element">
                                <label for="email">clinicID</label>
                                <input readonly type="text" name="clinicID" value="${clinicByID.clinicID} ">
                            </div>

                            <div class="form-element">
                                <label for="fullname">description</label>
                                <select name="description">
                                    <option value="di lam">đi làm</option>
                                    <option value="nghi le">nghỉ lễ</option>
                                </select>                              
                            </div>
                            <div class="form-element">
                                <input type="submit" value="Submit">
                            </div>
                            <c:set value="${requestScope.alreadyHave}" var="existingSchedule"/>
                            <% String existingSchedule = (String) request.getAttribute("alreadyHave");
                                if (existingSchedule != null) {
                            %>
                            <p style="font-weight: bold; color: red" class="error-message">${existingSchedule}</p>
                            <%
                                }
                            %>

                            <%
                                Boolean addClinicSchedule = (Boolean) request.getAttribute("addClinicSchedule");
                                if (Boolean.TRUE.equals(addClinicSchedule)) {
                            %>
                            <p style="font-weight: bold; color: green">Create New Schedule Successfully!</p>
                            <%
                                }
                            %>
                        </form>
                    </div>
                </div>
                <script>
                    document.querySelector("#create-button").addEventListener("click", function () {
                        document.querySelector(".popup").classList.add("active");
                    });

                    document.querySelector(".popup .close-btn").addEventListener("click", function () {
                        document.querySelector(".popup").classList.remove("active");
                    });
                </script>
            </div>
        </div>
    </body>
</html>
