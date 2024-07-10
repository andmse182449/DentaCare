<%@ page contentType="text/html" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <title>Services</title>
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
        <link rel="stylesheet" href="css/comment.css">
        <link rel="stylesheet" href="css/drop-down.css">
        <link rel="stylesheet" href="css/services.css">
        <!-- <link rel="stylesheet" href="css/main-search.css"> -->
    </head>
    <style>
        .results-header {
            font-weight: bold;
            margin-bottom: 10px;
        }
        .results {
            list-style: none;
            padding: 0;
        }
        .result-item {
            padding: 5px 0;
        }
        .booking-section {
            margin-top: 20px;
        }
        .booking-section input[type="text"],
        .serviceBtn {
            display: block;
            width: 100%;
            margin-bottom: 10px;
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 4px;
            box-sizing: border-box;
        }
        .serviceBtn {
            background-color: #2f89fc;
            color: white;
            cursor: pointer;
        }
        .serviceBtn:hover {
            background-color: #1e77e0;
        }
        .pagination {
            margin-top: 10px;
            display: inline-block;
            justify-content: center;
        }
        .pagination a {
            color: black;
            font-size: 22px;
            float: left;
            padding: 0px 12px;
            text-decoration: none;
        }
        .pagination a.active {
            border-radius: 20px;
            background-color: #2f89fc !important;
            color: white !important;
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
                        <li class="nav-item active"><a href="#" class="nav-link">Service</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=doctor" class="nav-link">Doctor</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=clinic" class="nav-link">Clinic</a></li>
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
                            <p class="breadcrumbs" data-scrollax=" properties: { translateY: '70%', opacity: 1.6}">
                                <span class="mr-2"><a href="LoginChangePage?action=home">Home</a></span>
                                <span>Services</span>
                            </p>
                            <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">See Our Services</h1>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <c:set var="services"  value="${requestScope.SERVICE}"/>

        <div class="services-grid">
            <c:forEach var="service" items="${services}">
                <div class="service-card">
                    <img src="images/nieng2.jpg" alt="Invisalign Teen Comp">
                    <h3>${service.getServiceName()}</h3>
                    <div class="buttons" style="display: ${sessionScope.account == null ? 'none' : ''}">
                        <a href="BookingServlet" class="btn-appointment">Book Now</a>
                    </div>
                </div>
            </c:forEach>
        </div>




        <!-- Comment Section -->
        <c:set var="comments" value="${requestScope.FEEDBACK}"/>
        <c:set var="results" value="${requestScope.numberOfResults}"/>
        <div class="containerComment">
            <div class="head">
                <h1>Post a Comment</h1>
            </div>
            <div><span id="comment">${results}</span> Comments</div>
            <div class="comments">
                <div class="parent">
                    <c:forEach var="comment" items="${comments}">
                        <div class="user-info" style="display: flex;gap:1rem">
                            <img style="width:40px; height:40px;border-radius: 50%;" src="images/user1.png" alt="User">
                            <div class="message" style="border: 1px solid grey; border-radius: 10px; padding: 10px">
                                <h4 style="text-align: justify;">${comment.getFullName()}</h4>
                                <p style="margin: 0; word-break: break-all; overflow-wrap: break-word;">${comment.getFeedbackContent()}</p>
                            </div>
                        </div>
                        <span class="date" style="margin-left: 60px">${comment.getFeedbackDay()}</span>
                    </c:forEach>
                </div>
            </div>
            <form action="#">
                <c:set var="page" value="${requestScope.page}"/>
                <div class="pagination">
                    <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                        <a class="${i==page ? "active" : ""}" href="LoginChangePage?action=service&page=${i}">${i}</a>
                    </c:forEach>
                </div>
            </form>
        </div>

        <%@ include file="/footer.jsp" %>

        <!-- loader -->
        <div id="ftco-loader" class="show fullscreen">
            <svg class="circular" width="48px" height="48px">
            <circle class="path-bg" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke="#eeeeee"/>
            <circle class="path" cx="24" cy="24" r="22" fill="none" stroke-width="4" stroke-miterlimit="10" stroke="#F96D00"/>
            </svg>
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
