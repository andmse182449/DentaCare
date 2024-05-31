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
    </head>

    <body>
        <div class="grid-container">
            <!-- HEADER -->
            <header class="header"> 
                <div></div>
                <div class="header-icon">
                    <span class="material-symbols-outlined">notifications</span>
                    <span class="material-symbols-outlined">mail</span>
                    <span class="material-symbols-outlined">account_circle</span>
                </div>
            </header>

            <!-- SIDEBAR -->
            <aside id="sidebar">
                <div>
                    <ul class="sidebar-list">
                        <a href="coWeb-dashboard.jsp"><li class="sidebar-list-item">Dashboard</li></a>
                        <a href="coWeb-dentist.jsp"><li class="sidebar-list-item">Manage Dentist</li></a>
                        <a href="coWeb-staff.jsp"><li class="sidebar-list-item">Manage Staff</li></a>
                        <a href="coWeb-clinic.jsp"><li class="sidebar-list-item">Manage Clinic</li></a>
                        <a href="coWeb-clinic.jsp"><li class="sidebar-list-item">Manage Service</li></a>
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
                                <h3 class="box-title">Table Staff</h3>



                                <%-- Existing table code --%>

                                <!-- Add your CSS for the popup -->


                                <!-- Add your JavaScript for the popup -->

                                <div>
                                    <form id="clinicForm" action="./ManageStaffServlet" method="post">
                                        <select name="clinicName-1" id="clinicSelect" onchange="submitFormWithSelectedValue()">
                                            <c:forEach items="${clinicName}" var="name">
                                                <option value="${name}" <c:if test="${name == clinic.clinicName}">selected</c:if>>${name}</option>
                                            </c:forEach>
                                        </select>
                                    </form>
                                </div>
                                <<script>
                                    function submitFormWithSelectedValue() {
                                        var selectElement = document.getElementById('clinicSelect');
                                        var selectedValue = selectElement.options[selectElement.selectedIndex].value;
                                        var formElement = document.getElementById('clinicForm');
                                        formElement.action = './ManageStaffServlet?selectedClinic=' + encodeURIComponent(selectedValue);
                                        formElement.submit();
                                    }

                                    // Automatically select the first clinic on page load if no selection exists
                                    window.onload = function () {
                                        var urlParams = new URLSearchParams(window.location.search);
                                        var selectedClinic = urlParams.get('selectedClinic');
                                        if (!selectedClinic) {
                                            var selectElement = document.getElementById('clinicSelect');
                                            var firstClinic = selectElement.options[0].value;
                                            var formElement = document.getElementById('clinicForm');
                                            formElement.action = './ManageStaffServlet?selectedClinic=' + encodeURIComponent(firstClinic);
                                            formElement.submit();
                                        } else {
                                            var selectElement = document.getElementById('clinicSelect');
                                            selectElement.value = selectedClinic;
                                        }
                                    };
                                </script>

                                <div class="table-responsive">
                                    <table class="table text-nowrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">#</th>
                                                <th class="border-top-0">Staff-Username</th>
                                                <th class="border-top-0">Email</th>
                                                <th class="border-top-0">Full Name</th>
                                                <th class="border-top-0">Dob</th>
                                                <th class="border-top-0">Address</th>


                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listAccount}" var="staff" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${staff.userName}</td>
                                                    <td>${staff.email}</td>
                                                    <td>${staff.fullName}</td>
                                                    <td>${staff.dob}</td>     
                                                    <td>${staff.address}</td>
                                                    <td>
                                                        <i class="fa-solid fa-trash" onclick="submitForm(this.nextElementSibling)"></i>
                                                        <form action="./ManageStaffServlet" method="post">
                                                            <input name="action" value="deteleStaff" type="hidden" />
                                                            <input name="staffUserName" value="${staff.userName}" type="hidden" />
                                                            <input name="selectedClinic" value="${param.selectedClinic}" type="hidden" />
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
                <hr>
                <div class="container-fluid">
                    <!-- ============================================================== -->
                    <!-- Start Page Content -->
                    <!-- ============================================================== -->
                    <div class="row">
                        <div class="col-sm-12">
                            <div class="white-box">
                                <h3 class="box-title">Table Account Staff Removed</h3>


                                <div class="table-responsive">
                                    <table class="table text-nowrap">
                                        <thead>
                                            <tr>
                                                <th class="border-top-0">#</th>
                                                <th class="border-top-0">Staff-Username</th>
                                                <th class="border-top-0">Email</th>
                                                <th class="border-top-0">Full Name</th>
                                                <th class="border-top-0">Dob</th>
                                                <th class="border-top-0">Address</th>


                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach items="${listAccountRemoved}" var="staff" varStatus="status">
                                                <tr>
                                                    <td>${status.index + 1}</td>
                                                    <td>${staff.userName}</td>
                                                    <td>${staff.email}</td>
                                                    <td>${staff.fullName}</td>
                                                    <td>${staff.dob}</td> 
                                                    <td>${staff.address}</td>
                                                    <td>
                                                        <i class="fa-solid fa-plus" onclick="submitForm(this.nextElementSibling)"></i>
                                                        <form action="./ManageStaffServlet" method="post">
                                                            <input name="action" value="addAgainStaff" type="hidden" />
                                                            <input name="staffUserName" value="${staff.userName}" type="hidden" />
                                                            <input name="selectedClinic" value="${param.selectedClinic}" type="hidden" />
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
                </script>

            </div>
        </div>
    </body>
</html>
