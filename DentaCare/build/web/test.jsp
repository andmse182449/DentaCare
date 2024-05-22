<%-- 
    Document   : test
    Created on : May 20, 2024, 12:14:47 PM
    Author     : ROG STRIX
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/4.7.0/css/font-awesome.min.css">
        <link rel="stylesheet" href="css/alert.css">
    </head>

    <body>
        <div class='content'>
            <div class="alert alert-success alert-white rounded">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <div class="icon"><i class="fa fa-check"></i></div>
                <strong>Success!</strong> Changes has been saved successfully!
            </div>
            <div class="alert alert-info alert-white rounded">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <div class="icon"><i class="fa fa-info-circle"></i></div>
                <strong>Info!</strong> You have 3 new messages in your inbox.
            </div>
            <div class="alert alert-warning alert-white rounded">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
                <div class="icon"><i class="fa fa-warning"></i></div>
                <strong>Alert!</strong> Don't forget to save your data.
            </div>
            <div class="alert alert-danger alert-white rounded">
                <button type="button" class="close" data-dismiss="alert" aria-hidden="true">×</button>
               <i class="fa fa-times-circle"></i>
                <strong>Error!</strong> The server is not responding, try again later.
            </div>
        </div>
    </body>
</html>
