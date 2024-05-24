<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1.0" />
        <meta
            name="description"
            content="Stay organized with our user-friendly Calendar featuring events, reminders, and a customizable interface. Built with HTML, CSS, and JavaScript. Start scheduling today!"
            />
        <meta
            name="keywords"
            content="calendar, events, reminders, javascript, html, css, open source coding"
            />
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.2.0/css/all.min.css"
            integrity="sha512-xh6O/CkQoPOWDdYTDqeRdPCVd1SpvCA9XXcUnZS2FmJNp1coAFzvtCN9BmamE+4aHK8yyUHUSCcJHgXloTyT2A=="
            crossorigin="anonymous"
            referrerpolicy="no-referrer"
            />
        <link rel="stylesheet" href="css/cal2.css" />
        <title>Calendar with Events</title>
    </head>
    <style>
        #doiMau {
            color: #2f89fc;
        }

        .highlight {
            background-color: red; /* Adjust as needed */
        }
    </style>
    <body>
        <div class="container">
            <div class="left">
                <div class="calendar">
                    <div class="month">
                        <i class="fas fa-angle-left prev"></i>
                        <div class="date">december 2015</div>
                        <i class="fas fa-angle-right next"></i>
                    </div>
                    <div class="weekdays">
                        <div>Sun</div>
                        <div>Mon</div>
                        <div>Tue</div>
                        <div>Wed</div>
                        <div>Thu</div>
                        <div>Fri</div>
                        <div>Sat</div>
                    </div>

                    <c:set value="${requestScope.clinicByID}" var="clinicByID"/>
                    <form action="AddClinicScheduleServlet?clinicByID=${clinicByID.clinicID}" method="post" id="scheduleForm">
                        <div class="days" id="days"></div>
                        <script>
                        </script>
                        <div class="goto-today">
                            <div class="goto">
                                <input type="text" placeholder="mm/yyyy" class="date-input" name="date"/>
                                <button type="button" class="goto-btn" onclick="submitForm()">Go</button>
                            </div>
                            <input type="submit" name="createSchedule" value="Create schedule">
                            <button type="button" class="today-btn" onclick="setToday()">Today</button>
                        </div>
                        <input type="hidden" id="day" name="workingDay"/>

                        <!-- Elements to display day and event date -->
                        <div>
                            <!--                            <span id="eventDayDisplay"></span>
                                                        <span id="eventDateDisplay"></span>-->
                        </div>
                        <!-- Hidden input to hold the eventDate value for form submission -->
                        <input type="hidden" id="eventDateInput" name="eventDate" value="eventDate"/>
                        <input type="hidden" id="clinicID" name="clinicID" value=${clinicByID.clinicID}>
                    </form>
                </div>
            </div>
            <div class="right">
                <div class="today-date">
                    <div class="event-day" id="eventDayDisplay">wed</div>
                    <div class="event-date" style="color: white" id="eventDateDisplay">12th december 2022</div>
                </div>
                <div class="events"></div>
                <div class="add-event-wrapper">
                    <div class="add-event-header">
                        <div class="title">Add Event</div>
                        <i class="fas fa-times close"></i>
                    </div>
                    <div class="add-event-body">
                        <div class="add-event-input">
                            <input type="text" placeholder="Event Name" class="event-name" />
                        </div>
                        <div class="add-event-input">
                            <input
                                type="text"
                                placeholder="Event Time From"
                                class="event-time-from"
                                />
                        </div>
                        <div class="add-event-input">
                            <input
                                type="text"
                                placeholder="Event Time To"
                                class="event-time-to"
                                />
                        </div>
                    </div>
                    <div class="add-event-footer">
                        <button style="color: white" class="add-event-btn">Add Event</button>
                    </div>
                </div>
            </div>
            <button class="add-event">
                <i class="fas fa-plus"></i>
            </button>
        </div>

        <script src="js/cal2.js"></script>
        <script>
                                function submitForm() {
                                    const dateInput = document.querySelector('.date-input').value;
                                    const formData = new FormData();
                                    formData.append('date', dateInput);

                                    fetch('AddClinicScheduleServlet', {
                                        method: 'POST',
                                        body: formData
                                    })
                                            .then(response => response.text())
                                            .then(data => {
                                                console.log('Success:', data);
                                            })
                                            .catch((error) => {
                                                console.error('Error:', error);
                                            });
                                }

                                function setToday() {
                                    const today = new Date();
                                    document.querySelector('.date-input').value = (today.getMonth() + 1).toString().padStart(2, '0') + '/' + today.getFullYear();
                                }
        </script>
    </body>
</html>