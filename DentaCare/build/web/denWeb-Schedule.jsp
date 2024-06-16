
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="clinicSchedule.ClinicScheduleDTO" %>
<%@ page import="java.util.List" %>
<%@ page import="clinicSchedule.ClinicScheduleDAO" %>
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
        <link rel="stylesheet" href="css/clinicSchedule.css">
        <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>

    </head>


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
            <% ClinicScheduleDAO clinicScheduleDAO = new ClinicScheduleDAO(); %>
            <%
                        LocalDate now2 = LocalDate.now();
                        WeekFields weekFields = WeekFields.of(Locale.getDefault());
                        int currentYear2 = now2.getYear();
                        int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
            %>
            <!-- MAIN -->
            <div class="main-container">
                <h2>Dentist</h2>

                <c:set value="${clinicByID.clinicID}" var="clinicID" />

                <div class="form-container">
                    <h1>Dentist Schedule</h1>
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
                        <p>Do you want to add dentist for this day ?</p>
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

                <div id="successPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('successPopup')">&times;</span>
                        <p id="successMessage"></p>
                    </div>
                </div>

                <div id="sundayPopup" class="popup">
                    <div style="background-color: #ffe6e6;" class="popup-content">
                        <span class="close-btn" onclick="closePopup('sundayPopup')">&times;</span>
                        <p>Dentists can not be allowed to add on Sundays !</p>
                    </div>
                </div>

                <div id="holidayPopup" class="popup">
                    <div style="background-color: #ffe6e6;" class="popup-content">
                        <span class="close-btn" onclick="closePopup('holidayPopup')">&times;</span>
                        <p>Dentists can not be allowed to add for the holidays !</p>
                    </div>
                </div>

                <!-- Second Popup for setting the event -->
                <div id="eventPopup" class="popup">
                    <div class="popup-content">
                        <span class="close-btn" onclick="closePopup('eventPopup')">&times;</span>
                        <h2>Set Dentist</h2>
                        <form id="eventForm" method="post" action="LoadFromClinicScheduleToDentistScheduleServlet?action=loadDenSchedule&clinicByID=${clinicByID.clinicID}" onsubmit="return submitForm(event)">
                            <input type="hidden" name="offDate" id="eventDate">
                            <label for="eventName">List of dentist:</label>
                            <select name="accountID">
                                <c:forEach items="${requestScope.listAllDentist}" var="den">
                                    <option value="${den.accountID}">${den.fullName}</option>
                                </c:forEach>
                            </select>
                            <input type="hidden" name="key" value="addDenToSchedule" required>
                            <br>
                            <div class="button-container">
                                <button type="submit">Set Dentist</button>
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
                        if (popupId === 'successPopup') {
                            // Do nothing here to delay the reload until the close button is clicked
                        }
                    }

                    // Function to check if the selected date is a Sunday
                    function isSunday(date) {
                        const dayOfWeek = new Date(date).getDay();
                        return dayOfWeek === 0; // 0 corresponds to Sunday
                    }

                    document.addEventListener('DOMContentLoaded', () => {
                        const clinicCards = document.querySelectorAll('.clinic-card');
                        clinicCards.forEach(card => {
                            card.addEventListener('click', () => {
                                const url = card.getAttribute('data-url');
                                window.location.href = url;
                            });
                        });

                        let selectedDate = '';

                        function handleDayClick(date, cell) {
                            selectedDate = date;
                            document.querySelectorAll('.table-cell, .table-cell2').forEach(c => c.classList.remove('selected'));
                            cell.classList.add('selected');

                            if (isSunday(date)) {
                                // Display the sundayPopup if it's a Sunday
                                showPopup('sundayPopup');
                                return; // Prevent further actions
                            }

                            if (cell.classList.contains('table-cell')) {
                                showPopup('confirmationPopup');
                            } else if (cell.classList.contains('table-cell2')) {
                                showPopup('holidayPopup');
                                return;
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
                            // Reload the page after closing successPopup
                            location.reload();
                        });

                        $('#eventForm').on('submit', function (e) {
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
                                        closePopup('eventPopup'); // Close eventPopup
                                        showPopup('successPopup');
                                    } else {
                                        document.getElementById('errorMessage').textContent = response.message;
                                        showPopup('errorPopup');
                                        location.reload(); // Reload the page to show updated data
                                    }
                                },
                                error: function (jqXHR) {
                                    const response = jqXHR.responseJSON;
                                    if (response && !response.success) {
                                        document.getElementById('errorMessage').textContent = response.message;
                                        closePopup('eventPopup'); // Close eventPopup
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
