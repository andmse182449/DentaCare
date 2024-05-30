<%-- 
    Document   : denWeb-dentistProfile
    Created on : May 28, 2024, 11:21:51 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Profile</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link rel="stylesheet" href="css/styleDen.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
    </head>
    <body>
        <!-- MENU -->
        <div class="header">
            <nav class="menu">
                <span class="logo">logo</span>
                <ul>
                    <li>
                        <a href="#">my schedule</a>
                    </li>
                    <li>
                        <a href="#">my patient</a>
                    </li>
                </ul>
                <spadn class="material-symbols-outlined" onclick="toggleMenu()">account_circle
                    </span>
                    <div class="sub-menu-wrap" id="sub-menu-wrap">
                        <div class="sub-menu">
                            <div class="user-info">
                                <h3>${sessionScope.account.userName}</h3>
                            </div>
                            <hr>
                            <form action="DentistServlet" method="post" style="display: inline;">
                                <input type="hidden" name="action" value="profile">
                                <input type="hidden" name="accountID" value="${sessionScope.account.accountID}">
                                <button type="submit" class="sub-menu-link" style="border: none; background: none; padding: 0; margin: 0; display: flex; align-items: center; justify-content: space-between; width: 100%; cursor: pointer;">
                                    <div style="display: flex; align-items: center;">
                                        <span class="material-symbols-outlined">person</span>
                                        <p>Profile</p>
                                    </div>
                                    <i class="fa fa-chevron-right"></i>
                                </button>
                            </form>
                            <a href="SignOutServlet" class="sub-menu-link">
                                <span class="material-symbols-outlined">logout</span>
                                <p>Sign out</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>
            </nav>
        </div >
        <!-- MAIN -->
        <div class="alert-error sec">${error}</div>
        <div class="alert-message sec">${message}</div>
        <div class="container user">
            <nav class="navbar user">
                <ul>
                    <li>
                        <a href="#" onclick="updateDenProfile()">Update profile</a>
                    </li>
                    <li>
                        <a href="#">Change password</a>
                    </li>
                    <li>
                        <a href="SignOutServlet">Sign out</a>
                    </li>
                </ul>
            </nav>
            <div class="content active" id="userProfileContent">
                <h1 style="padding: 30px 30px 0 30px;">DENTIST PROFILE</h1>
                <br>
                <div class="form-profile">
                    <form action="DentistServlet" id="dentist-profile-form">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
                                    <div class="label"><h6>Name</h6></div>
                                    <input type="text" name="den-fullName" value="${requestScope.account.fullName.trim()}" required readonly>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="label"><h6>Phone</h6></div>
                                    <input type="text" name="den-phone" value="${requestScope.account.phone.trim()}" required readonly>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="label"><h6>Address</h6></div>
                                    <input type="text" name="den-address" value="${requestScope.account.address.trim()}" required readonly>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="label"><h6>Email</h6></div>
                                    <input type="email" name="den-email" value="${requestScope.account.email.trim()}" required readonly>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="label"><h6>Date of Birth</h6></div>
                                    <input type="date" name="den-dob" value="${requestScope.account.dob}" required readonly>
                                </div>
                                <hr>
                                <div class="row">
                                    <div class="label"><h6>Gender</h6></div>
                                    <div class="label">
                                        <label style="font-size: 16px">Male</label>
                                        <input type="radio" name="den-gender" value="true" ${requestScope.account.gender == 'true' ? 'checked' : ''} disabled style="margin-right: 15px;">
                                        <label style="font-size: 16px">Female</label>
                                        <input type="radio" name="den-gender" value="false" ${requestScope.account.gender == 'false' ? 'checked' : ''}  disabled>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="accountID" value="${sessionScope.account.accountID}">
                            <input type="submit" id="saveDenButton" value="Save" style="display: none;">
                        </div>
                    </form>
                </div>

                <div class="form-profile">
                    <h5>Job Description</h5>
                    <div class="row">
                        <div class="label"><h6>Clinic</h6></div>
                        <div style="font-size: 20px;">${requestScope.clinic}</div>
                    </div>
                    <hr>
                    <div class="row">
                        <div class="label"><h6>Major</h6></div>
                        <div style="font-size: 20px;">${requestScope.clinic}</div>
                    </div>
                    <hr>
                </div>
            </div>
        </div>
        <script>
            let subMenu = document.getElementById("sub-menu-wrap");
            function toggleMenu() {
                subMenu.classList.toggle("open-menu");
            }
            function updateDenProfile() {
                const inputs = document.querySelectorAll(
                        '#dentist-profile-form input[type="text"], #dentist-profile-form input[type="email"], #dentist-profile-form input[type="radio"], #dentist-profile-form input[type="date"]'
                        );
                inputs.forEach((input) => {
                    input.removeAttribute("readonly");
                    input.removeAttribute("disabled");
                });
                document.getElementById("saveDenButton").style.display = "block";
                document.getElementById("den-name").focus();
            }

            document.addEventListener("DOMContentLoaded", function () {
                const alertBox = document.querySelector(".alert-error.sec");
                if (alertBox && alertBox.textContent.trim()) {
                    alertBox.style.display = "block"; // Show the alert if there's an error message
                    alertBox.classList.add("show"); // Add the 'show' class to trigger the fade-in animation
                    setTimeout(function () {
                        alertBox.classList.remove("show");
                        setTimeout(function () {
                            alertBox.style.display = "none"; // Hide the alert after the fade-out animation
                        }, 600); // Adjust the delay (in milliseconds) to match the transition duration
                    }, 1500); // Adjust the delay (in milliseconds) to control how long the alert stays visible
                }
            });

            document.addEventListener("DOMContentLoaded", function () {
                const alertBox2 = document.querySelector(".alert-message.sec");
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

        </script>
    </body>
</html>
