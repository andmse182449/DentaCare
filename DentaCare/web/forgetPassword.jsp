<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <!-- ===== Iconscout CSS ===== -->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

        <!-- ===== CSS ===== -->
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Forget Password</title>
    </head>
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
        .success {
            position: fixed;
            top: 100px; /* Adjust this value to position the alert higher or lower */
            left: 50%;
            transform: translateX(-50%); /* Center the alert horizontally */
            background-color: #22bb33;
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
        .success.show {
            display: block;
            opacity: 1;
        }
    </style>
    <body>

        <nav class="navbar navbar-expand-lg navbar-dark ftco_navbar bg-dark ftco-navbar-light" id="ftco-navbar">
            <div class="container">
                <a class="navbar-brand" href="index.jsp" style="color: black">Denta<span>Care</span></a>
                <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#ftco-nav" aria-controls="ftco-nav" aria-expanded="false" aria-label="Toggle navigation">
                    <span class="oi oi-menu"></span> Menu
                </button>

                <div class="collapse navbar-collapse" id="ftco-nav">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item active"><a href="index.jsp" class="nav-link" style="color: black">Home</a></li>
                        <li class="nav-item"><a href="about.html" class="nav-link" style="color: black">About</a></li>
                        <li class="nav-item"><a href="services.html" class="nav-link" style="color: black">Services</a></li>
                        <li class="nav-item"><a href="doctors.html" class="nav-link" style="color: black">Doctors</a></li>
                        <li class="nav-item"><a href="blog.html" class="nav-link" style="color: black">Blog</a></li>
                        <li class="nav-item"><a href="contact.html" class="nav-link" style="color: black">Contact</a></li>
                        <li class="nav-item cta"><a href="login.jsp" class="nav-link show-popup" data-target="#modalRequest">Log in</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container-login">
            <div class="forms">
                <div class="form login" method="POST">
                    <span class="title">Forget Password</span>

                    <c:set value="${requestScope.error}" var="err" />
                    <c:set value="${requestScope.success}" var="suc" />
                    <div class="alert sec">${err}</div>
                    <div class="success sec">${suc}</div>
                    <form action="SendPasswordServlet" method="POST" onsubmit="return sendPassword()">

                        <div class="input-field">
                            <input type="email" name="mail" placeholder="Enter your email" required>
                            <i class="uil uil-envelope icon"></i>
                        </div>
                        <div class="login-signup">
                            <span class="text">Already a member?
                                <a href="login.jsp" class="text">Login Now</a>
                            </span>
                        </div>

                        <div class="input-field button">
                            <input type="submit" value="Send">
                        </div>
                    </form>
                </div>s
            </div>
        </div>

        <script src="js/login.js"></script>
        <script>
                        document.addEventListener("DOMContentLoaded", function () {
                            // Display the error alert if there's an error message
                            const alertBox = document.querySelector(".alert.sec");
                            if (alertBox && alertBox.textContent.trim()) {
                                alertBox.style.display = "block";
                                alertBox.classList.add("show");
                                setTimeout(function () {
                                    alertBox.classList.remove("show");
                                    setTimeout(function () {
                                        alertBox.style.display = "none";
                                    }, 600);
                                }, 1500);
                            }

                            // Display the success alert if there's a success message
                            const successBox = document.querySelector(".success.sec");
                            if (successBox && successBox.textContent.trim()) {
                                successBox.style.display = "block";
                                successBox.classList.add("show");
                                setTimeout(function () {
                                    successBox.classList.remove("show");
                                    setTimeout(function () {
                                        successBox.style.display = "none";
                                    }, 600);
                                }, 1500);
                            }
                        });

                        function sendPassword(event) {
                            event.preventDefault(); // Prevent form submission
                            const emailInput = document.getElementsByName("mail")[0];
                            const email = emailInput.value.trim();

                            if (email) {
                                event.target.submit(); // Submit the form if email is provided
                            } else {
                                const alertBox = document.querySelector(".alert.sec");
                                alertBox.style.display = "block";
                                alertBox.classList.add("show");

                                setTimeout(function () {
                                    alertBox.classList.remove("show");
                                    setTimeout(function () {
                                        alertBox.style.display = "none";
                                    }, 600);
                                }, 1500);
                            }
                        }

                        document.querySelector(".form.login form").addEventListener("submit", sendPassword);
        </script>
    </body>
</html>