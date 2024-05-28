<%-- 
    Document   : denWeb-dentistProfile
    Created on : May 28, 2024, 11:21:51 AM
    Author     : Admin
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <title>Dentist</title>
        <link rel="stylesheet" href="css/styleDen.css">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
    </head>
    <body>
        <div class="hero">
            <!-- MENU -->
            <nav>
                <span class="logo">Dentist</span>
                <ul>
                    <li><a href="denWeb-dentitstSchedule.jsp">My Schedule</a></li>
                    <li><a href="#">My Patients</a></li>
                </ul>
                <span class="material-symbols-outlined" onclick="toggleMenu()">account_circle</span>
                <div class="sub-menu-wrap" id="sub-menu-wrap">
                    <div class="sub-menu">
                        <div class="user-info">
                            <h3>Hugo</h3>
                        </div>
                        <hr>
                        <a href="denWeb-dentistProfile.jsp" class="sub-menu-link">
                            <span class="material-symbols-outlined">person</span>
                            <p>Profile</p>
                            <i class="fa fa-chevron-right"></i>
                        </a>
                        <a href="SignOutServlet" class="sub-menu-link">
                            <span class="material-symbols-outlined">logout</span>
                            <p>Logout</p>
                            <i class="fa fa-chevron-right"></i>
                        </a>
                    </div>
                </div>
            </nav>
            <div class="main">
                <div class="card-info">
                    <div class="left-card">
                        <div class="card-body">
                            <span class="material-symbols-outlined">person</span>
                            <h3>Hugo</h3>
                        </div>
                        <div class="card-body">
                            <ul>
                                <li onclick="updateDenProfile()">Update my profile</li>
                                <li onclick="changeDenPass()">Change password</li>
                            </ul>
                        </div>
                    </div>                
                    <div class="right-card">
                        <form action="" id="dentist-profile-form">
                            <div class="card-content">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="label"><h5>Name</h5></div>
                                        <input type="text" name="den-fullName" value="${sessionScope.account.fullName}" readonly>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="label"><h5>Phone</h5></div>
                                        <input type="text" name="den-phone" value="${sessionScope.account.phone}" readonly>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="label"><h5>Address</h5></div>
                                        <input type="text" name="den-address" value="${sessionScope.account.address}" readonly>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="label"><h5>Email</h5></div>
                                        <input type="email" name="den-email" value="${sessionScope.account.email}" readonly>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="label"><h5>Date of Birth</h5></div>
                                        <input type="text" name="den-dob" value="${sessionScope.account.dob}" readonly>
                                    </div>
                                    <hr>
                                    <div class="row">
                                        <div class="label"><h5>Gender</h5></div>
                                        <div class="label">
                                            <label style="font-size: 16px">Male</label>
                                            <input type="radio" name="den-gender" value="0" ${sessionScope.account.gender == 0 ? 'checked' : ''} disabled style="margin-right: 15px;">
                                            <label style="font-size: 16px">Female</label>
                                            <input type="radio" name="den-gender" value="1" ${sessionScope.account.gender == 1 ? 'checked' : ''}  disabled>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="card-content">
                                <div class="card-body">
                                    <div class="row">
                                        <div class="label"><h5>??</h5></div>
                                        <input type="text" name="??" value="??" readonly>
                                    </div>
                                </div>
                            </div>
                            <input type="hidden" name="action" value="update">
                            <input type="hidden" name="accountID" value="${sessionScope.account.accountID}">
                            <input type="submit" id="saveDenButton" value="Save" style="display: none;">
                        </form>
                    </div>
                </div>
            </div>
        </div>
        <script>
            let subMenu = document.getElementById("sub-menu-wrap");
            function toggleMenu() {
                subMenu.classList.toggle("open-menu");
            }
            function updateDenProfile() {
                const inputs = document.querySelectorAll('#dentist-profile-form input[type="text"], #dentist-profile-form input[type="email"], #dentist-profile-form input[type="radio"]');
                inputs.forEach(input => {
                    input.removeAttribute('readonly');
                    input.removeAttribute('disabled')
                });
                document.getElementById('saveDenButton').style.display = 'block';
                document.getElementById('den-name').focus();
            }
        </script>
    </body>
</html>
