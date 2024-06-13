<%-- 
    Document   : tableList
    Created on : May 23, 2024, 11:08:40 AM
    Author     : ADMIN
--%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <!-- Tell the browser to be responsive to screen width -->
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="keywords"
              content="wrappixel, admin dashboard, html css dashboard, web dashboard, bootstrap 5 admin, bootstrap 5, css3 dashboard, bootstrap 5 dashboard, Ample lite admin bootstrap 5 dashboard, frontend, responsive bootstrap 5 admin template, Ample admin lite dashboard bootstrap 5 dashboard template">
        <meta name="description"
              content="Ample Admin Lite is powerful and clean admin dashboard template, inpired from Bootstrap Framework">
        <meta name="robots" content="noindex,nofollow">
        <title>Admin</title>
        <link rel="canonical" href="https://www.wrappixel.com/templates/ample-admin-lite/" />
        <!-- Favicon icon -->

        <!-- Custom CSS -->
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css" integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw==" crossorigin="anonymous" referrerpolicy="no-referrer" />
        <link href="https://fonts.googleapis.com/css2?family=Montserrat:ital,wght@0,100..900;1,100..900&family=Roboto&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/icon?family=Material+Symbols+Outlined" rel="stylesheet">
        <link href="admin-front-end/css/style.min.css" rel="stylesheet">
        <link rel="stylesheet" href="css/stylesheet.css">
        <!--        <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
                <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>-->
    </head>

    <body>
        <div class="grid-container">
             <!-- HEADER -->
             <header class="header" style="height: 105px;">
                 <div><h1 style="font-weight: bolder;">MANAGE SERVICE</h1></div>
                <div class="header-icon">
                    <span class="material-symbols-outlined" style="font-size: 32px;" onclick="toggleDropdown()">account_circle</span>
                    <!-- Dropdown Content -->
                    <div class="sub-menu-wrap" id="sub-menu-wrap">
                        <div class="sub-menu">
                            <div class="user-info">
                                <h3>${sessionScope.account.userName}</h3>
                            </div>
                            <hr>

                            <a href="SignOutServlet" class="sub-menu-link">
                                <span class="material-symbols-outlined">logout</span>
                                <p>Logout</p>
                                <i class="fa fa-chevron-right"></i>
                            </a>
                        </div>
                    </div>
                </div>
            </header>
            <!-- SIDEBAR -->
            <!-- SIDEBAR -->
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="coWeb-dashboard.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">monitoring</span> <div>Dashboard</div></li></a>
                        <a href="coWeb-dentist.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">groups_2</span><div>Manage Dentist</div></li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item"><span class="material-symbols-outlined">supervisor_account</span><div>Manage Staff</div></li></a>
                        <a href="LoadAllDentaListServlet"><li class="sidebar-list-item"><span class="material-symbols-outlined">home_health</span><div>Manage Clinic</div></li></a>
                        <a href="ServiceController"><li class="sidebar-list-item sidebar-list-item-selected"><span class="material-symbols-outlined">dentistry</span><div>Manage Service</div></li></a>
                        <a href="ManageStaffServlet"><li class="sidebar-list-item">Staff List</li></a>
                    </ul>
                </div>
            </aside>

            <!-- MAIN -->
            <div class="main-container">
                <div class="container-fluid">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- ============================================================== -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="white-box">
                                <h3 class="box-title">Table Service</h3>

                                <c:if test="${not empty error}">
                                    <div id="errorPopup" class="popup-content">
                                        <span class="close" onclick="closePopup()">&times;</span>
                                        <p>${error}</p>
                                    </div>
                                    <div id="overlay" class="popup-overlay"></div>
                                </c:if>

                                <%-- Existing table code --%>

                                <!-- Add your CSS for the popup -->
                                <style>
                                    .popup-content {
                                        display: none;
                                        position: fixed;
                                        left: 50%;
                                        top: 50%;
                                        transform: translate(-50%, -50%);
                                        background-color: #f9f9f9;
                                        padding: 20px;
                                        box-shadow: 0px 8px 16px 0px rgba(0,0,0,0.2);
                                        z-index: 1001;
                                    }

                                    .popup-overlay {
                                        display: none;
                                        position: fixed;
                                        left: 0;
                                        top: 0;
                                        width: 100%;
                                        height: 100%;
                                        background-color: rgba(0,0,0,0.5);
                                        z-index: 1000;
                                    }

                                    .popup-overlay.active, .popup-content.active {
                                        display: block;
                                    }

                                    .close {
                                        cursor: pointer;
                                        float: right;
                                    }
                                </style>

                                <!-- Add your JavaScript for the popup -->
                                <script>
                                    function closePopup() {
                                        document.getElementById("errorPopup").classList.remove("active");
                                        document.getElementById("overlay").classList.remove("active");
                                    }

                                    window.onload = function () {
                                        var errorPopup = document.getElementById("errorPopup");
                                        if (errorPopup) {
                                            errorPopup.classList.add("active");
                                            document.getElementById("overlay").classList.add("active");
                                        }
                                    }
                                </script>
                                <div class="table-responsive">
                                    <table class="table text-nowrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">#</th>
                                                <th class="border-top-0">Service Name</th>
                                                <th class="border-top-0">Service Type</th>
                                                <th class="border-top-0">Service Description</th>
                                                <th class="border-top-0">Price</th>


                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listActive}" var="service" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${service.serviceName}</td>
                                                    <td>${service.serviceType}</td>
                                                    <td style="white-space: pre-wrap;">${service.serviceDescription}</td>
                                                    <td>${service.serviceMoney}</td>
                                                    <td>
                                                        <button onclick="toggleEditForm(this)">Edit</button>
                                                        <div class="popup-overlay"></div>
                                                        <div class="popup-content">
                                                            <form id="EditPopUp" action="./ServiceController">
                                                                <input name="serviceId" value="${service.serviceID}" type="hidden"/>
                                                                <label>Name:</label>
                                                                <input type="text" name="serviceName" value="${service.serviceName}"  required/>
                                                                <label>Type:</label>
                                                                <select class="serviceType" name="serviceType" required>
                                                                    <option value="Treatment Process" <c:if test="${serviceType == service.serviceType}">selected</c:if>>Treatment Process</option>
                                                                    <option value="Caring Process" <c:if test="${serviceType == service.serviceType}">selected</c:if>>Caring Process</option>
                                                                </select>
                                                                <label>Description:</label>
                                                                <input type="text" name="serviceDescription" value="${service.serviceDescription}"  required/>
                                                                <label>Price (Min 100 and Max 300):</label>
                                                                <input type="number" name="serviceMoney" value="${service.serviceMoney}" min="100" max="300" required/>
                                                                <input name="action" value="update" type="hidden" />
                                                                <input type="submit" value="Update" />
                                                            </form>
                                                        </div>
                                                    </td>
                                                    <td>
                                                        <i class="fa-solid fa-trash" onclick="submitForm(this.nextElementSibling)"></i>
                                                        <form action="./ServiceController" method="post">
                                                            <input name="action" value="delete" type="hidden" />
                                                            <input name="serviceId" value="${service.serviceID}" type="hidden" />
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                    <button onclick="toggleEditForm(this)">Add new service</button>
                                    <div class="popup-overlay"></div>
                                    <div class="popup-content">
                                        <form id="EditPopUp" action="./ServiceController">
                                            <label>Name:</label>
                                            <input type="text" name="serviceName" required/>
                                            <label>Type:</label>
                                            <select class="serviceType" name="serviceType" required>
                                                <option value="Treatment Process" <c:if test="${serviceType == service.serviceType}">selected</c:if>>Treatment Process</option>
                                                <option value="Caring Process" <c:if test="${serviceType == service.serviceType}">selected</c:if>>Caring Process</option>
                                            </select>
                                            <label>Description:</label>
                                            <input type="text" name="serviceDescription" required/>
                                            <label>Price (Min 100 and Max 300):</label>
                                            <input type="number" name="serviceMoney" value="${service.serviceMoney}" min="100" max="300" required/>
                                            <input name="action" value="add" type="hidden" />
                                            <input type="submit" value="Add" />
                                        </form>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- ============================================================== -->
                    <!-- End PAge Content -->
                    <!-- ============================================================== -->
                    <!-- ============================================================== -->
                    <!-- Right sidebar -->
                    <!-- ============================================================== -->
                    <!-- .right-sidebar -->
                    <!-- ============================================================== -->
                    <!-- End Right sidebar -->
                    <!-- ============================================================== -->
                </div>
                <hr>
                <div class="container-fluid">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- ============================================================== -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="white-box">
                                <h3 class="box-title">Table Service Removed</h3>


                                <div class="table-responsive">
                                    <table class="table text-nowrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">#</th>
                                                <th class="border-top-0">Service Name</th>
                                                <th class="border-top-0">Service Type</th>
                                                <th class="border-top-0">Service Description</th>
                                                <th class="border-top-0">Price</th>


                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listUnactive}" var="service" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${service.serviceName}</td>
                                                    <td>${service.serviceType}</td>
                                                    <td style="white-space: pre-wrap;">${service.serviceDescription}</td>
                                                    <td>${service.serviceMoney}</td>
                                                    <td>
                                                        <i class="fa-solid fa-plus" onclick="submitForm(this.nextElementSibling)"></i>
                                                        <form action="./ServiceController" method="post">
                                                            <input name="action" value="addAgain" type="hidden" />
                                                            <input name="serviceId" value="${service.serviceID}" type="hidden" />
                                                        </form>
                                                    </td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>

                                </div>
                            </div>
                        </div>
                    </div>
                    <!-- ============================================================== -->
                    <!-- End PAge Content -->
                    <!-- ============================================================== -->
                    <!-- ============================================================== -->
                    <!-- Right sidebar -->
                    <!-- ============================================================== -->
                    <!-- .right-sidebar -->
                    <!-- ============================================================== -->
                    <!-- End Right sidebar -->
                    <!-- ============================================================== -->
                </div>

                <!-- ============================================================== -->
                <!-- End footer -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- End Page wrapper  -->
                <!-- ============================================================== -->

                <!-- ============================================================== -->
                <!-- End Wrapper -->
                <!-- ============================================================== -->
                <!-- ============================================================== -->
                <!-- All Jquery -->
                <!-- ============================================================== -->
                <script src="admin-front-end/plugins/bower_components/jquery/dist/jquery.min.js"></script>
                <!-- Bootstrap tether Core JavaScript -->
                <script src="admin-front-end/bootstrap/dist/js/bootstrap.bundle.min.js"></script>
                <script src="admin-front-end/js/app-style-switcher.js"></script>

                <!--Custom JavaScript -->
                <script src="admin-front-end/js/custom.js"></script>
                <script>
                        function submitForm(formElement) {
                                                                formElement.submit();
                                                            }
                        document.querySelector("#create-button").addEventListener("click", function () {
                            document.querySelector(".popup").classList.add("active");
                        });

                        document.querySelector(".popup .close-btn").addEventListener("click", function () {
                            document.querySelector(".popup").classList.remove("active");
                        });

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

                        let subMenu = document.getElementById("sub-menu-wrap");
                        function toggleDropdown() {
                            subMenu.classList.toggle("open-menu");
                        }
                </script>

            </div>
        </div>
    </body>
</html>
