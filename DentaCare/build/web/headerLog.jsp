<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">

        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">
        <link
            rel="stylesheet"
            href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css"
            integrity="sha512-SfTiTlX6kk+qitfevl/7LibUOeJWlt9rbyDn92a1DqWOw9vWG2MFoays0sgObmWazO5BQPiFucnnEAjpAB+/Sw=="
            crossorigin="anonymous"
            />
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
    </head>
    <body>
        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="index.jsp" style="color: black">Denta<span>Care</span></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active"><a href="userWeb-page.jsp" class="nav-link" style="color: black">Home</a></li>
                        <li class="nav-item"><a href="about.html" class="nav-link" style="color: black">About</a></li>
                        <li class="nav-item"><a href="services.html" class="nav-link" style="color: black">Services</a></li>
                        <li class="nav-item"><a href="doctors.html" class="nav-link" style="color: black">Doctors</a></li>
                        <li class="nav-item"><a href="blog.html" class="nav-link" style="color: black">Blog</a></li>
                        <li class="nav-item"><a href="contact.html" class="nav-link" style="color: black">Contact</a></li>
                        <li class="nav-item">
                            <c:set var="account" value="${sessionScope.account}"/>
                            <div href="contact.html" class="nav-link" style="color: black">
                                <div class="action">
                                    <div class="" onclick="menuToggle();">
                                        <a href="#" style="color:black">${account.getUserName()}</a>
                                    </div>
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
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </nav>
        <script>
            function menuToggle() {
                const toggleMenu = document.querySelector(".menu");
                toggleMenu.classList.toggle("active");
            }
        </script>
    </body>
</html>
