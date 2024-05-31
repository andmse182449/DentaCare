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

            .alert.show {
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
        <div class="opt-box">
            <header>
                <i class="bx bxs-check-shield"></i>
            </header>
            <h4>Enter OTP Code</h4>
            <form id="otp-form" action="javascript:void(0);">
                <div class="input-field">
                    <input type="number">
                    <input type="number" disabled>
                    <input type="number" disabled>
                    <input type="number" disabled>
                </div>
                
                <input type="submit" value="Submit">
            </form>
        </div>
        <div class="login-form hidden">
            <h1>Login Staff</h1>
            <form id="" action="LoginActionServlet">
                <div class="input-form">
                    <input name="email" type="text" placeholder="Enter your email" required>
                </div>
                <div class="input-form">
                    <input name="password" type="password" class="password" placeholder="Enter your password" required>
                </div>
                <a href="forget.jsp" class="text" style="margin-top: 10px; text-align: left;">Forgot password?</a>
                <input type="hidden" name="key" value="nv">
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
                if (otp === "4321") {
                    otpbox.classList.add("hidden");
                    loginForm.classList.remove("hidden");
                    alert("OTP verified successfully!");
                } else {
                    alert("Incorrect OTP. Please try again.");
                }
            });
        </script>
    </body>
</html>
