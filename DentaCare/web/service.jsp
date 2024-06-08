<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
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

        <link rel="stylesheet" href="css/drop-down.css">
        <link rel="stylesheet" href="css/main-search.css">
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
                        <li class="nav-item"><a href="LoginChangePage?action=home" class="nav-link">Home</a></li>
                        <li class="nav-item active"><a href="#" class="nav-link">Services</a></li>
                        <li class="nav-item"><a href="LoginChangePage?action=doctor" class="nav-link">Doctors</a></li>
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
                            <p class="breadcrumbs" data-scrollax=" properties: { translateY: '70%', opacity: 1.6}"><span class="mr-2"><a href="index.jsp">Home</a></span> <span>Services</span></p>
                            <h1 class="mb-3" data-scrollax=" properties: { translateY: '70%', opacity: .9}">See Our Services</h1>
                        </div>
                    </div>
                </div>
            </div>
        </section>
        
        <c:set var="services"  value="${requestScope.SERVICE}"/>

        <section class="">
            <div class="find-section">

                <div class="left-container">
                    <div class="search-container">
                        <input type="text" id="searchBar" placeholder="Search a speciality">

                    </div>
                    <div class="scroll-section" id="scrollSection">
                        <c:forEach var="service" items="${services}">
                            <div class="scroll-item" data-content="" data-serviceid="${service.getServiceID()}" data-servicename="${service.getServiceDescription()}" data-servicemoney="${service.getServiceMoney()}">
                                <div class="circle"></div>
                                ${service.getServiceName()}


                            </div>
                        </c:forEach>
                    </div>
                </div>

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
                    <div class="booking-section" id="serviceDetails">
                        <form action="#">
                            Description: <input type="text" id="serviceName" placeholder="Service Name" readonly>
                            Price: <input type="text" id="serviceMoney" placeholder="Service Money" readonly>
                            <input class="serviceBtn" type="submit" id="bookButton" value="Book Now">
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