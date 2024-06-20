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
        /* Container for flexbox layout */
        .contentDen {
            display: flex;              /* Enable flexbox */
            flex-wrap: wrap;            /* Allow items to wrap to the next line */
            gap: 2rem;                  /* Space between columns and rows */
            justify-content: center;    /* Center the columns horizontally */
            margin: 0 auto;             /* Center the container itself */
            width: 100%;                /* Adjust the width as needed */
        }

        /* Pagination styling */
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

        /* Doctor card styling */
        .doctor-card {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 20px;
            padding: 20px;
            border-radius: 12px;
            box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);
            background-color: #fff;
            max-width: 800px;
            margin: auto;
            align-items: center;
        }

        /* Doctor info section */
        .doctor-info {
            display: flex;
            flex-direction: column;
            justify-content: center;
        }

        .doctor-info h3 {
            margin: 0;
            color: #6c757d;
            font-size: 18px;
        }

        .doctor-info h2 {
            margin: 5px 0;
            color: #343a40;
            font-size: 24px;
        }

        /* List of doctor details */
        .doctor-details {
            list-style: none;
            padding: 0;
            margin: 20px 0;
            color: #6c757d;
        }

        .doctor-details li {
            margin-bottom: 10px;
        }

        /* Button container */
        .doctor-buttons {
            display: flex;
            gap: 10px;
        }

        /* General button styling */
        .btn-detail, .btn-appointment {
            padding: 10px 20px;
            border: none;
            border-radius: 8px;
            cursor: pointer;
            /* font-size: 16px; */
        }

        /* Specific styles for btn-detail */
        .btn-detail {
            font-size: 16px;
            background: linear-gradient(90deg, #e7f1ff 50%, #1855b8 50%); /* Initial gradient background */
            color: #007bff; /* Initial text color */
            background-size: 200% 100%; /* Background size larger than button */
            background-position: 0%; /* Initial background position, starting from the left */
            transition: background-position 0.4s ease, color 0.3s ease; /* Smooth transition */
        }

        .btn-detail:hover {
            background-position: 100% 0%; /* Move background to show the hover color */
            color: white; /* Change text color to white on hover */
        }

        /* Specific styles for btn-appointment */
        .btn-appointment {
            font-size: 16px;
            background-color: #007bff; /* Initial background color */
            color: white; /* Text color */
            transition: background-color 0.3s ease; /* Smooth transition */
        }

        /* Styling for doctor image */
        .doctor-image {
            background-size: cover;
            background-position: center;
            width: 200px;
            height: 200px;
            border-radius: 50%;
            margin-left: auto;
        }

        /* Container for doctor cards */
        .doctor-cards-container {
            display: grid;
            grid-template-columns: 1fr 1fr; /* Two columns */
            gap: 20px; /* Space between the cards */
            padding: 20px;
        }

    </style>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="#">Denta<span>Care</span></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item"><a href="LoginChangePage?action=home" class="nav-link">Home</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=service" class="nav-link">Services</a></li>
                        <li class="nav-item active"><a href="#" class="nav-link">Doctors</a></li>
                        <li class="nav-item"><a href="BookingServlet" class="nav-link">Book Appointment</a></li>
                        <!--                        <li class="nav-item"><a href="contact.html" class="nav-link">Contact</a></li>-->
                        <li class="nav-item" style="margin-top: 3px;">
                            <c:set var="account" value="${sessionScope.account}"/>

                            <div class="action">
                                <div  onclick="menuToggle();">
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
                            <p class="breadcrumbs" data-scrollax=" properties: { translateY: '70%', opacity: 1.6}"><span class="mr-2"><a href="LoginChangePage?action=home">Home</a></span> <span>Services</span></p>
                            <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">Well Experienced Doctors</h1>
                        </div>
                    </div>
                </div>
            </div>
        </section>

        <section class="ftco-section">
            <div class="container">
                <div class="row justify-content-center mb-5 pb-5">
                    <div class="col-md-7 text-center heading-section ftco-animate">
                        <h2 class="mb-3">Meet Our Experience Dentist</h2>
                        <p>DentaCare's team places a strong emphasis on adhering to procedures, conducting professional consultations, and listening to the needs of their patients.</p>
                    </div>
                </div>
                <div class="find-section">
                    <c:set var="services"  value="${requestScope.SERVICE}"/>
                    <c:set var="show"  value="${requestScope.show}"/>

                    <div class="left-container">
                        <form action="SearchServlet">
                            <div class="search-container">
                                <input type="text" name="searchValue" id="searchBar" placeholder="Type in doctor's name" value="${requestScope.searchValue}">
                            </div>
                            <div class="btn-box" style="margin-top: 20px">
                                <button class="btn btn-three" type="submit">Find doctors</button>
                            </div>
                        </form>
                    </div>

                    <c:set var="results" value="${requestScope.numberOfResults}"/>
                    <div class="right-container">

                        <style>
                            #serviceID, #serviceName, #serviceMoney {
                                border: none;
                                background: transparent;
                                outline: none;
                                padding: 0;
                                font-size: 16px;
                                color: #333;
                            }
                        </style>
                        <ul id="resultsList" class="results"></ul>

                        <div class="founded" style="display: ${requestScope.founded}">
                            <img src="images/no-results.jpg" />
                            <p>${requestScope.noRes}</p>
                        </div>
                        <div class="booking-section" id="serviceDetails" style="display: ${show};">
                            <p style="
                               font-size: 20px;
                               ">Find <span><b>${results}</b></span> results</p>


                            <div class="doctor-cards-container">
                                <c:forEach items="${requestScope.dentistList}" var="p">
                                    <div class="doctor-card">
                                        <div class="doctor-info">
                                            <h3>Doctor</h3>
                                            <h2>${p.getFullName()}</h2>
                                            <ul class="doctor-details">
                                                <li>Tốt nghiệp Bác sĩ Răng Hàm Mặt – Đại học y dược Huế</li>
                                                <li>Chứng chỉ hành nghề 54 tháng</li>
                                                <li>Chứng chỉ phẫu thuật nhổ răng khôn lệch – Chứng chỉ đào tạo liên tục Đại học Y dược HCM</li>
                                                <li>Chứng chỉ Kiểm soát nhiễm khuẩn trong nha khoa – Bệnh viện răng hàm mặt Trung Ương</li>
                                                <li>Chứng chỉ cấy ghép nha khoa – Bệnh viện răng hàm mặt Trung Ương</li>
                                            </ul>
                                            <div class="doctor-buttons">
                                                <button class="btn-detail">Watch in details</button>
                                                <button class="btn-appointment">Book</button>
                                            </div>
                                        </div>
                                        <div class="doctor-image" style="background-image: url('images/person_5.jpg');"></div>
                                    </div>
                                </c:forEach>
                            </div>

                            <form action="#">
                                <c:set var="page" value="${requestScope.page}"/>
                                <div class="pagination">
                                    <c:forEach begin="${1}" end="${requestScope.num}" var="i">
                                        <a class="${i==page ? "active" : ""}" href="SearchServlet?searchValue=${requestScope.searchValue}&page=${i}">${i}</a>
                                    </c:forEach>
                                </div>
                            </form>
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