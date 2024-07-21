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
        <link href="https://unpkg.com/boxicons@2.1.4/css/boxicons.min.css" rel="stylesheet">
        <!-- ===== CSS ===== -->
        <link rel="stylesheet" href="css/style.css">
        <link rel="stylesheet" href="css/styleLoginForNV.css">
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
                        <li class="nav-item cta"><a href="login.jsp" class="nav-link show-popup" data-target="#modalRequest">Log in</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <c:set var="err" value="${requestScope.error}"/>
        <c:set var="suc" value="${requestScope.success}"/>
        <div class="alert sec">${err}</div>
        <div class="success sec">${suc}</div>
        <div class="login-form">
            <h1>Login Dentist</h1>
            <form id="" action="LoginActionServlet">
                <div class="input-form">
                    <input name="email" type="text" placeholder="Enter your username" required>
                </div>
                <div class="input-form">
                    <input name="password" type="password" class="password" placeholder="Enter your password" required>
                </div>
                <a href="forgetPassword.jsp" class="text" style="margin-top: 10px; text-align: left;">Forgot password?</a>
                <input type="hidden" name="key" value="bs">
                <button type="submit">login</button>
            </form>
        </div>
        <script>
            const inputs = document.querySelectorAll("input[type='number']"),
                    button = document.querySelector("input[type='submit']"),
                    otpbox = document.querySelector(".opt-box");
            loginForm = document.querySelector(".login-form");

// Iterate over all inputs
            inputs.forEach((input, index1) => {
                input.addEventListener("keyup", (e) => {
                    const currentInput = input,
                            nextInput = input.nextElementSibling,
                            prevInput = input.previousElementSibling;

                    // If the value has more than one character then clear it
                    if (currentInput.value.length > 1) {
                        currentInput.value = "";
                        return;
                    }
                    // If the next input is disabled and the current value is not empty
                    // enable the next input and focus on it
                    if (nextInput && nextInput.hasAttribute("disabled") && currentInput.value !== "") {
                        nextInput.removeAttribute("disabled");
                        nextInput.focus();
                    }

                    // If the backspace key is pressed
                    if (e.key === "Backspace") {
                        inputs.forEach((input, index2) => {
                            if (index1 <= index2 && prevInput) {
                                input.setAttribute("disabled", true);
                                input.value = "";
                                prevInput.focus();
                            }
                        });
                    }

                    // If the fourth input (index 3) is not empty and has no disabled attribute
                    // add active class if not then remove the active class
                    if (!inputs[3].disabled && inputs[3].value !== "") {
                        button.classList.add("active");
                        return;
                    }
                    button.classList.remove("active");
                });
            });
// Focus the first input (index 0) on window load
            window.addEventListener("load", () => inputs[0].focus());

            button.addEventListener("click", () => {
                const otp = Array.from(inputs).map(input => input.value).join("");
                if (otp === "1234") {
                    otpbox.classList.add("hidden");
                    loginForm.classList.remove("hidden");
                    alert("OTP verified successfully!");
                } else {
                    alert("Incorrect OTP. Please try again.");
                }
            });
        </script>
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
        </script>
    </body>
</html>
