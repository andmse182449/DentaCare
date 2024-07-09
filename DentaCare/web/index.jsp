<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<link rel="icon" href="images/logo_dentist.jpg" type="image/png">
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>DentaCare</title>
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">

        <link href="css/drop-down.css" rel="stylesheet"/>
        <link href="css/drop-down1.css" rel="stylesheet"/>

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
        <style>
            .alert {
                position: fixed;
                top: 100px; /* Adjust this value to position the alert higher or lower */
                left: 50%;
                transform: translateX(-50%); /* Center the alert horizontally */
                background-color: #f44336;
                color: white;
                padding: 10px;
                border-radius: 5px;
                opacity: 0;
                transition: opacity 0.5s ease-out;
                display: none;
                z-index: 1000; /* Ensure the alert appears above other elements */
            }

            .alert.show {
                display: block;
                opacity: 1;
            }
        </style>
    </head>

    <body>
        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="#">Denta<span>Care</span></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <div class="alert sec">${requestScope.error}</div>
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a href="#" class="nav-link">Home</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=service" class="nav-link">Service</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=doctor" class="nav-link">Doctor</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=clinic" class="nav-link">Clinic</a></li>
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
                                                <i class="fa fa-chevron-right"></i><a href="login-co.jsp">Login for Clinic Owner</a>
                                            </li>
                                        </ul>
                                    </div>
                                </div>
                            </div>
                        </li>
                        <li class="nav-item cta"><a href="login.jsp" class="nav-link show-popup" data-target="#modalRequest">Log in</a></li>
                    </ul>
                </div>
            </div>
        </nav>
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

        <script>
            document.addEventListener("DOMContentLoaded", function () {
                const alertBox2 = document.querySelector(".alert.sec");
                if (alertBox2 && alertBox2.textContent.trim()) {
                    alertBox2.style.display = "block"; // Show the alert if there's an error message
                    alertBox2.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                    setTimeout(function () {
                        alertBox2.classList.remove("show");
                        setTimeout(function () {
                            alertBox2.style.display = "none"; // Hide the alert after the fade-out animation
                        }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                    }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                }
            });
            function menuToggle() {
                const toggleMenu = document.querySelector(".menu");
                toggleMenu.classList.toggle("active");
            }
        </script>
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
        <%@include file="/footer.jsp" %>
    </body>
</html>