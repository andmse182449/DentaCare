<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>DentaCare</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">
        <script src="https://unpkg.com/sweetalert/dist/sweetalert.min.js"></script>
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@20..48,100..700,0..1,-50..200" />

        <link href="css/drop-down.css" rel="stylesheet"/>

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
        <link rel="stylesheet" href="css/readmore.css">
        <link rel="stylesheet" href="css/celebs.css">
        <!--	  -->
    </head>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="#">Denta<span>Care</span></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active"><a href="#" class="nav-link">Home</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=service" class="nav-link">Service</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=doctor" class="nav-link">Doctor</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=clinic" class="nav-link">Clinic</a></li>
                        <li class="nav-item"><a href="BookingServlet" class="nav-link">Booking Appointment</a></li>
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
                    </ul>
                </div>
            </div>
        </nav>
        <!-- END nav -->
        <section class="home-slider owl-carousel">
            <div class="slider-item" style="background-image: url('images/bg_1.jpg');">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row slider-text align-items-center" data-scrollax-parent="true">
                        <div class="col-md-6 col-sm-12 ftco-animate" data-scrollax=" properties: { translateY: '70%' }">
                            <h1 class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Modern Dentistry in a Calm and Relaxed Environment</h1>
                            <p class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">A small river named Duden flows by their place and supplies it with the necessary regelialia.</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="slider-item" style="background-image: url('images/bg_2.jpg');">
                <div class="overlay"></div>
                <div class="container">
                    <div class="row slider-text align-items-center" data-scrollax-parent="true">
                        <div class="col-md-6 col-sm-12 ftco-animate" data-scrollax=" properties: { translateY: '70%' }">
                            <h1 class="mb-4" data-scrollax="properties: { translateY: '30%', opacity: 1.6 }">Modern Achieve Your Desired Perfect Smile</h1>
                            <p class="mb-4">A small river named Duden flows by their place and supplies it with the necessary regelialia.</p>
                        </div>
                    </div>
                </div>
            </div>

        </section>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center mb-5 pb-5">
                    <div class="col-md-7 text-center heading-section ftco-animate">
                        <h2 class="mb-3" style="font-size: xxx-large;">Celebrities using services at DentaCare</h2>
                    </div>
                </div>
            </div>
        </section>
        <div class="container-forpic">
            <div class="card-img big-card">
                <img src="images/sontungmtp.jpg" alt="Trinh Phạm">
                <div class="info">
                    <h3 style="font-style: ">Son Tung-MTP</h3>
                    <p>Singer</p>
                </div>
            </div>
            <div class="card-img">
                <img src="images/hth.jpg" alt="Trần Việt Bảo Hoàng">
                <div class="info">
                    <h3>HieuThuHai</h3>
                    <p>Rapper</p>
                </div>
            </div>
            <div class="card-img">
                <img src="images/mono.jpg" alt="Salim">
                <div class="info">
                    <h3>Mono</h3>
                    <p>Singer</p>
                </div>
            </div>
            <div class="card-img">
                <img src="images/wrens.jpg" alt="Lê Hà Trúc">
                <div class="info">
                    <h3>Wren Evens</h3>
                    <p>Singer</p>
                </div>
            </div>
        </div>
        <c:set var="dentists" value="${requestScope.DENTIST}"/>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center mb-5 pb-5">
                    <div class="col-md-7 text-center heading-section ftco-animate">
                        <h2 class="mb-3">Meet Our Experienced Dentists</h2>
                    </div>
                </div>
                <div class="scrollmenu-container">
                    <ul class="scrollmenu">
                        <c:forEach var="dentist" items="${dentists}" end="9">
                            <li class="service-item" href="#">
                                <div class="d-flex mb-sm-4 ftco-animate">
                                    <div class="staff">
                                        <div class="img mb-4" style="background-image: url(images/${dentist.getImage() != null ? dentist.getImage() : 'person_5.jpg'})"></div>
                                        <div class="info text-center">
                                            <h3><a href="teacher-single.html">${dentist.getFullName()}</a></h3>
                                            <span class="position">Dentist</span>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </section>
        <c:set var="clinics" value="${requestScope.CLINIC}"/>
        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center mb-5 pb-5">
                    <div class="col-md-7 text-center heading-section ftco-animate">
                        <h2 class="mb-3">Book an appointment at the clinic</h2>
                    </div>
                </div>
                <div class="scrollmenu-container">
                    <ul class="scrollmenu">
                        <c:forEach var="clinic" items="${clinics}" end="9">
                            <li class="service-item" href="#">
                                <div class="d-flex mb-sm-4 ftco-animate">
                                    <div class="staff">
                                        <div class="img mb-4" style="background-image: url(images/person_5.jpg);"></div>
                                        <div class="info text-center">
                                            <h3><a href="teacher-single.html">${clinic.getClinicName()}</a></h3>
                                            <span class="position">Dentist</span>
                                        </div>
                                    </div>
                                </div>
                            </li>
                        </c:forEach>
                    </ul>
                </div>
            </div>
        </section>
        <c:set var="services" value="${requestScope.SERVICE}"/>
        <section class="ftco-section ftco-services">
            <div class="container">
                <div class="row justify-content-center mb-5 pb-5">
                    <div class="col-md-7 text-center heading-section ftco-animate">
                        <h2 class="mb-2">Book an appointment by Specialty</h2>
                    </div>
                </div>
                <div class="box">
                    <input type="checkbox" name="readmore" id="readmore">
                    <div class="content">
                        <div class="des">
                            <div class="row">
                                <c:forEach var="service" items="${services}">
                                    <div class="col-md-3 d-flex align-self-stretch ftco-animate">
                                        <div class="media block-6 services d-block text-center">
                                            <div class="icon d-flex justify-content-center align-items-center">
                                                <span class="flaticon-tooth-1"></span>
                                            </div>
                                            <div class="media-body p-2 mt-3">
                                                <h3 class="heading">${service.getServiceName()}</h3>
                                            </div>
                                        </div>      
                                    </div>
                                </c:forEach>
                            </div>
                        </div>
                        <div class="button">
                            <label for="readmore"
                                   data-more="SEE MORE"
                                   data-less="SEE LESS"
                                   ></label>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <%@include file="/footer.jsp" %>



        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen"><svg class="circular" width="48px" height="48px"><circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/><circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/></svg></div>
            <%
                if (request.getAttribute("loginSuccess") != null) {
            %>
        <script>
            swal("Login successfully!", "You have logged in!", "success");
        </script>
        <%
            }
        %>

        <script>
            function menuToggle() {
                const toggleMenu = document.querySelector(".menu");
                toggleMenu.classList.toggle("active");
            }
        </script>
        <!-- END MINH AN-->
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