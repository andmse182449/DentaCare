<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <link rel="icon" href="images/logo_dentist.jpg" type="image/png">
        <!-- ===== Iconscout CSS ===== -->
        <link rel="stylesheet" href="https://unicons.iconscout.com/release/v4.0.0/css/line.css">

        <!-- ===== CSS ===== -->
        <link rel="stylesheet" href="css/login.css">
        <link rel="stylesheet" href="css/style.css">
        <title>Log in</title>
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
                        <li class="nav-item cta"><a href="#" class="nav-link show-popup" data-target="#modalRequest">Log in</a></li>
                    </ul>
                </div>
            </div>
        </nav>
        <div class="container-login">
            <div class="forms">
                <div class="form login">
                    <span class="title">Login</span>

                    <form action="#">

                        <div class="input-field">
                            <input type="text" placeholder="Enter your email" required>
                            <i class="uil uil-envelope icon"></i>
                        </div>



                        <div class="input-field">
                            <input type="password" class="password" placeholder="Enter your password" required>
                            <i class="uil uil-lock icon"></i>
                            <i class="uil uil-eye-slash showHidePw"></i>
                        </div>

                        <div class="checkbox-text">
                            <div class="checkbox-content">
                                <input type="checkbox" id="logCheck">
                                <label for="logCheck" class="text">Remember me</label>
                            </div>

                            <a href="forget.jsp" class="text">Forgot password?</a>
                        </div>

                        <div class="input-field button">
                            <input type="button" value="Login">
                        </div>
                    </form>

                    <div class="line"></div>

                    <div class="media-options">
                        <a href="#" class="field google">
                            <img style="width:30px;height:30px; margin-right: 10px" src="images/Google__G__logo.svg.png" alt=""/>
                            <span>Login with Google</span>
                        </a>
                    </div>



                    <div class="login-signup">
                        <span class="text">Not a member?
                            <a href="#" class="text signup-link">Signup Now</a>
                        </span>
                    </div>
                </div>

                <!-- Registration Form -->
                <div class="form signup">
                    <span class="title">Registration</span>

                    <form action="#">
                        <div class="input-field">
                            <input type="text" placeholder="Enter your name" required>
                            <i class="uil uil-user"></i>
                        </div>
                        <div class="input-field">
                            <input type="text" placeholder="Enter your email" required>
                            <i class="uil uil-envelope icon"></i>
                        </div>
                        <div class="input-field">
                            <input type="password" class="password" placeholder="Create a password" required>
                            <i class="uil uil-lock icon"></i>
                        </div>
                        <div class="input-field">
                            <input type="password" class="password" placeholder="Confirm a password" required>
                            <i class="uil uil-lock icon"></i>
                            <i class="uil uil-eye-slash showHidePw"></i>
                        </div>

                        <div class="checkbox-text">
                            <div class="checkbox-content">
                                <input type="checkbox" id="termCon">
                                <label for="termCon" class="text">I accepted all terms and conditions</label>
                            </div>
                        </div>

                        <div class="input-field button">
                            <input type="button" value="Signup">
                        </div>
                    </form>

                    <div class="login-signup">
                        <span class="text">Already a member?
                            <a href="#" class="text login-link">Login Now</a>
                        </span>
                    </div>
                </div>
            </div>
        </div>

        <script src="js/login.js"></script>
    </body>
</html>