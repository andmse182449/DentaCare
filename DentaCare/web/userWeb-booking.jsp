<%-- 
    Document   : userWeb-booking
    Created on : Jun 6, 2024, 3:12:25 PM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>

<!DOCTYPE html>
<html lang="en">
    <head>
        <title>DentaCare</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">
        <link rel="stylesheet" href="css/drop-down.css">
        <link rel="stylesheet" href="css/styleBooking.css">
        <link rel="stylesheet" href="css/booking.css">
        <link rel="stylesheet" href="css/styleCalendar.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">
    </head>
    <body>
        <c:set var="account" value="${sessionScope.account}"/>
        <c:set var="clinicLimit" value="${requestScope.clinicLimit}"/>
        <c:set var="slotLimit" value="${requestScope.slotLimit}"/>
        <c:set var="dayLimit" value="${requestScope.dayLimit}"/>

        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light scrolled sleep awake">
            <div class="container">
                <a class="navbar-brand" href="#">
                    Denta
                    <span>Care</span>
                </a>
                <div class="navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active">
                            <a href="#" class="nav-link">Home</a>
                        </li>
                        <li class="nav-item">
                            <a href="services.html" class="nav-link">Services</a>
                        </li>
                        <li class="nav-item">
                            <a href="doctors.html" class="nav-link">Doctors</a>
                        </li>
                        <li class="nav-item" style="margin-top: 3px;">
                            <div class="action">
                                <div onclick="menuToggle();">
                                    <a href="#" class="nav-link" style="color:white; padding: 8px 18px;">${account.userName}</a>
                                </div>
                                <div class="menu">
                                    <ul>
                                        <li>
                                            <img src="images/user.png">
                                            <a href="ProfileServlet">Profile</a>
                                        </li>
                                        <li>
                                            <img src="images/schedule.png">
                                            <a href="ExamScheduleServlet">Examination Schedule</a>
                                        </li>
                                        <li>
                                            <img src="images/history.png">
                                            <a href="HistoryServlet">Booking History</a>
                                        </li>
                                        <li>
                                            <img src="images/log-out.png">
                                            <a href="SignOutServlet">Logout</a>
                                        </li>
                                    </ul>
                                </div>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- MAIN BOOKING -->
        <div class="main-booking">
            <!-- FIELD FOR CHOOSING OPTIONs -->
            <div class="alert-error sec">${error}</div>
            <input type="hidden" name="listDayoff" id="listDayoff" value="${requestScope.listDayOff}"/>
            <div class="container">
                <h1>Book Service</h1>
                <hr>
                <div class="bookingfield">
                    <div class="bookingfield-header">
                        <h3 data-number="1">Clinic<span class="text-red-500">*</span></h3>
                        <span class="material-symbols-outlined">arrow_drop_down</span>
                    </div>
                    <div class="bookingfield-content">
                        <ul>
                            <c:forEach items="${requestScope.clinics}" var="clinic">
                                <li class="clinic-option" data-address="${clinic.clinicAddress}" data-id="${clinic.clinicID}">${clinic.clinicName}</li>
                                </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="bookingfield">
                    <div class="bookingfield-header">
                        <h3 data-number="2">Service<span class="text-red-500">*</span></h3>
                        <span class="material-symbols-outlined">arrow_drop_down</span>
                    </div>
                    <div class="bookingfield-content">
                        <ul>
                            <c:forEach items="${requestScope.services}" var="service">
                                <li class="service-option" data-address="${service.serviceID}" data-price="${service.serviceMoney}">${service.serviceName}</li>
                                </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="bookingfield">
                    <div class="bookingfield-header" >
                        <h3 data-number="3">Appointment Date<span class="text-red-500">*</span></h3>
                        <span class="material-symbols-outlined">arrow_drop_down</span>
                    </div>
                    <div class="bookingfield-content">
                        <div id="calendar"></div>
                    </div>
                </div>
                <div class="bookingfield">
                    <div class="bookingfield-header" >
                        <h3 data-number="4">Time Slot<span class="text-red-500">*</span></h3>
                        <span class="material-symbols-outlined">arrow_drop_down</span>
                    </div>
                    <div class="bookingfield-content">
                        <ul id="timeslot-list">
                            <c:forEach items="${requestScope.timeslots}" var="timeslot">
                                <li class="timeslot-option" id='timeslotCheck' data-address="${timeslot.slotID}" >${timeslot.timePeriod}</li>
                                </c:forEach>
                        </ul>
                    </div>
                </div>
                <div class="bookingfield">
                    <div class="bookingfield-header" >
                        <h3 data-number="5">Doctor <p>(optional)</p></h3>
                        <span class="material-symbols-outlined">arrow_drop_down</span>
                    </div>
                    <div class="bookingfield-content">
                        <ul id="doctor-list">
                            <c:forEach items="${requestScope.doctors}" var="doctor">
                                <li class="doctor-option " data-address="${doctor.accountID}">${doctor.fullName}</li>
                                </c:forEach>
                        </ul>
                    </div>
                </div>
            </div>
            <!-- FORM SUBMIT BOOKING -->
            <div class="card">
                <h1 style="font-size: 24px;">Booking Information</h1>
                <p style="font-size: 11px; font-style: italic; margin: 0;"> <span class="text-red-500">*</span>Please make sure you have completely updated your personal information. </p>
                <hr>
                <form action="BookingServlet" method="post">

                    <div class="booking-form">
                        <label for="fullName">Full Name</label>
                        <input type="text" name="fullName" value="${account.fullName}" required readonly>
                    </div>
                    <div class="booking-form">
                        <label for="phone">Phone</label>
                        <input type="text" name="phone" value="${account.phone.trim()}" required readonly>
                    </div>
                    <div class="booking-form">
                        <label for="dob">Date of Birth</label>
                        <input type="text" name="dob" value="${account.dob}" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="email">Email</label>
                        <input type="text" name="email" value="${account.email}" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="address">Address</label>
                        <input type="text" name="address" value="${account.address}" required readonly>
                    </div>

                    <hr>

                    <div class="booking-form">
                        <label for="clinic">Clinic</label>
                        <input type="text" name="clinic" id="clinic-input" class="input-field-1" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="clinic-address">Clinic Address</label>
                        <input type="text" name="clinic-address" id="clinicAddress-input" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="service">Service</label>
                        <input type="text" name="service" id="service-input" class="input-field-2" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="date">Date</label>
                        <input type="text" name="date" id="date-input" class="input-field-4" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="time">Time</label>
                        <input type="text" name="timeslot" id="timeslot-input" class="input-field-5" required readonly>
                    </div>


                    <div class="booking-form">
                        <label for="doctor">Doctor</label>
                        <input type="text" name="doctor" id="doctor-input" class="input-field-6" readonly>
                    </div>

                    <input type="hidden" name="action" value="create">
                    <input type="hidden" name="accountID" value="${account.accountID}">
                    <input type="hidden" name="slotID" id="slotID-input">
                    <input type="hidden" name="dentistID" id="doctorID-input">
                    <input type="hidden" name="serviceID" id="serviceID-input">
                    <input type="hidden" name="clinicID" id="clinicID-input">

                    <hr>
                    <div class="booking-form">
                        <label for="price">Price</label>
                        <input type="text" name="price" id="price-input" class="input-field-3" style="font-style: italic;" required readonly>
                    </div>
                    <div class="booking-form">
                        <input type="submit" value="Confirm Booking" class="confirm-booking-button">
                    </div>

                </form>
            </div>
        </div>

        <!-- ALERT -->
        <div id="customAlertModal" class="custom-alert-modal">
            <div class="custom-alert-content">  
                <span class="custom-alert-close">&times;</span>
                <p class="custom-alert-message"></p>
                <button class="custom-alert-button">OK</button>
            </div>
        </div>

        <!-- CONFIRM -->
        <div id="customConfirmModal" class="confirm-modal">
            <div class="confirm-dialog">
                <h2>Confirmation</h2>
                <p class="confirm-message"></p>
                <div class="confirm-buttons">
                    <button class="button-confirm">Confirm</button>
                    <button class="button-cancel">Cancel</button>
                </div>
            </div>
        </div>

        <footer class="ftco-footer ftco-bg-dark ftco-section" style="background-color: white;">
            <div class="container">
                <div class="row mb-5">
                    <div class="col-md-6">
                        <div class="ftco-footer-widget mb-4">
                            <h2 class="ftco-heading-2" style="color: black">DentaCare.</h2>
                            <p style="color: black">Far far away, behind the word mountains, far from the countries Vokalia and Consonantia, there live the blind texts.</p>
                        </div>
                    </div>
                    <div class="col-md-6">
                        <div class="ftco-footer-widget mb-4 ml-md-5">
                            <h2 class="ftco-heading-2" style="color: black">Quick Links</h2>
                            <ul class="list-unstyled">
                                <li>
                                    <a href="#" class="py-2 d-block" style="color: black">Features</a>
                                </li>
                                <li>
                                    <a href="#" class="py-2 d-block" style="color: black">Blog</a>
                                </li>
                            </ul>
                        </div>
                    </div>
                </div>
                <div class="row">
                    <div class="col-md-12 text-center">
                        <p style="color: black">
                            Copyright &copy;
                            <script>document.write(new Date().getFullYear());</script>
                            FPT University Campus Ho Chi Minh
                        </p>
                    </div>
                </div>
            </div>
        </footer>
        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen"></div>
        <script src="js/scriptBooking.js"></script>
        <script>
            function menuToggle() {
                const toggleMenu = document.querySelector(".menu");
                toggleMenu.classList.toggle("active");
            }


            //Limit attempt of booking
            document.addEventListener('DOMContentLoaded', function () {
                const timeslotList = document.getElementById('timeslot-list');

                const clinicLimit = "${requestScope.clinicLimit}";
                const slotLimit = "${requestScope.slotLimit}";
                const dayLimit = "${requestScope.dayLimit}";

                function updateTimeslotAttributes() {

                    timeslotList.querySelectorAll('.timeslot-option').forEach(function (option) {
                        const timeslotDate = option.getAttribute('data-date');
                        const timeslotClinic = option.getAttribute('data-clinic');
                        const timeslotID = option.getAttribute('data-address');

                        option.classList.remove('disabled');

                        if (dayLimit.includes(timeslotDate) && clinicLimit.includes(timeslotClinic) && slotLimit.includes(timeslotID)) {
                            option.classList.add('disabled');
                        }

                    });
                }

                document.querySelectorAll('.future').forEach(function (option) {
                    option.addEventListener('click', updateTimeslotAttributes);
                });


                document.querySelectorAll('.clinic-option').forEach(function (option) {
                    option.addEventListener('click', updateTimeslotAttributes);
                });
                // Initial check
                updateTimeslotAttributes();
            });

            document.addEventListener('DOMContentLoaded', function () {
                const workingList = "${requestScope.listDenSchedule}";
                const doctorList = document.getElementById('doctor-list');

                function updateDentistOption() {
                    doctorList.querySelectorAll('.doctor-option').forEach(function (option) {
                        const doctorDate = option.getAttribute('data-date');
                        const doctorClinic = option.getAttribute('data-clinic');
                        const doctorID = option.getAttribute('data-address');


                        option.classList.add('nothing');

                        if (workingList.includes(doctorDate) && workingList.includes(doctorClinic) && workingList.includes(doctorID)) {
                            option.classList.remove('nothing');
                        }

                    });
                }

                document.querySelectorAll('.future').forEach(function (option) {
                    option.addEventListener('click', updateDentistOption);
                });


                document.querySelectorAll('.clinic-option').forEach(function (option) {
                    option.addEventListener('click', updateDentistOption);
                });
                // Initial check
                updateDentistOption();
            });

            document.addEventListener("DOMContentLoaded", function () {
                const alertBox = document.querySelector(".alert-error.sec");
                if (alertBox && alertBox.textContent.trim()) {
                    alertBox.style.display = "block"; // Show the alert if there's an error message
                    alertBox.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                    setTimeout(function () {
                        alertBox.classList.remove("show");
                        setTimeout(function () {
                            alertBox.style.display = "none"; // Hide the alert after the fade-out animation
                        }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                    }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                }

            });

        </script>
        
    </body>
</html>


