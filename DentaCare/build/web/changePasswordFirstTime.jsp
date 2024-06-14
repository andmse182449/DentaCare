<%-- 
    Document   : changePasswordFirstTime
    Created on : May 30, 2024, 2:17:17 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Change Password</title>
        <style>
        body {
            font-family: 'Segoe UI', Tahoma, Geneva, Verdana, sans-serif;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            height: 100vh;
            background: linear-gradient(135deg, #35b5ff, #51d4ff); /* Gradient background */
            background-size: cover;
            animation: gradient 15s ease infinite;
        }
        @keyframes gradient {
            0% { background-position: 0% 50%; }
            50% { background-position: 100% 50%; }
            100% { background-position: 0% 50%; }
        }
        .container {
            background-color: rgba(255, 255, 255, 0.9); /* Slightly transparent */
            padding: 30px;
            border-radius: 12px;
            box-shadow: 0 4px 15px rgba(0, 0, 0, 0.2); /* Larger shadow */
            width: 500px;
            transition: transform 0.3s ease, box-shadow 0.3s ease;
        }
        .container:hover {
            transform: scale(1.05); /* Slightly larger on hover */
            box-shadow: 0 8px 30px rgba(0, 0, 0, 0.3); /* Larger shadow on hover */
        }
        .container h2 {
            margin-bottom: 20px;
            text-align: center;
            color: #4A90E2; /* Blue color */
            font-size: 30px;
        }
        .container label {
            display: block;
            margin-bottom: 8px;
            font-weight: bold;
            color: #333;
            font-size: 20px;
        }
        .container input[type="password"] {
            width: 95%;
            padding: 10px 0 10px 10px;
            margin: auto;
            border: 1px solid #ccc;
            border-radius: 8px;
            transition: border-color 0.3s ease, box-shadow 0.3s ease;
            font-size: 20px;
            display: inline-block; /* Make input inline */
        }
        .checkmark {
            display: inline-block; /* Make checkmark inline */
            width: 5%;
            vertical-align: middle; /* Align vertically */
            margin: auto 2px;
        }
        .container input[type="password"]:focus {
            border-color: #4A90E2; /* Blue border on focus */
            box-shadow: 0 0 8px rgba(94, 191, 255, 0.5); /* Blue glow on focus */
            outline: none;
        }
        .container input[type="submit"] {
            width: 20%;
            padding: 12px;
            margin-top: 20px;
            background-color: #4A90E2; /* Blue color */
            color: white;
            border: none;
            border-radius: 8px;
            transition: background-color 0.3s ease, transform 0.3s ease;
            font-size: 20px;
        }
        .container input[type="submit"]:hover {
            background-color: #357ABD; /* Darker blue color */
            transform: translateY(-2px); /* Slight lift on hover */
            cursor: pointer;
        }
        .alert-error {
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

        .alert-error.show {
            display: block;
            opacity: 1;
        }
        </style>
    </head>
    <body>
        <div class="alert-error sec"></div>
        <div class="container">
            <h2>Enter New Password</h2>
            <form action="ChangePasswordServlet" method="POST" onsubmit="return validatePassword()">
                <label for="new-password">New Password</label>
                <div style="display: flex;">
                    <input type="password" name="new-password" id="new-password" required>
                    <span id="password-match1" class="checkmark"></span> <!-- Element to display the check or error mark -->
                </div>
                
                <label for="confirm-password">Confirm New Password</label>
                <div style="display: flex;">
                    <input type="password" name="confirm-password" id="confirm-password" onkeyup="checkPasswordMatch()" required>
                    <span id="password-match2" class="checkmark"></span> <!-- Element to display the check or error mark -->
                </div>
                <input type="hidden" name="action" value="changePasswordFirst">
                <input type="hidden" name="accountID" value="${sessionScope.account.accountID}">
                <input type="submit" value="Save">
            </form>
        </div>
    
        <script>
            function checkPasswordMatch() {
                var newPassword = document.getElementById("new-password").value;
                var confirmPassword = document.getElementById("confirm-password").value;
                var matchElement1 = document.getElementById("password-match1");
                var matchElement2 = document.getElementById("password-match2");
    
                if (newPassword === confirmPassword) {
                    matchElement1.innerHTML = '<span style="color: green;">&#10004;</span>';
                    matchElement2.innerHTML = '<span style="color: green;">&#10004;</span>'; 
                } else {
                    matchElement1.innerHTML = '<span style="color: red;">&#10006;</span>';
                    matchElement2.innerHTML = '<span style="color: red;">&#10006;</span>'; 
                }
            }
    
            function validatePassword() {
                var newPassword = document.getElementById("new-password").value;
                var confirmPassword = document.getElementById("confirm-password").value;
                const alertBox = document.querySelector(".alert-error.sec");
    
                if (newPassword !== confirmPassword) {
                    alertBox.textContent = "Passwords must match!";
                    alertBox.style.display = "block";
                    alertBox.classList.add("show");
                    setTimeout(function () {
                        alertBox.classList.remove("show");
                        setTimeout(function () {
                            alertBox.style.display = "none"; 
                        }, 600); 
                    }, 1500); 
                    return false;
                }
                return true;
            }

            document.addEventListener("DOMContentLoaded", function () {
                const alertBox = document.querySelector(".alert-error.sec");
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
            });
        </script>
    </body>
</html>

