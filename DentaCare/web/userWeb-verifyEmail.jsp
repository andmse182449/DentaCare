<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <!-- ===== Iconscout CSS ===== -->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">

        <!-- ===== CSS ===== -->
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Log in</title>

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
                        <li class="nav-item active"><a href="index.jsp" class="nav-link" style="color: black">Home</a></li>
                        <li class="nav-item"><a href="about.html" class="nav-link" style="color: black">About</a></li>
                        <li class="nav-item"><a href="services.html" class="nav-link" style="color: black">Services</a></li>
                        <li class="nav-item"><a href="doctors.html" class="nav-link" style="color: black">Doctors</a></li>
                        <li class="nav-item"><a href="feedback.html" class="nav-link" style="color: black">Blog</a></li>
                        <li class="nav-item"><a href="contact.html" class="nav-link" style="color: black">Contact</a></li>
                        <li class="nav-item cta"><a href="#" class="nav-link show-popup" data-target="#modalRequest">Log in</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <c:set var="err" value="${requestScope.error}"/>
        <c:set var="suc" value="${requestScope.success}"/>
        <div class="container-login">
            <div class="forms">
                <div class="form login" method="POST">
                    <span class="title">Register</span>

                    <c:set value="${requestScope.error}" var="err" />
                    <c:set value="${requestScope.success}" var="suc" />
                    <div class="alert sec">${err}</div>
                    <div class="success sec">${suc}</div>
                    <form action="RegisterServlet?action=checkEmail" method="POST" onsubmit="return sendPassword()">

                        <div class="input-field">
                            <input type="email" name="key" placeholder="Enter your email" required>
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
            document.addEventListener("DOMContentLoaded", function () {
                const successBox = document.querySelector(".success.sec");
                if (successBox && successBox.textContent.trim()) {
                    successBox.style.display = "block"; // Show the alert if there's an error message
                    successBox.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                    setTimeout(function () {
                        successBox.classList.remove("show");
                        setTimeout(function () {
                            successBox.style.display = "none"; // Hide the alert after the fade-out animation
                        }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                    }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                }
            });
            function verifyPasswords(event) {
                event.preventDefault(); // Prevent form submission
                const password = document.getElementsByName("register-pass")[0].value;
                const confirmPassword = document.getElementsByName("passAgain")[0].value;
                const alertBox = document.querySelector(".signup .alert");

                if (password === confirmPassword) {
                    alertBox.classList.remove("show");
                    event.target.submit(); // Submit the form if passwords match
                } else {
                    alertBox.style.display = "block"; // Show the alert immediately
                    alertBox.classList.add("show"); // Add the 'show' class to trigger the fade-in animation

                    // Remove the 'show' class after a delay to trigger the fade-out animation
                    setTimeout(function () {
                        alertBox.classList.remove("show");
                        setTimeout(function () {
                            alertBox.style.display = "none"; // Hide the alert after the fade-out animation
                        }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                    }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                }
            }

            document.querySelector(".signup form").addEventListener("submit", verifyPasswords);
        </script>
        <script src="js/login.js"></script>
    </body>
</html>
