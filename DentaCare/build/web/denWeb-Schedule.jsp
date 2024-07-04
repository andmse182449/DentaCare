
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="account.AccountDAO" %>
<%@ page import="account.AccountDTO" %>
<%@ page import="dentistSchedule.DentistScheduleDAO" %>
<%@ page import="dentistSchedule.DentistScheduleDTO" %>
<%@ page import="java.util.*" %>
<%@ page import="dayOffSchedule.DayOffScheduleDTO" %>
<%@ page import="dayOffSchedule.DayOffScheduleDAO" %>
<%@ page import="java.time.LocalDate, java.time.temporal.WeekFields, java.util.Locale" %>
<%@ page import="java.text.SimpleDateFormat" %>

<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dentist Schedule</title>
        <!--<link rel="stylesheet" href="css/stylesheet.css">-->
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <!--<link rel="stylesheet" href="css/co-denSchedule.css">-->
        <link rel="stylesheet" href="css/selectCalendar.css">
        <link rel="stylesheet" href="css/clinicSchedule.css">
        <link rel="stylesheet" href="css/stylesheet2.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>


    <body>
        <%
                        LocalDate now2 = LocalDate.now();
                        WeekFields weekFields = WeekFields.of(Locale.getDefault());
                        int currentYear2 = now2.getYear();
                        int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
                        int currentMonth2 = now2.getMonthValue(); // Get current month number
        %>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header"> 
                <div><h1 style="font-weight: bold">CLINIC</h1></div>
                <div class="header-icon">
                    <span class="material-symbols-outlined" style="font-size: 32px;" onclick="toggleDropdown()">account_circle</span>
                    <!-- Dropdown Content -->
                    <div class="sub-menu-wrap" id="sub-menu-wrap">
                        <div class="sub-menu">
                            <div class="user-info">
                                <h3>${sessionScope.account.userName}</h3>
                            </div>
                            <hr>

                            <a href="SignOutServlet" class="sub-menu-link">
                                <span class="material-symbols-outlined">logout</span>
                                <p>Logout</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
                <script>
                    let subMenu = document.getElementById("sub-menu-wrap");
                    function toggleDropdown() {
                        subMenu.classList.toggle("open-menu");
                    }
                </script>

            </header>

            <!-- SIDEBAR -->
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="DashBoardServlet?action=dashboardAction&year1=<%=currentYear2%>&year2=<%=currentYear2%>&month=<%=currentMonth2%>"><li class="sidebar-list-item sidebar-list-item-selected"><span class="material-symbols-outlined">monitoring</span> <div>Dashboard</div></li></a>
                        <a href="ForDentistInfo?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Dentist</div></li></a>
                        <a href="DentistMajorServlet?action=forward"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Major</div></li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                        <a href="ServiceController"><li class="sidebar-list-item"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                        <a href="ManageCustomerServlet"><li class="sidebar-list-item">Manage Customer</li></a>
                    </ul>
                </div>
            </aside>

            <!-- MAIN -->
            <div class="main-container">
                <c:set value="${clinicByID.clinicID}" var="clinicID" />

                <div class="form-container">
                    <h2>Dentist Schedule</h2>
                    <form method="post" action="LoadFromClinicScheduleToDentistScheduleServlet?action=loadDenSchedule&clinicByID=${clinicByID.clinicID}">
                        <!--                        <input type="hidden" name="action" value="load">-->
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
                                <% 
                                    out.println("<th></th>");
                                String yearStr = (String) request.getAttribute("yearStr");
                                String weekStr = (String) request.getAttribute("weekStr");
                                int clinicID = (int) request.getAttribute("clinicID");
                        
                                List<DayOffScheduleDTO> off = (List<DayOffScheduleDTO>) request.getAttribute("off");


                                if (yearStr != null && !yearStr.isEmpty() && weekStr != null && !weekStr.isEmpty()) {
                                    int year = Integer.parseInt(yearStr);
                                    int week = Integer.parseInt(weekStr);

                                    Calendar calendar = new GregorianCalendar();
                                    calendar.set(Calendar.YEAR, year);
                                    calendar.set(Calendar.WEEK_OF_YEAR, week);
                                    calendar.set(Calendar.DAY_OF_WEEK, Calendar.MONDAY);

                                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

                                    for (int i = 0; i < 7; i++) {
                                        boolean isWorkingDay = false;
                                        String workingDayInfo = "";
                                        String checkEvent = "";
                                        String currentDate = sdf.format(calendar.getTime());
                                          for (DayOffScheduleDTO offDateDTO : off) {
                                                    if (offDateDTO.getDayOff().equals(currentDate)) {
                                                        isWorkingDay = true;
                                                        checkEvent = offDateDTO.getDescription();
                                                    }
                                                }
                                                if (!isWorkingDay) {
                                                    out.println("<td class='table-cell' data-date='" + currentDate + "' onclick='handleDayClick(\"" + currentDate + "\")'>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</td>");
                                            } else {
                                                    out.println("<td class='table-cell2' data-date='" + currentDate + "'>" + calendar.get(Calendar.DAY_OF_MONTH) + "/" + (calendar.get(Calendar.MONTH) + 1) + "</td>");
                                            }
                                                calendar.add(Calendar.DAY_OF_MONTH, 1);
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
                                        List<DentistScheduleDTO> getAllDentist = (List<DentistScheduleDTO>) request.getAttribute("getAllDentist");
                                        AccountDAO accDao = new AccountDAO();
                                        List<AccountDTO> denList = accDao.getAccountDentistByRoleID1(clinicID); 

                                        Map<String, AccountDTO> dentistMap = new HashMap<>();
                                        for (AccountDTO account : denList) {
                                            dentistMap.put(account.getAccountID(), account);
                                        }

                                        Map<String, List<DentistScheduleDTO>> scheduleMap = new HashMap<>();
                                        for (DentistScheduleDTO schedule : getAllDentist) {
                                            scheduleMap.computeIfAbsent(schedule.getWorkingDate(), k -> new ArrayList<>()).add(schedule);
                                        }

                                        Map<String, String> dayOffMap = new HashMap<>();
                                        for (DayOffScheduleDTO offDate : off) {
                                            dayOffMap.put(offDate.getDayOff(), offDate.getDescription());
                                        }

                                        for (int i = 0; i < 7; i++) {
                                            String currentDate = sdf.format(calendar.getTime());
                                            boolean isWorkingDay = false;
                                            StringBuilder workingDayInfo = new StringBuilder();

                                            if (calendar.get(Calendar.DAY_OF_WEEK) != Calendar.SUNDAY) {
                                                List<DentistScheduleDTO> schedulesForDay = scheduleMap.getOrDefault(currentDate, Collections.emptyList());
                                                for (DentistScheduleDTO schedule : schedulesForDay) {
                                                AccountDTO account = null;
                                                    account = dentistMap.get(schedule.getAccountID());
                                                        isWorkingDay = true;
                                                        if (workingDayInfo.length() > 0) {
                                                            workingDayInfo.append("<br>");
                                                        }
                                                        workingDayInfo.append(account.getFullName());
//                                                                      .append(" (Working Time: ")
//                                                                      .append(schedule.getDentistScheduleID())
//                                                                      .append(")");
                                                    }
//                                                }

                                                String checkEvent = dayOffMap.getOrDefault(currentDate, "");

                                                if (!checkEvent.isEmpty()) {
                                                    out.println("<td class=\"working-day\">" + checkEvent + "</td>");
                                                } else if (isWorkingDay) {
                                                    out.println("<td class=\"event-day\">" + workingDayInfo.toString() + "</td>");
                                                } else {
                                                    out.println("<td></td>");
                                                }
                                            } else {
                                                out.println("<td></td>");
                                            }
                                            calendar.add(Calendar.DAY_OF_MONTH, 1);
                                        }
                                    
                                                        // neu ma muon sua thi tu day !!
                                            } else {
                                                for (int i = 0; i < 7; i++) {
                                                    out.println("<td></td>");
                                                }
                                            }
                                %>
                            </div>
                            </tr>
                        </table>

                    </form>  
                    <c:set value="${requestScope.weekStr}" var="year"/>
                    <c:set value="${requestScope.weekStr}" var="week"/>
                    <br>
                    <div class="calendar-box">
                        <h2>Add multiple dentist</h2>
                        <button id="openCalendarButton">Open Calendar</button>
                        <form id="calendarForm" action="LoadFromClinicScheduleToDentistScheduleServlet?action=loadDenSchedule&clinicByID=${clinicByID.clinicID}" method=<label for="dentistSelect">Choose a dentist:</label>
                            <select name="accountID">
                                <c:forEach items="${requestScope.listAllDentist}" var="den">
                                    <option value="${den.accountID}">${den.fullName}</option>
                                </c:forEach>
                            </select>
                            <div id="calendarModal" style="display: none;">
                                <div id="calendar"></div>
                                <input type="hidden" id="date-input" name="selectedDaysDisplay">
                                <input type="hidden" name="key" value="addMultiDen">
                                <div id="selectedDaysDisplay"></div>
                            </div>
                            <br>
                            <button type="submit">Add Dentist</button>
                        </form>
                    </div>
                    <script src="js/selectCalendar.js"></script>
                    <br>
                    <a href="LoadFromClinicToScheduleServlet?action=loadClinicSchedule&clinicByID=${clinicByID.clinicID}&year=<%=currentYear2%>&week=<%=currentWeek2%>" style="background-color: red;
                       color: white;
                       padding: 10px 20px;
                       text-decoration: none;
                       border-radius: 4px;
                       font-size: 16px;
                       display: inline-block;
                       text-align: center;">
                        Return
                    </a>
                </div>
                <!-- First Popup for confirmation -->
                <div id="confirmationPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('confirmationPopup')">&times;</span>
                        <p>Do you want to add/modify dentist for this day?</p>
                        <button id="confirmButton">OK</button>
                    </div>
                </div>

                <!-- Error Popup -->
                <div id="errorPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('errorPopup')">&times;</span>
                        <p id="errorMessage"></p>
                    </div>
                </div>

                <!-- Success Popup -->
                <div id="successPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('successPopup')">&times;</span>
                        <p id="successMessage"></p>
                    </div>
                </div>

                <!-- Sunday Popup -->
                <div id="sundayPopup" class="popup">
                    <div style="background-color: #ffe6e6;" class="popup-content">
                        <span class="close-btn" onclick="closePopup('sundayPopup')">&times;</span>
                        <p>Dentists cannot be added on Sundays!</p>
                    </div>
                </div>

                <!-- Holiday Popup -->
                <div id="holidayPopup" class="popup">
                    <div style="background-color: #ffe6e6;" class="popup-content">
                        <span class="close-btn" onclick="closePopup('holidayPopup')">&times;</span>
                        <p>Dentists cannot be added for holidays!</p>
                    </div>
                </div>

                <!-- Event Popup for setting the event -->
                <div id="eventPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('eventPopup')">&times;</span>
                        <h2>Set Dentist</h2>
                        <form id="addForm" method="post" action="LoadFromClinicScheduleToDentistScheduleServlet?action=loadDenSchedule&clinicByID=${clinicByID.clinicID}" onsubmit="return submitForm(event)">
                            <input type="hidden" name="offDate" id="eventDate">
                            <label for="accountID">List of dentist:</label>
                            <select name="accountID">
                                <c:forEach items="${requestScope.listAllDentist}" var="den">
                                    <option value="${den.accountID}">${den.fullName}</option>
                                </c:forEach>
                            </select>
                            <input type="hidden" name="key" value="addDenToSchedule">
                            <div class="button-container">
                                <button type="submit">Set Dentist</button>
                            </div>
                        </form>

                        <h2>Modify Dentist Schedule</h2>
                        <form id="modifyForm" method="post" action="LoadFromClinicScheduleToDentistScheduleServlet?action=loadDenSchedule&clinicByID=${clinicByID.clinicID}" onsubmit="return submitForm(event)">
                            <input type="hidden" name="offDate" id="eventDate">
                            <label for="oldAccountID">Current Dentist:</label>
                            <select name="oldAccountID">
                                <c:forEach items="${requestScope.listAllDentist}" var="den">
                                    <option value="${den.accountID}">${den.fullName}</option>
                                </c:forEach>
                            </select>
                            <label for="accountID">New Dentist:</label>
                            <select name="accountID">
                                <c:forEach items="${requestScope.listAllDentist}" var="den">
                                    <option value="${den.accountID}">${den.fullName}</option>
                                </c:forEach>
                            </select>
                            <input type="hidden" name="key" value="modifyDenToSchedule">
                            <div class="button-container">
                                <button type="submit">Modify Dentist Schedule</button>
                            </div>
                        </form>
                    </div>
                </div>

                <script>
                    function showPopup(popupId) {
                        document.getElementById(popupId).style.display = 'flex';
                    }

                    function closePopup(popupId) {
                        document.getElementById(popupId).style.display = 'none';
                    }

                    // Function to check if the selected date is a Sunday
                    function isSunday(date) {
                        const dayOfWeek = new Date(date).getDay();
                        return dayOfWeek === 0; // 0 corresponds to Sunday
                    }

                    document.addEventListener('DOMContentLoaded', () => {
                        let selectedDate = '';

                        function handleDayClick(date, cell) {
                            selectedDate = date;
                            document.querySelectorAll('.table-cell, .table-cell2').forEach(c => c.classList.remove('selected'));
                            cell.classList.add('selected');

                            if (isSunday(date)) {
                                showPopup('sundayPopup');
                                return; // Prevent further actions
                            }

                            if (cell.classList.contains('table-cell')) {
                                showPopup('confirmationPopup');
                            } else if (cell.classList.contains('table-cell2')) {
                                showPopup('holidayPopup');
                            }
                        }

                        document.querySelectorAll('.table-cell, .table-cell2').forEach(cell => {
                            const date = cell.getAttribute('data-date');
                            cell.addEventListener('click', () => handleDayClick(date, cell));
                        });

                        document.getElementById('confirmButton').addEventListener('click', () => {
                            closePopup('confirmationPopup');
                            showPopup('eventPopup');
                            document.getElementById('eventDate').value = selectedDate;
                        });

                        document.querySelector('#successPopup .close-btn').addEventListener('click', () => {
                            closePopup('successPopup');
                            location.reload(); // Reload the page after closing successPopup
                        });

                        document.querySelector('#errorPopup .close-btn').addEventListener('click', () => {
                            closePopup('errorPopup');
                            location.reload(); // Reload the page after closing successPopup
                        });

                        $('#addForm, #modifyForm, #calendarForm').on('submit', function (e) {
                            e.preventDefault();
                            const formData = $(this).serialize();
                            $.ajax({
                                type: 'POST',
                                url: $(this).attr('action'),
                                data: formData,
                                success: function (response) {
                                    if (response.success) {
                                        const successMessage = response.message;
                                        document.getElementById('successMessage').textContent = successMessage;
                                        closePopup('eventPopup');
                                        showPopup('successPopup');
                                    } else {
                                        document.getElementById('errorMessage').textContent = response.message;
                                        showPopup('errorPopup');
                                    }
                                },
                                error: function (jqXHR) {
                                    const response = jqXHR.responseJSON;
                                    if (response && !response.success) {
                                        document.getElementById('errorMessage').textContent = response.message;
                                        closePopup('eventPopup');
                                        showPopup('errorPopup');
                                    } else {
                                        alert('An error occurred. Please try again.');
                                    }
                                }
                            });
                        });

                    <% if (request.getAttribute("wrong") != null) { %>
                        document.addEventListener('DOMContentLoaded', () => {
                            document.getElementById('errorMessage').textContent = '<%= request.getAttribute("wrong") %>';
                            showPopup('errorPopup');
                        });
                    <% } %>
                    });
                </script>

                <style>
                    /* General popup styling */
                    .popup {
                        display: none;
                        position: fixed;
                        z-index: 1000;
                        left: 0;
                        top: 0;
                        width: 100%;
                        height: 100%;
                        background-color: rgba(0, 0, 0, 0.6);
                        justify-content: center;
                        align-items: center;
                        transition: all 0.3s ease-in-out;
                    }

                    .popup-content {
                        position: relative;
                        background-color: #fff;
                        padding: 30px;
                        border-radius: 10px;
                        box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2);
                        text-align: center;
                        max-width: 500px;
                        width: 90%;
                        animation: popupAnimation 0.3s ease-out;
                    }

                    @keyframes popupAnimation {
                        from {
                            transform: scale(0.8);
                            opacity: 0;
                        }
                        to {
                            transform: scale(1);
                            opacity: 1;
                        }
                    }

                    .close-btn {
                        position: absolute;
                        right: 15px;
                        top: 15px;
                        font-size: 24px;
                        font-weight: bold;
                        color: #999;
                        cursor: pointer;
                        transition: color 0.3s ease;
                    }

                    .close-btn:hover {
                        color: #333;
                    }

                    .popup p {
                        margin: 20px 0;
                        font-size: 16px;
                        color: #555;
                    }

                    button {
                        text-align: center;
                        background-color: #007bff;
                        color: white;
                        border: none;
                        padding: 12px 25px;
                        border-radius: 5px;
                        cursor: pointer;
                        font-size: 16px;
                        transition: background-color 0.3s ease;
                    }

                    button:hover {
                        background-color: #0056b3;
                    }

                    .button-container {
                        display: flex;
                        justify-content: center;
                    }

                    /* Specific styles for each popup */
                    #confirmationPopup .popup-content {
                        background-color: #f9f9f9;
                    }

                    #errorPopup .popup-content {
                        background-color: #ffe6e6;
                    }

                    #successPopup .popup-content {
                        background-color: #e6ffe6;
                    }

                    #eventPopup .popup-content {
                        background-color: #f9f9f9;
                        text-align: left;
                    }

                    #eventPopup label {
                        display: block;
                        margin-bottom: 10px;
                        font-weight: bold;
                        color: #333;
                    }

                    #eventPopup select, #eventPopup input[type="hidden"] {
                        width: 100%;
                        padding: 10px;
                        margin-bottom: 20px;
                        border: 1px solid #ccc;
                        border-radius: 4px;
                        box-sizing: border-box;
                    }

                </style>
            </div>
        </div>
    </div>
</body>
</html>
