<%@include file="/headerLog.jsp" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">

    <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>User Profile</title>
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <link rel="stylesheet" href="css/account-information.css" />
        <link rel="stylesheet" href="css/modification-information.css" />
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
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
        .alert.show {
            display: block;
            opacity: 1;
        }
        input[type="tel"] {
            padding: 0;
            margin: 0;
        }

    </style>
    <body>
        <div class="container user">
            <nav class="navbar user" style="margin-top: -50px;">
                <ul>
                    <li><a href="#" id="userProfileLink" class="active">User Profile</a></li>
                    <li><a href="ExamScheduleServlet">Examination Schedule</a></li>
                    <li><a href="HistoryServlet" id="bookingHistoryLink">Booking History</a></li>
                    <li><a href="SignOutServlet">Sign out</a></li>
                </ul>
            </nav>
            <c:set var="unmatch" value="${requestScope.unmatch}"/>
            <div class="alert sec">${unmatch}</div>
            <c:set var="account" value="${sessionScope.account}" />
            <div class="content active" id="userProfileContent">
                <div class="profile">
                    <div class="inf">
                        <h5>User Information</h5>
                        <label for="accountID">Full Name: <b>${account.getFullName() != null ? account.getFullName() : '---'}</b></label><br>
                        <label for="phone">Phone: <b>${account.getPhone() != null ? account.getPhone() : '---'}</b></label><br>
                        <label for="dob">Date of Birth: <b>${account.getDob() != null ? account.getDob() : '---'}</b></label><br>
                        <label for="email">Email: <b>${account.getEmail() != null ? account.getEmail() : '---'}</b></label><br>
                        <label for="gender">Gender:
                            <c:choose>
                                <c:when test="${account.isGender() != null}">
                                    <c:choose>
                                        <c:when test="${account.isGender() == 'true'}"><b>Male</b></c:when>
                                        <c:otherwise><b>Female</b></c:otherwise>
                                    </c:choose>
                                </c:when>
                                <c:otherwise><b>---</b></c:otherwise>
                            </c:choose>
                        </label><br>
                        <a class="show-popup" href="#">Change information</a>
                    </div>
                    <c:set var="unallow" value="${requestScope.unallow}"/>

                    <div class="reset ${unallow}">
                        <h5>Change Password</h5>
                        <form action="ChangePasswordServlet?action=change" method="POST">
                            <div class="input-field">
                                <input name="register-pass" type="password" class="password" placeholder="Type in your current password" required>
                                <i class="uil uil-eye-slash showHidePw"></i>
                            </div><br>
                            <div class="input-field">
                                <input name="newPass" type="password" class="password" placeholder="Type in your new password" required>
                                <i class="uil uil-eye-slash showHidePw"></i>
                            </div><br>  
                            <div class="button-container">
                                <input class="resetBtn" type="submit" value="Change"/>
                            </div>
                        </form>

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
                    </script>
                </div>

            </div>
        </div>

        <div class="popup-container">
            <div class="popup-box">
                <h1>Information Modification</h1>
                <div class="mod-icon">
                    <svg width="16" height="16" viewBox="0 0 16 16" fill="none" xmlns="http://www.w3.org/2000/svg">
                    <path d="M3.24331 4.33318L3.24367 4.33298L7.19472 2.04762C7.19509 2.04741 7.19545 2.0472 7.19581 2.047C7.69601 1.76168 8.3058 1.76315 8.79663 2.04649L12.7533 4.33124C13.2494 4.62345 13.5542 5.1472 13.56 5.72248V10.2802C13.56 10.8559 13.2544 11.3836 12.7633 11.6671L8.80525 13.9527C8.80493 13.9529 8.8046 13.9531 8.80427 13.9533C8.30404 14.2387 7.69418 14.2372 7.20331 13.9538L3.24506 11.6682C2.75048 11.3768 2.44666 10.847 2.44666 10.2802V5.72016C2.44666 5.14444 2.75224 4.61669 3.24331 4.33318ZM8.82687 11.6604L8.83617 11.6511L8.84497 11.6413C8.94141 11.5342 9.01905 11.4131 9.07486 11.2791C9.1295 11.148 9.16666 10.996 9.16666 10.8335C9.16666 10.6737 9.13072 10.5241 9.07756 10.3944C9.01633 10.2379 8.93146 10.1218 8.84497 10.0257L8.83617 10.0159L8.82688 10.0066C8.50044 9.68017 7.99409 9.57313 7.55766 9.75719C7.40282 9.81832 7.28761 9.90262 7.19217 9.98851L7.1824 9.99731L7.1731 10.0066C6.94742 10.2323 6.83332 10.5352 6.83332 10.8335C6.83332 10.9699 6.85412 11.1248 6.91845 11.2791L6.92507 11.295L6.93278 11.3104C6.98794 11.4208 7.05838 11.5339 7.15501 11.6413L7.17261 11.6609L7.19217 11.6785C7.28827 11.765 7.40442 11.8498 7.56089 11.9111C7.69054 11.9642 7.84017 12.0002 7.99999 12.0002C8.30764 12.0002 8.60299 11.8843 8.82687 11.6604ZM7.99999 4.16683C7.45051 4.16683 6.99999 4.61735 6.99999 5.16683V8.66683C6.99999 9.21631 7.45051 9.66683 7.99999 9.66683C8.54946 9.66683 8.99999 9.21631 8.99999 8.66683V5.16683C8.99999 4.61735 8.54946 4.16683 7.99999 4.16683Z" fill="#F97316" stroke="#F97316"></path>
                    </svg>
                    <p class="ml-1 text-sm">All fields should be done for a better examination and profile management.</p>
                </div>
                <form action="UpdateProfileServlet" style="margin-top: 2rem;">
                    <div class="form-group">
                        <label for="fullName">Full Name<span class="text-red-500">*</span></label><br>
                        <input type="text" class="form-control" id="fullName" name="fullName" value="${account.getFullName() != null ? account.getFullName() : ''}" required>
                    </div>

                    <div class="form-group">
                        <label for="phone">Phone<span class="text-red-500">*</span></label><br>
                        <input type="tel" class="form-control" id="phone" name="phone" value="${account.getPhone() != null ? account.getPhone() : ''}" maxlength="10" required>
                        <p id="errorMessage" style="color: red;"></p>
                    </div>

                    <div class="form-group">
                        <label for="dob">Date of Birth<span class="text-red-500">*</span></label><br>
                        <input type="date" class="form-control" id="dob" name="dob" value="${account.getDob() != null ? account.getDob() : ''}">
                    </div>

                    <script>
                        document.getElementById("dob").addEventListener("input", function () {
                            var inputDate = this.value;
                            var year = parseInt(inputDate.substring(0, 4));
                            if (year < 1920 || year > new Date().getFullYear()) {
                                var today = new Date();
                                var dd = String(today.getDate()).padStart(2, '0');
                                var mm = String(today.getMonth() + 1).padStart(2, '0');
                                var yyyy = today.getFullYear();
                                var currentDate = yyyy + '-' + mm + '-' + dd;
                                this.value = currentDate;
                            }
                        });
                    </script>

                    <div class="form-group">
                        <label for="gender">Gender<span class="text-red-500">*</span></label><br>
                        <div class="gender-sec">
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="gender" id="male" value="true" ${account.isGender() != null && account.isGender() == 'true' ? 'checked' : ''} required>
                                <label class="form-check-label" style="font-weight: normal;" for="male">Male</label>
                            </div>
                            <div class="form-check">
                                <input class="form-check-input" type="radio" name="gender" id="female" value="false" ${account.isGender() != null && account.isGender() == 'false' ? 'checked' : ''} required>
                                <label class="form-check-label" style="font-weight: normal;" for="female">Female</label>
                            </div>
                        </div>
                    </div>

                    <div class="form-group">
                        <label for="email">Email:</label>
                        <input type="email" class="form-control" id="email" name="email" value="${account.getEmail() != null ? account.getEmail() : ''}" required readonly>
                    </div>

                    <div class="btnSec" style="display: flex; justify-content: center; gap: 1rem; margin-top: 20px;">
                        <button class="close-btn" type="button">Cancel</button>
                        <input class="save-btn" type="submit" value="Save" />
                    </div>
                </form>
            </div>
        </div>

        <script>
            const phoneInput = document.getElementById('phone');
            const errorMessage = document.getElementById('errorMessage');
            const saveBtn = document.querySelector('.save-btn');
            const pattern = /^0\d{9}$/;

            function validatePhone() {
                const phoneNumber = phoneInput.value.trim(); // Trim spaces
                if (pattern.test(phoneNumber)) {
                    errorMessage.textContent = '';
                } else if (phoneNumber === '') {
                    errorMessage.textContent = '';
                } else {
                    errorMessage.textContent = 'Please enter a valid phone number starting with 0 and having 10 digits.';
                }
                saveBtn.disabled = errorMessage.textContent !== '';
            }


            phoneInput.addEventListener('input', validatePhone);

            phoneInput.addEventListener('keypress', function (event) {
                const charCode = (event.which) ? event.which : event.keyCode;
                if (charCode > 31 && (charCode < 48 || charCode > 57)) {
                    event.preventDefault();
                    return false;
                }
                return true;
            });

            validatePhone();
        </script>

        <script>
            const showPopup = document.querySelector('.show-popup');
            const popupContainer = document.querySelector('.popup-container');
            const closeBtns = document.querySelectorAll('.close-btn');

            showPopup.addEventListener('click', () => {
                popupContainer.classList.add('active');
            });

            closeBtns.forEach(btn => {
                btn.addEventListener('click', () => {
                    popupContainer.classList.remove('active');
                });
            });

            window.addEventListener('click', event => {
                if (event.target === popupContainer) {
                    popupContainer.classList.remove('active');
                }
            });
        </script>
        <script>
            const showHidePwIcons = document.querySelectorAll('.showHidePw');
            const passwordFields = document.querySelectorAll('.password');

            showHidePwIcons.forEach((icon, index) => {
                icon.addEventListener('click', () => {
                    const type = passwordFields[index].getAttribute('type') === 'password' ? 'text' : 'password';
                    passwordFields[index].setAttribute('type', type);
                    icon.classList.toggle('uil-eye-slash');
                    icon.classList.toggle('uil-eye');
                });
            });
        </script>
        <%@include file="/footer.jsp" %>
    </body>

</html>
