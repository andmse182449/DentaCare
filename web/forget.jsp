<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">

        <!-- ===== Iconscout CSS ===== -->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

        <!-- ===== CSS ===== -->
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Forget Password</title>
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
                        <li class="nav-item"><a href="about.html" class="nav-link" style="color: black">About</a></li>
                        <li class="nav-item"><a href="services.html" class="nav-link" style="color: black">Services</a></li>
                        <li class="nav-item"><a href="doctors.html" class="nav-link" style="color: black">Doctors</a></li>
                        <li class="nav-item"><a href="blog.html" class="nav-link" style="color: black">Blog</a></li>
                        <li class="nav-item"><a href="contact.html" class="nav-link" style="color: black">Contact</a></li>
                        <li class="nav-item cta"><a href="login.jsp" class="nav-link show-popup" data-target="#modalRequest">Log in</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container-login">
            <div class="forms">
                <div class="form login">
                    <span class="title">Forget Password</span>

                    <form action="#">

                        <div class="input-field">
                            <input type="text" placeholder="Enter your email" required>
                            <i class="uil uil-envelope icon"></i>
                        </div>
                        <div class="login-signup">
                            <span class="text">Already a member?
                                <a href="login.jsp" class="text">Login Now</a>
                            </span>
                        </div>

                        <div class="input-field button">
                            <input type="button" value="Send">
                        </div>
                    </form>
                </div>s
            </div>
        </div>

        <script src="js/login.js"></script>
    </body>
</html>