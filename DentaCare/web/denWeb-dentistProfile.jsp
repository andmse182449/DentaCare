<%-- 
    Document   : denWeb-dentistProfile
    Created on : May 29, 2024, 7:23:52 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@ page import="java.time.LocalDate, java.time.temporal.WeekFields, java.util.Locale" %>
<%@ page import="java.util.Calendar, java.util.GregorianCalendar" %>
<%@page import="account.*" %>

<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Profile Staff</title>
        <link href="admin-front-end/css/styleProfileStaff.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/css/bootstrap.min.css" rel="stylesheet">
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.0.0-alpha1/dist/js/bootstrap.bundle.min.js" rel="stylesheet">
        <link href="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.2.1/jquery.min.js" rel="stylesheet">
    </head>
    <body>
        <%
            LocalDate now2 = LocalDate.now();
            WeekFields weekFields = WeekFields.of(Locale.getDefault());
            int currentYear2 = now2.getYear();
            int currentWeek2 = now2.get(weekFields.weekOfWeekBasedYear());
            AccountDTO account = (AccountDTO) session.getAttribute("account");
            int clinicID = account.getClinicID();         
        %>

    <div class="container rounded bg-white mt-5 mb-5">
        <div><a class="back-link" href="LoadScheduleForEachDentistServlet?action=loadDenSchedule&clinicByID=<%=clinicID%>&year=<%=currentYear2%>&week=<%=currentWeek2%>">Back</a></div>
        <div class="row">
            <div class="col-md-3 border-right">
                <div class="d-flex flex-column align-items-center text-center p-3 py-5">
                    <img class="rounded-circle mt-5" width="150px" src="images/${account.image}">
                    <span class="font-weight-bold">${account.fullName}</span>
                    <span class="text-black-50">${account.email}</span>
                    <span> </span>
                </div>
            </div>
            <div class="col-md-5 border-right">
                <div class="p-3 py-5">
                    <div class="d-flex justify-content-between align-items-center mb-3">
                        <h4 class="text-right">Profile Settings</h4>
                    </div>
                    <div>
                        <form action="./ProfileStaffServlet" method="post" enctype="multipart/form-data">
                            <div class="row mt-3">
                                <input type="hidden" value="${account.accountID}" name="accountId" />
                                <div class="col-md-12">
                                    <label class="labels">UserName</label>
                                    <input type="text" class="form-control" placeholder="Username" name="username" value="${account.userName}" required readonly>
                                </div>
                                <div class="col-md-12">
                                    <label class="labels">Full Name</label>
                                    <input type="text" class="form-control" placeholder="Full Name" name="fullName" value="${account.fullName}">
                                    <input type="hidden" class="form-control" placeholder="Full Name" name="email" value="${account.email}">
                                </div>
                                <div class="col-md-12">
                                    <label class="labels">Phone</label>
                                    <input type="text" class="form-control" placeholder="Phone" name="phone" value="${account.phone}">
                                </div>
                                <div class="col-md-12">
                                    <label class="labels">Address</label>
                                    <input type="text" class="form-control" placeholder="Address" name="address" value="${account.address}">
                                </div>
                                <div class="col-md-12">
                                    <label class="labels">Date of birth</label>
                                    <input type="text" class="form-control" placeholder="Date of birth (dd/MM/yyyy)" name="dob" value="${account.dob}">
                                    <small id="dobError" style="color:red; display:none;">Please enter a valid date in dd/MM/yyyy format.</small>
                                </div>
                                <div class="col-md-12">
                                    <label class="labels">Gender</label><br>
                                    <input type="radio" class="form-control-radio" name="gender" value="Male" ${account.gender ? 'checked' : ''}> Male
                                    <input type="radio" class="form-control-radio" name="gender" value="Female" ${!account.gender ? 'checked' : ''}> Female                                 
                                </div>
                                <div style="margin-top: 10px;" class="col-md-12">
                                    <label class="labels">Profile Image</label>
                                    <input value="${account.image}" type="file" name="edit-image" id="edit-image" accept="image/png, image/jpg">
                                </div>
                                <input type="hidden" value="updateProfileStaff" name="action" />
                            </div>
                            <input type="submit" value="Save Profile" />
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script src="admin-front-end/js/profileStaff.js"></script>    

</body>
</html>
