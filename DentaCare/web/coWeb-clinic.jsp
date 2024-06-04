<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="clinicSchedule.ClinicScheduleDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="clinicSchedule.ClinicScheduleDAO" %>
<%@ page import="timeSlot.TimeSlotDAO" %>
<%@ page import="timeSlot.TimeSlotDTO" %>
<%@ page import="slotDetail.SlotDetailDAO" %>
<%@ page import="slotDetail.SlotDetailDTO" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Admin</title>
        <!--<link rel="stylesheet" href="css/stylesheet.css">-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>
    <style>
        /* Styles for the entire document */

        .main-container {
            grid-area: main;
            overflow-y: auto;
            padding: 20px 20px;
            color: #333;
        }

        .main-header {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin: 0 50px 0 50px;
        }
        #sidebar {
            grid-area: sidebar;
            height: 100%;
            background-color: #2f89fc;
            overflow-y: auto;
            transition: all 0.5s;
            -webkit-transition: all 0.5s;
        }

        .sidebar-list {
            padding: 0;
            margin-top: 7rem;
            list-style-type: none;
        }

        .sidebar-list-item {
            padding: 20px 20px 20px 20px;
            font-size: 18px;
            font-weight: 500;
        }
        .sidebar-list a {
            text-decoration: none;
            color: #f4f4f4;
        }

        .sidebar-list-item:hover {
            background-color: rgba(255, 255, 255, 0.2);
            cursor: pointer;
        }

        .sidebar-responsive {
            display: inline !important;
            position: absolute;
            z-index: 12 !important;
        }
        .header {
            grid-area: header;
            height: 40px;
            display: flex;
            justify-content: space-between;
            padding: 20px 30px 0px 30px;
            box-shadow: 0 6px 7px -3px rgba(0, 0, 0, 0.35);
        }

        .header-icon span{
            padding: 0;
            margin-left: 20px;
        }
        .material-symbols-outlined:hover {
            cursor: pointer;
        }
        .material-icons-outlined {
            vertical-align: middle;
            line-height: 1px;
            font-size: 35px;
        }
        body {
            font-family: 'Montserrat', sans-serif;
            background-color: #f0f8ff;
            color: #333;
            margin: 0;
            padding: 0;
        }

        /* Container for form elements */
        .form-container, .time-slot-container {
            margin: 20px auto;
            padding: 20px;
            max-width: 1200px;
            background-color: #ffffff;
            border-radius: 8px;
            box-shadow: 0 0 15px rgba(0, 0, 0, 0.1);
        }

        /* Header styling */
        header.header {
            display: flex;
            justify-content: space-between;
            padding: 20px;
            background-color: white;
            color: #black;
        }

        .header-icon span {
            margin-left: 15px;
            cursor: pointer;
        }

        /* Sidebar styling */
        #sidebar {
            background-color: #2f89fc;
            padding: 20px;
            color: white;
            height: 100vh;
            position: fixed;
            top: 0;
            left: 0;
            width: 200px;
        }

        .sidebar-list {
            padding: 0;
            margin-top: 7rem;
            list-style-type: none;
        }

        .sidebar-list a {
            text-decoration: none;
            color: #f4f4f4;
        }

        .sidebar-list-item {
            padding: 20px 20px 20px 20px;
            font-size: 18px;
            font-weight: 500;
        }

        .sidebar-list-item:hover {
            background-color: rgba(255, 255, 255, 0.2);
            cursor: pointer;
        }

        .sidebar-responsive {
            display: inline !important;
            position: absolute;
            z-index: 12 !important;
        }

        /* Main container styling */
        .main-container, .main-container2 {
            padding: 20px;
            margin-left: 220px;
        }

        h1, h2 {
            text-align: center;
            color: #2f89fc;
            font-size: 28px;
            margin-bottom: 20px;
        }

        /* Table styling */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            text-align: center;
            padding: 15px;
            font-size: 16px;
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

        .event-day {
            background-color: #ff66ff;
            color: #ffff00;
            font-weight: bold;
        }

        /* Form elements */
        select, input[type="button"], input[type="submit"], input[type="date"], input[type="text"] {
            padding: 10px;
            margin: 5px;
            font-size: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            background-color: #f9f9f9;
        }

        select:hover, input[type="button"]:hover, input[type="submit"]:hover {
            background-color: #e0e0e0;
        }

        input[type="button"] {
            background-color: #2f89fc;
            color: white;
            border: none;
            transition: background-color 0.3s ease;
        }

        input[type="button"]:hover {
            background-color: #1d6fdc;
        }

        .create-button {
            background-color: #4CAF50;
            color: white;
            padding: 10px 20px;
            margin-top: 10px;
            border: none;
            border-radius: 5px;
            font-size: 16px;
            cursor: pointer;
        }

        .create-button:hover {
            background-color: #45a049;
        }

        /* Popup styling */
        .popup {
            position: fixed;
            top: -150%;
            left: 50%;
            opacity: 0;
            transform: translate(-50%, -50%) scale(1.25);
            width: 300px;
            padding: 20px;
            background: #fff;
            box-shadow: 2px 2px 10px rgba(0, 0, 0, 0.2);
            border-radius: 10px;
            transition: top 0ms ease-in-out 200ms, opacity 200ms ease-in-out 0ms, transform 200ms ease-in-out 0ms;
        }

        .popup.active {
            top: 50%;
            opacity: 1;
            transform: translate(-50%, -50%) scale(1);
            transition: top 0ms ease-in-out 0ms, opacity 200ms ease-in-out 0ms, transform 200ms ease-in-out 0ms;
        }

        .popup .close-btn {
            position: absolute;
            top: 10px;
            right: 10px;
            width: 20px;
            height: 20px;
            background-color: #888;
            color: #eee;
            text-align: center;
            line-height: 20px;
            border-radius: 50%;
            cursor: pointer;
            font-weight: bold;
        }

        .popup .form h2 {
            text-align: center;
            color: #222;
            margin-bottom: 20px;
            font-size: 25px;
        }

        .popup .form .form-element {
            margin-bottom: 15px;
        }

        .popup .form .form-element label {
            display: block;
            margin-bottom: 5px;
            font-size: 14px;
            color: #222;
        }

        .popup .form .form-element input[type="submit"] {
            width: 100%;
            height: 40px;
            border: none;
            outline: none;
            font-size: 18px;
            background: #4CAF50;
            color: #f4f4f4;
            border-radius:
            </style>
            <body>
                <div class="grid-container">
                    <!-- HEADER -->
                    <header class="header"> 
                        <div></div>
                        <div class="header-icon">
                            <span class="material-symbols-outlined">notifications</span>
                            <span class="material-symbols-outlined">mail</span>
                            <span class="material-symbols-outlined">account_circle</span>
                        </div>
                    </header>

                    <!-- SIDEBAR -->
                    <aside id="sidebar">
                        <div>
                            <ul class="sidebar-list">
                                <a href="coWeb-dashboard.jsp"><li class="sidebar-list-item">Dashboard</li></a>
                                <a href="coWeb-dentist.jsp"><li class="sidebar-list-item">Manage Dentist</li></a>
                                <a href="coWeb-staff.jsp"><li class="sidebar-list-item">Manage Staff</li></a>
                                <a href="LoadAllDentaListServlet"><li class="sidebar-list-item">Manage Clinic</li></a>
                                <a href="ServiceController"><li class="sidebar-list-item">Manage Service</li></a>
                                <a href="ManageStaffServlet"><li class="sidebar-list-item">Staff List</li></a>
                            </ul>
                        </div>
                    </aside>

                    <!-- MAIN -->
                    <div class="main-container">
                        <h2>CLINIC</h2>
                        <% ClinicScheduleDAO clinicScheduleDAO = new ClinicScheduleDAO(); %>
                        <% TimeSlotDAO timeDao = new TimeSlotDAO(); %>

                        <c:set value="${clinicByID.clinicID}" var="clinicID" />
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
                                            <select name="week" onchange="this.form.submit()" id="weekSelect">
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
                                    <tr>
                                        <%--<c:forEach items="${requestScope.clinicScheduleByClinicIDToDen}" var="clinicScheduleByClinicIDToDen">--%>
                                    <div class="clinic-card" data-url="LoadFromClinicToScheduleServlet?clinicScheduleID=${clinicScheduleByClinicIDToDen.getClinicScheduleID()}&clinicByID=${clinicList.clinicID}">   
                                        <% 
                                            out.println("<th></th>");
                                        String yearStr = (String) request.getAttribute("yearStr");
                                        String weekStr = (String) request.getAttribute("weekStr");
                                        int clinicID = (int) request.getAttribute("clinicID");
                        
                                        List<ClinicScheduleDTO> workingDayByID = (List<ClinicScheduleDTO>) request.getAttribute("getAllClinicSchedule");
                                        List<ClinicScheduleDTO> clinicScheduleByClinicIDToDen = (List<ClinicScheduleDTO>) request.getAttribute("clinicScheduleByClinicID");

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
                                                for (ClinicScheduleDTO clinicScheduleDTO : clinicScheduleByClinicIDToDen) {
                                                    if (clinicScheduleDTO.getWorkingDay().equals(currentDate)) {
                                                        int clinicScheduleIDToDen = clinicScheduleDTO.getClinicScheduleID();
                                                 //cho nay dang bi sai (load clinicScheduleID cho nay ban dau la null, sau khi add moi het null nen moi add thi kh hien gi)
                                                        out.println("<td><a href=\"LoadFromClinicScheduleToCreateEventServlet?clinicScheduleID=" + clinicScheduleIDToDen + "&clinicByID=" + clinicID + "\">" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</a></td>");  
//                                                            out.println("<td><a>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</a></td>");  
                                                        calendar.add(Calendar.DAY_OF_MONTH, 1);
                                                    }
                                                }
                                            }
                                           
                                        } else {
                                            for (int i = 0; i < 8; i++) {
                                                out.println("<td></td>");
                                            }
                                        }
                                        %>
                                    </div> 
                                    </tr>     
                                    <tr>
                                    <div class="clickDay">
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
                                        String checkEvent = "";
                        
                                        // add
                                        //List<ClinicScheduleDTO> clinicScheduleByClinicID = clinicScheduleDao.getWorkingDaysByClinicId(id);
                                        List<ClinicScheduleDTO> clinicScheduleByClinicID = (List<ClinicScheduleDTO>) request.getAttribute("clinicScheduleByClinicID");
                                        List<TimeSlotDTO> getAllTimeSlot = (List<TimeSlotDTO>) request.getAttribute("getAllTimeSlot");
                                        List<TimeSlotDTO> getAllTimeSl = (List<TimeSlotDTO>) timeDao.getAllTimeSLot();
                                        // líst này thì được nha
                //                        for (TimeSlotDTO timeSlotDTOCheck : getAllTimeSl) {
                //                                    System.out.println("Time slot " + timeSlotDTOCheck.getSlotID());
                //                            }
                                        SlotDetailDAO slotDao = new SlotDetailDAO();
                        
                                        boolean workingDayExists = false;
                                        // new test
                                        boolean scheduleExists = clinicScheduleByClinicID.stream().anyMatch(schedule -> schedule.getWorkingDay().equals(currentDate));

                                    if (!scheduleExists && calendar.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
                //                        System.out.println("Adding new clinic schedule for date: " + currentDate);
                                        boolean addClinicSchedule = clinicScheduleDAO.addNewClinicSchedule(currentDate, clinicID, "07:00 AM - 05:00 PM");
    
                                    if (addClinicSchedule) {
                //                        System.out.println("New clinic schedule added successfully for date: " + currentDate);
                                        workingDayByID = clinicScheduleDAO.getWorkingDaysByClinicId(clinicID);              
                                        for (ClinicScheduleDTO schedule : workingDayByID) {
                                            if (schedule.getWorkingDay().equals(currentDate)) {
                //                                System.out.println("Processing time slots for schedule ID: " + schedule.getClinicScheduleID());
                                                for (TimeSlotDTO timeSlotDTO : getAllTimeSl) {
                //                                    System.out.println("Time slot " + timeSlotDTO.getSlotID());
                                                    boolean addSlotToSchedule = slotDao.addSlotToSchedule(timeSlotDTO.getSlotID(), schedule.getClinicScheduleID());
                                                    if (addSlotToSchedule) {
                                                        System.out.println("Time slot " + timeSlotDTO.getSlotID() + " added to schedule ID: " + schedule.getClinicScheduleID());
                                                    } else {
                                                        System.err.println("Failed to add time slot " + timeSlotDTO.getSlotID() + " to schedule ID: " + schedule.getClinicScheduleID());
                                                    }
                                                }
                                            }
                                        }
                                    } else {
                                        System.err.println("Failed to add new clinic schedule for date: " + currentDate);
                                    }
                                } else {
                                    if (scheduleExists) {
                                        System.out.println("Schedule already exists for date: " + currentDate);
                                    }
                                    if (calendar.get(Calendar.DAY_OF_WEEK) == Calendar.SUNDAY) {
                                        System.out.println("Today is Sunday, no schedule to add.");
                                    }
                                }


                                                 workingDayByID = clinicScheduleDAO.getWorkingDaysByClinicId(clinicID);              
                                        for (ClinicScheduleDTO schedule : workingDayByID) {
                                            //can get schedule.getClinicID()
                                            if (schedule.getWorkingDay().equals(currentDate) && clinicID == schedule.getClinicID()) {     
                                                isWorkingDay = true;
                                                workingDayInfo = "Working Time " + "<br><br>" + schedule.getDescription();
                                                checkEvent = schedule.getDescription();
                                                break;
                                            }
                                        }
                                      
                        
                                            if (isWorkingDay) {
                                                if (!"07:00 AM - 05:00 PM".equals(checkEvent) || checkEvent.equals(null) || checkEvent == null ) { 
                                                out.println("<td class=\"event-day\">" + checkEvent + "</td>");
                                            } else {
                                                out.println("<td class=\"working-day\">" + workingDayInfo + "</td>");
                                            }
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
                //                                      response.setHeader("Refresh", "10; URL=http://localhost:9090/J2EE_Exercise/index.html");
                                        %>
                                    </div>
                                    </tr>
                                </table>
                                <!--TIME SLOT-->
                                <div style="margin-top: 100px" class="time-slot-container">
                                    <h1>Time Slot</h1>
                                    <table class="time-slot-table">
                                        <tr>
                                            <!-- <th>Time Periods</th> --> 
                                        </tr>
                                        <tr>
                                            <c:forEach items="${requestScope.getAllTimeSlot}" var="getAllTimeSlot">
                                                <td>${getAllTimeSlot.getTimePeriod()}</td>
                                            </c:forEach>
                                        </tr>
                                    </table>
                                </div>                <!-- END POPUP -->

                                <a href="LoadFromClinicScheduleToCreateEventServlet2?clinicByID=${clinicByID.clinicID}"><input type="button" name="" value="Add new event for clinic schedule"></a>
                                <div class="center-button">
                                    <a href="LoadFromClinicScheduleToDentistScheduleServlet?clinicByID=${clinicByID.clinicID}">
                                        <input type="button" name="" value="View Dentist Schedule">
                                    </a>
                                </div>
                            </form>  
                            <a href="LoadAllDentaListServlet" style="background-color: red;
                            color: white;
                            padding: 10px 20px;
                            text-decoration: none;
                            border-radius: 4px;
                            font-size: 16px;
                            display: inline-block;
                            text-align: center;">
                            Return
                        </a>

                        <!--                         MAIN 
                                                <div class="main-container2">
                                                    <div class="main-header">
                                                        <button id="create-button" class="create-button">CREATE CLINIC SCHEDULE</button>
                                                                        <a href="LoadFromClinicScheduleToCreateEventServlet?clinicByID=${clinicByID.clinicID}"><input type="button" name="" value="Add new event for clinic schedule"></a>
                        
                                                    </div>
                                                     FORM POPUP
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
                        <p style="font-weight: bold;
                           color: red" class="error-message">${existingSchedule}</p>
                        <%
                            }
                        %>

                        <%
                            Boolean createEventClinicSchedule = (Boolean) request.getAttribute("createEventClinicSchedule");
                            if (Boolean.TRUE.equals(createEventClinicSchedule)) {
                        %>
                        <p style="font-weight: bold;
                        color: green">Create New Schedule Successfully!</p>
                        <%
                            }
                        %>
                    </form>
                </div>
            </div>-->
                        <script>
                            document.querySelector("#create-button").addEventListener("click", function () {
                                document.querySelector(".popup").classList.add("active");
                            });

                            document.querySelector(".popup .close-btn").addEventListener("click", function () {
                                document.querySelector(".popup").classList.remove("active");
                            });

                            document.addEventListener('DOMContentLoaded', (event) => {
                                const clinicCards = document.querySelectorAll('.clinic-card');

                                clinicCards.forEach(card => {
                                    card.addEventListener('click', () => {
                                        const url = card.getAttribute('data-url');
                                        window.location.href = url;
                                    });
                                });
                            });
                        </script>

                        <!-- JavaScript code for handling calendar cell clicks -->
                        <script>
                            // Function to handle click event on calendar cell
                            function handleDayClick(date) {
                                // You can perform actions based on the clicked date
                                alert("Clicked on date: " + date);
                                // For example, you can redirect to another page passing the date as a parameter
                                window.location.href = "handleDayClickServlet?date=" + date;
                            }
                        </script>


                    </div>
                </div>
            </div>
        </div>
    </body>
</html>

