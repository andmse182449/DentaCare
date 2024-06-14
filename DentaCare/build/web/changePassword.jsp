<%@include file="/header.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Reset Password</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
    </head>
    <style>
        .alert, .success {
            position: fixed;
            top: 100px;
            left: 50%;
            transform: translateX(-50%);
            padding: 10px;
            border-radius: 5px;
            opacity: 0;
            transition: opacity 0.5s ease-out;
            display: none;
            z-index: 1000;
        }
        .alert {
            background-color: #f44336;
            color: white;
        }
        .success {
            background-color: #22bb33;
            color: white;
        }
        .alert.show, .success.show {
            display: block;
            opacity: 1;
        }
    </style>
    <body>
        <c:set var="key" value="${requestScope.email}"/>
        <div class="container-login">
            <div class="forms">
                <div class="form login">
                    <span class="title">Reset Password</span>
                    <form action="ForgetPasswordServlet?action=reset&key=${key}" method="POST" onsubmit="return verifyPasswords(event)">
                        <div class="input-field">
                            <input name="register-pass" type="password" class="password" placeholder="Create a new password" required>
                            <i class="uil uil-lock icon"></i>
                        </div>
                        <div class="input-field">
                            <input name="passAgain" type="password" class="password" placeholder="Confirm the new password" required>
                            <i class="uil uil-lock icon"></i>
                            <i class="uil uil-eye-slash showHidePw"></i>
                        </div>
                        <div class="alert">Passwords do not match. Please try again.</div>
                        <div class="input-field button">
                            <input type="submit" value="Reset Password">
                        </div>
                    </form>
                </div>
            </div>
        </div>
        <script src="js/login.js"></script>
        <script>
                        function verifyPasswords(event) {
                            event.preventDefault(); // Prevent form submission
                            const password = document.getElementsByName("register-pass")[0].value;
                            const confirmPassword = document.getElementsByName("passAgain")[0].value;
                            const alertBox = document.querySelector(".alert");

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

                        document.querySelector("form").addEventListener("submit", verifyPasswords);
        </script>
    </body>
</html>
