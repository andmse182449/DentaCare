<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Doctors</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">

        <link rel="stylesheet" href="css/open-iconic-bootstrap.min.css">
        <link rel="stylesheet" href="css/animate.css">

        <link rel="stylesheet" href="css/owl.carousel.min.css">
        <link rel="stylesheet" href="css/owl.theme.default.min.css">
        <link rel="stylesheet" href="css/magnific-popup.css">

        <link rel="stylesheet" href="css/aos.css">

        <link rel="stylesheet" href="css/ionicons.min.css">

        <link rel="stylesheet" href="css/bootstrap-datepicker.css">
        <link rel="stylesheet" href="css/jquery.timepicker.css">


        <link rel="stylesheet" href="css/flaticon.css">
        <link rel="stylesheet" href="css/icomoon.css">
        <link rel="stylesheet" href="css/style.css">

        <link rel="stylesheet" href="css/drop-down.css">
        <link rel="stylesheet" href="css/main-search.css">
        <link rel="stylesheet" href="css/forDoc.css">
    </head>
    <style>
        body {
            font-family: Arial, sans-serif;
            margin: 0;
            padding: 0;
            background-color: #f0f0f0;
        }
        .header {
            background-color: #ffffff;
            padding: 20px;
            text-align: center;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .clinic-image {
            border-radius: 8px;
            width: 500px;
            max-height: 500px;
            object-fit: cover;
        }
        .info-container {
            background-color: #ffffff;
            margin: 20px;
            padding: 20px;
            border-radius: 8px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.1);
        }
        .button {
            background-color: #007bff;
            color: white;
            padding: 10px 20px;
            text-decoration: none;
            border-radius: 5px;
            display: inline-block;
            margin-top: 10px;
        }
        .info-item {
            display: flex;
            align-items: center;
            margin-bottom: 10px;
            color: #666;
        }
        .info-item svg {
            width: 20px;
            height: 20px;
            margin-right: 10px;
            flex-shrink: 0;
        }
    </style>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="LoginChangePage?action=home">Denta<span>Care</span></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a href="LoginChangePage?action=home" class="nav-link">Home</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=service" class="nav-link">Service</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=doctor" class="nav-link">Doctor</a></li>
                        <li class="nav-item active"><a href="#" class="nav-link">Clinic</a></li>
                            <c:set var="account" value="${sessionScope.account}"/>
                            <c:choose>
                                <c:when test="${account == null}">
                                <li class="nav-item">
                                    <div href="#" class="nav-link">
                                        <div class="action">
                                            <div class="" onclick="menuToggle();">
                                                <a style="cursor: pointer;">For Employees</a>
                                            </div>
                                            <div class="menu">
                                                <ul>
                                                    <li>
                                                        <i class="fa fa-chevron-right"></i><a href="login-dentist.jsp">Login for Dentist</a>
                                                    </li>
                                                    <li>
                                                        <i class="fa fa-chevron-right"></i><a href="login-staff.jsp">Login for Staff</a>
                                                    </li>
                                                    <li>
                                                        <i class="fa fa-chevron-right"></i><a href="login3">Login for Clinic Owner</a>
                                                    </li>
                                                </ul>
                                            </div>
                                        </div>
                                    </div>
                                </li>
                                <li class="nav-item cta"><a href="login.jsp" class="nav-link show-popup" data-target="#modalRequest">Log in</a></li>
                                </c:when>
                                <c:otherwise>
                                <li class="nav-item" style="margin-top: 3px; display: ">
                                    <div class="action">
                                        <div onclick="menuToggle();">
                                            <a href="#" class="nav-link" style="color:white; padding: 8px 18px;">${account.getUserName()}</a>
                                        </div>
                                        <script>
                                            function menuToggle() {
                                                const toggleMenu = document.querySelector(".menu");
                                                toggleMenu.classList.toggle("active");
                                            }
                                        </script>
                                        <div class="menu">
                                            <ul>
                                                <li>
                                                    <img src="images/user.png" /><a href="ProfileServlet">Profile</a>
                                                </li>
                                                <li>
                                                    <img src="images/schedule.png"/><a href="ExamScheduleServlet">Examination Schedule</a>
                                                </li>
                                                <li>
                                                    <img src="images/history.png" /><a href="HistoryServlet">Booking History</a>
                                                </li>
                                                <li>
                                                    <img src="images/log-out.png" /><a href="SignOutServlet">Logout</a>
                                                </li>
                                            </ul>
                                        </div>
                                    </div>
                                </li>
                            </c:otherwise>
                        </c:choose>
                        <script>
                            function menuToggle() {
                                const toggleMenu = document.querySelector(".menu");
                                toggleMenu.classList.toggle("active");
                            }
                        </script>
                    </ul>
                </div>
            </div>
        </nav>
        <!-- END nav -->

        <section class="home-slider owl-carousel">
            <div class="slider-item bread-item" style="background-image: url('images/bg_1.jpg');" data-stellar-background-ratio="0.5">
                <div class="overlay"></div>
                <div class="container" data-scrollax-parent="true">
                    <div class="row slider-text align-items-end">
                        <div class="col-md-7 col-sm-12 ftco-animate mb-5">
                            <p class="breadcrumbs" data-scrollax=" properties: { translateY: '70%', opacity: 1.6}"><span class="mr-2"><a href="LoginChangePage?action=home">Home</a></span> <span>Clinic</span></p>
                            <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">Decent Facilities</h1>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <c:set var="results" value="${requestScope.numberOfResults}"/>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center mb-5 pb-5">
                    <div class="col-md-7 text-center heading-section ftco-animate">
                        <h2 class="mb-3">DentaCare's Clinic Units</h2>
                        <p>As of now, Parkway has ${results} clinics in prime locations in Ho Chi Minh City and neighboring provinces. Find the nearest clinic to enjoy and experience top-notch services.</p>
                    </div>
                </div>
                <div class="find-section">
                    <div class="right-container">
                        <div class="booking-section" id="serviceDetails" style="display: block;">
                            <div class="doctor-cards-container" style="display: flex; gap: 15rem">
                                <c:forEach items="${requestScope.CLINIC}" var="p">
                                    <div>

                                        <img src="images/clinic1.jpg" alt="Hình ảnh phòng khám nha khoa" class="clinic-image">

                                        <div class="info-container">
                                            <h2>${p.getClinicName()}</h2>
                                            <div class="info-item">
                                                <svg width="24px" height="24px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M12 6H12.01M9 20L3 17V4L5 5M9 20L15 17M9 20V14M15 17L21 20V7L19 6M15 17V14M15 6.2C15 7.96731 13.5 9.4 12 11C10.5 9.4 9 7.96731 9 6.2C9 4.43269 10.3431 3 12 3C13.6569 3 15 4.43269 15 6.2Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"></path>
                                                </svg>
                                                <span>${p.getClinicAddress()}</span>
                                            </div>
                                            <div class="info-item">
                                                <svg width="24px" height="24px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M12 6V12L16 14M12 22C17.5228 22 22 17.5228 22 12C22 6.47715 17.5228 2 12 2C6.47715 2 2 6.47715 2 12C2 17.5228 6.47715 22 12 22Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                </svg>
                                                <span>Opening Hours: 8:00 - 20:00</span>
                                            </div>
                                            <div class="info-item">
                                                <svg width="24px" height="24px" viewBox="0 0 24 24" fill="none" xmlns="http://www.w3.org/2000/svg">
                                                <path d="M3 5.5C3 14.0604 9.93959 21 18.5 21C18.8862 21 19.2691 20.9859 19.6483 20.9581C20.0834 20.9262 20.3009 20.9103 20.499 20.7963C20.663 20.7019 20.8185 20.5345 20.9007 20.364C21 20.1582 21 19.9181 21 19.438V16.6207C21 16.2169 21 16.015 20.9335 15.842C20.8749 15.6891 20.7795 15.553 20.6559 15.4456C20.516 15.324 20.3262 15.255 19.9468 15.117L16.74 13.9509C16.2985 13.7904 16.0777 13.7101 15.8683 13.7237C15.6836 13.7357 15.5059 13.7988 15.3549 13.9058C15.1837 14.0271 15.0629 14.2285 14.8212 14.6314L14 16C11.3501 14.7999 9.2019 12.6489 8 10L9.36863 9.17882C9.77145 8.93713 9.97286 8.81628 10.0942 8.64506C10.2012 8.49408 10.2643 8.31637 10.2763 8.1317C10.2899 7.92227 10.2096 7.70153 10.0491 7.26005L8.88299 4.05321C8.745 3.67376 8.67601 3.48403 8.55442 3.3441C8.44701 3.22049 8.31089 3.12515 8.15802 3.06645C7.98496 3 7.78308 3 7.37932 3H4.56201C4.08188 3 3.84181 3 3.63598 3.09925C3.4655 3.18146 3.29814 3.33701 3.2037 3.50103C3.08968 3.69907 3.07375 3.91654 3.04189 4.35147C3.01413 4.73067 3 5.11354 3 5.5Z" stroke="#000000" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"/>
                                                </svg>
                                                <span>Contact: ${p.getHotline()}</span>
                                            </div>
                                            <div style="display: ${sessionScope.account == null ? 'none' : ''}">
                                                <a href="BookingServlet" class="button">Book Now</a>
                                            </div>
                                        </div>

                                    </div>

                                </c:forEach>
                            </div>
                        </div>
                        <script>
                            const searchBar = document.getElementById('searchBar');
                            const resultsCount = document.getElementById('resultsCount');
                            const resultsList = document.getElementById('resultsList');

                            searchBar.addEventListener('input', function () {
                                const filter = this.value.toLowerCase();
                                const items = document.querySelectorAll('.scroll-item');
                                let visibleCount = 0;
                                resultsList.innerHTML = '';

                                items.forEach(item => {
                                    const text = item.textContent.toLowerCase();
                                    if (text.includes(filter)) {
                                        item.style.display = '';
                                        visibleCount++;
                                        const listItem = document.createElement('li');
                                        listItem.textContent = item.textContent;
                                        listItem.className = 'result-item';
                                    } else {
                                        item.style.display = 'none';
                                    }
                                });

                                resultsCount.textContent = visibleCount;
                            });


                            document.querySelectorAll('.scroll-item').forEach(item => {
                                item.addEventListener('click', function () {
                                    document.querySelectorAll('.circle').forEach(circle => {
                                        circle.classList.remove('active');
                                    });
                                    this.querySelector('.circle').classList.add('active');

                                    // Get service details from data attribute
                                    const serviceName = this.getAttribute('data-servicename');
                                    const serviceMoney = this.getAttribute('data-servicemoney');

                                    // Set service details in the right container
                                    document.getElementById('serviceName').value = serviceName;
                                    document.getElementById('serviceMoney').value = serviceMoney;

                                    // Optionally, you can handle booking functionality here
                                    // For example, by showing a modal or redirecting to a booking page

                                    const selectedItemText = this.textContent.trim();
                                    const currentUrl = new URL(window.location.href);
                                    const selectedParam = currentUrl.searchParams.get('selected');

                                    if (selectedParam) {
                                        // Remove the previous selection from the URL
                                        currentUrl.searchParams.delete('selected');
                                    }

                                    if (selectedItemText) {
                                        // Append the new selection to the URL without encoding spaces
                                        currentUrl.searchParams.append('selected', decodeURIComponent(selectedItemText));
                                    }

                                    const newUrl = currentUrl.toString();
                                    window.history.pushState({}, '', newUrl);
                                });
                            });
                        </script>
                    </div>
                </div>
        </section>


        <section class="ftco-section ftco-counter img" id="section-counter" style="background-image: url(images/bg_1.jpg);" data-stellar-background-ratio="0.5">
            <div class="container">
                <div class="row d-flex align-items-center">
                    <div class="col-md-3 aside-stretch py-5">
                        <div class=" heading-section heading-section-white ftco-animate pr-md-4">
                            <h2 class="mb-3">Achievements</h2>
                            <p>A small river named Duden flows by their place and supplies it with the necessary regelialia.</p>
                        </div>
                    </div>
                    <div class="col-md-9 py-5 pl-md-5">
                        <div class="row">
                            <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
                                <div class="block-18">
                                    <div class="text">
                                        <strong class="number" data-number="14">0</strong>
                                        <span>Years of Experience</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
                                <div class="block-18">
                                    <div class="text">
                                        <strong class="number" data-number="4500">0</strong>
                                        <span>Qualified Dentist</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
                                <div class="block-18">
                                    <div class="text">
                                        <strong class="number" data-number="4200">0</strong>
                                        <span>Happy Smiling Customer</span>
                                    </div>
                                </div>
                            </div>
                            <div class="col-md-3 d-flex justify-content-center counter-wrap ftco-animate">
                                <div class="block-18">
                                    <div class="text">
                                        <strong class="number" data-number="320">0</strong>
                                        <span>Patients Per Year</span>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        <%@include file="/footer.jsp" %>
        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>

        <!-- Modal -->
        <div class="modal fade" id="modalRequest" tabindex="-1" role="dialog" aria-labelledby="modalRequestLabel" aria-hidden="true">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <h5 class="modal-title" id="modalRequestLabel">Make an Appointment</h5>
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                            <span aria-hidden="true">&times;</span>
                        </button>
                    </div>
                    <div class="modal-body">
                        <form action="#">
                            <div class="form-group">
                                <!-- <label for="appointment_name" class="text-black">Full Name</label> -->
                                <input type="text" class="form-control" id="appointment_name" placeholder="Full Name">
                            </div>
                            <div class="form-group">
                                <!-- <label for="appointment_email" class="text-black">Email</label> -->
                                <input type="text" class="form-control" id="appointment_email" placeholder="Email">
                            </div>
                            <div class="row">
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <!-- <label for="appointment_date" class="text-black">Date</label> -->
                                        <input type="text" class="form-control appointment_date" placeholder="Date">
                                    </div>    
                                </div>
                                <div class="col-md-6">
                                    <div class="form-group">
                                        <!-- <label for="appointment_time" class="text-black">Time</label> -->
                                        <input type="text" class="form-control appointment_time" placeholder="Time">
                                    </div>
                                </div>
                            </div>


                            <div class="form-group">
                                <!-- <label for="appointment_message" class="text-black">Message</label> -->
                                <textarea name="" id="appointment_message" class="form-control" cols="30" rows="10" placeholder="Message"></textarea>
                            </div>
                            <div class="form-group">
                                <input type="submit" value="Make an Appointment" class="btn btn-primary">
                            </div>
                        </form>
                    </div>

                </div>
            </div>
        </div>



        <script src="js/jquery.min.js"></script>
        <script src="js/jquery-migrate-3.0.1.min.js"></script>
        <script src="js/popper.min.js"></script>
        <script src="js/bootstrap.min.js"></script>
        <script src="js/jquery.easing.1.3.js"></script>
        <script src="js/jquery.waypoints.min.js"></script>
        <script src="js/jquery.stellar.min.js"></script>
        <script src="js/owl.carousel.min.js"></script>
        <script src="js/jquery.magnific-popup.min.js"></script>
        <script src="js/aos.js"></script>
        <script src="js/jquery.animateNumber.min.js"></script>
        <script src="js/bootstrap-datepicker.js"></script>
        <script src="js/jquery.timepicker.min.js"></script>
        <script src="js/scrollax.min.js"></script>
        <script src="https://maps.googleapis.com/maps/api/js?key=AIzaSyBVWaKrjvy3MaE7SQ74_uJiULgl1JY0H2s&sensor=false"></script>
        <script src="js/google-map.js"></script>
        <script src="js/main.js"></script>

    </body>
</html>