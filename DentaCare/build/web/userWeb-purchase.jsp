<!DOCTYPE html>
<html lang="en">
    <head>
        <title>DentaCare Purchase</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
        <link href="https://fonts.googleapis.com/css?family=Open+Sans:300,400,500,600,700" rel="stylesheet">
        <link rel="stylesheet" href="css/drop-down.css">
        <link rel="stylesheet" href="css/styleBooking.css">
        <link rel="stylesheet" href="css/stylePurchase.css">
        <link rel="stylesheet" href="css/styleCalendar.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="https://fonts.googleapis.com/css2?family=Material+Symbols+Outlined:opsz,wght,FILL,GRAD@24,400,0,0">
        <script src="assets/jquery-1.11.3.min.js"></script>
    </head>
    <body>
    <c:set var="account" value="${sessionScope.account}"/>

    <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light scrolled sleep awake">
        <div class="container">
            <a class="navbar-brand" href="#">Denta<span>Care</span></a>
            <div class="navbar-collapse" id="ftco-nav">
                <ul class="navbar-nav ml-auto">
                    <li class="nav-item"><a href="LoginChangePage?action=home" class="nav-link">Home</a></li>
                    <li class="nav-item"><a href="LoginChangePage?action=service" class="nav-link">Services</a></li>
                    <li class="nav-item"><a href="LoginChangePage?action=doctor" class="nav-link">Doctors</a></li>
                    <li class="nav-item active"><a href="PurchaseServlet" class="nav-link" style="color: black">Book Appointment</a></li>

                    <div class="action">
                        <div onclick="menuToggle();">
                            <a href="#" class="nav-link" style="color:white; padding: 8px 18px;">${account.userName}</a>
                        </div>
                        <div class="menu">
                            <ul>
                                <li><img src="images/user.png"><a href="ProfileServlet">Profile</a></li>
                                <li><img src="images/schedule.png"><a href="ExamScheduleServlet">Examination Schedule</a></li>
                                <li><img src="images/history.png"><a href="HistoryServlet">Booking History</a></li>
                                <li><img src="images/log-out.png"><a href="SignOutServlet">Logout</a></li>
                            </ul>
                        </div>
                    </div>
                    </li>
                </ul>
            </div>
        </div>
    </nav>
    <!-- MAIN PURCHASE -->
    <div class="main">
        <div class="container">
            <div class="card">
                <h1 style="font-size: 24px;">Purchase Information</h1>
                <p style="font-size: 11px; font-style: italic; margin: 0;"> <span class="text-red-500" style="color: red;">*</span>Please make sure you have completely updated your personal information. </p>
                <hr>
                <form action="PaymentServlet" id="frmCreateOrder" method="post" onsubmit="return submitForm(event);">
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
                        <label for="gender">Gender</label>
                        <input type="text" name="email" value="${account.gender == 'true' ? 'Male' : 'Female'}" required readonly>
                    </div>
                    <hr>    
                    <div class="booking-form">
                        <label for="clinic">Clinic</label>
                        <input type="text" name="clinic" value="${requestScope.clinic}" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="clinic-address">Clinic Address</label>
                        <input type="text" name="clinic-address" value="${requestScope.clinicAddress}" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="service">Service</label>
                        <input type="text" name="service" value="${requestScope.service}" required readonly>
                    </div>



                    <div class="booking-form">
                        <label for="date">Appointment Date</label>
                        <input type="text" name="date" value="${requestScope.appointmentDay}" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="time">Appointment Time</label>
                        <input type="text" name="timeslot" value="${requestScope.timeslot}" required readonly>
                    </div>

                    <div class="booking-form">
                        <label for="price" ">Service Price</label>
                        <input type="text" name="price" value="${requestScope.price}" required readonly>
                    </div>
                    
                    <input type="hidden" name="accountID" value="${account.accountID}">
                    <input type="hidden" name="serviceID" value="${requestScope.serviceID}">
                    <input type="hidden" name="slotID" value="${requestScope.slotID}">
                    <input type="hidden" name="clinicID" value="${requestScope.clinicID}">
                    <input type="hidden" name="action" value="purchase">
                    <hr>

                    <div class="booking-form">
                        <label for="deposti" style="font-size: 16px; font-weight: 800; color: black; font-style: italic;">Deposit</label>
                        <input type="text" name="deposit" id="" class="" value="${requestScope.deposit}" required readonly style="font-style: italic;">
                    </div>
                    <div class="" style="margin: 20px 0;">
                        <input type="radio" checked="true" id="bankCode" name="bankCode" value="">
                        <img src="images/vnpay.png" style="width: 20px; border-radius: 50%"/>
                        <label for="bankCode">VNPAY Payment Gateway</label>
                    </div>
                    <input type="hidden" id="language" name="language" value="vn">
                    <div class="booking-form" style="padding: 0;">
                        <input type="submit" value="Purchase">
                    </div>
                </form>
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
                            <li><a href="#" class="py-2 d-block" style="color: black">Features</a></li>
                            <li><a href="#" class="py-2 d-block" style="color: black">Blog</a></li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="row">
                <div class="col-md-12 text-center">
                    <p style="color: black">
                        Copyright &copy;
                        <script>document.write(new Date().getFullYear());</script> FPT University Campus Ho Chi Minh
                    </p>
                </div>
            </div>
        </div>
    </footer>
    <!-- loader -->
    <div id="ftco-loader" class="show fullscreen"></div>
    <!-- Independent AJAX Form Submission Script -->
    <script type="text/javascript">
        $("#frmCreateOrder").submit(function () {
            var postData = $("#frmCreateOrder").serialize();
            var submitUrl = $("#frmCreateOrder").attr("action");
            $.ajax({
                type: "POST",
                url: submitUrl,
                data: postData,
                dataType: 'JSON',
                success: function (x) {
                    if (x.code === '00') {
                        if (window.vnpay) {
                            vnpay.open({width: 768, height: 600, url: x.data});
                        } else {
                            location.href = x.data;
                        }
                        return false;
                    } else {
                        alert(x.Message);
                    }
                }
            });
            return false;
        });
    </script>
    <script src="js/scriptBooking.js"></script>
</body>
</html>
