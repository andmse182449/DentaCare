
<%-- 
    Document   : staffWeb-ProfileStaff
    Created on : May 29, 2024, 7:23:52 PM
    Author     : ADMIN
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
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
        <div class="container rounded bg-white mt-5 mb-5">
            <div class="row">
                <div class="col-md-3 border-right">
                    <div class="d-flex flex-column align-items-center text-center p-3 py-5"><img class="rounded-circle mt-5" width="150px" src="https://st3.depositphotos.com/15648834/17930/v/600/depositphotos_179308454-stock-illustration-unknown-person-silhouette-glasses-profile.jpg"><span class="font-weight-bold">Edogaru</span><span class="text-black-50">edogaru@mail.com.my</span><span> </span></div>
                </div>
                <div class="col-md-5 border-right">
                    <div class="p-3 py-5">
                        <div class="d-flex justify-content-between align-items-center mb-3">
                            <h4 class="text-right">Profile Settings</h4>
                        </div>
                        <div class="row mt-2">
                            <div class="col-md-6"><label class="labels">UserName</label><input type="text" class="form-control" placeholder="Username" name="username" value="${sessionScope.account.userName}"></div>
                            <div class="col-md-6"><label class="labels">Password</label><input type="password" class="form-control" placeholder="password" name="password" value=""></div>
                        </div>
                        <div class="row mt-3">
                            <div class="col-md-12"><label class="labels">Full Name</label><input type="text" class="form-control" value="${sessionScope.account.fullName}"></div>
                            <div class="col-md-12"><label class="labels">Phone</label><input type="text" class="form-control" value="${sessionScope.account.phone}"></div>
                            <div class="col-md-12"><label class="labels">Address</label><input type="text" class="form-control" value="${sessionScope.account.address}"></div>
                            <div class="col-md-12"><label class="labels">Date of birth</label><input type="text" class="form-control" value="${sessionScope.account.dob}"></div>
                        </div>

                        <div class="mt-5 text-center"><button class="btn btn-primary profile-button" type="button">Save Profile</button></div>
                    </div>
                </div>

            </div>
        </div>
    </div>
</div>
</body>
</html>
