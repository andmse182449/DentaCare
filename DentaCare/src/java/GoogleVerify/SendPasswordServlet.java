package GoogleVerify;

import Token.TokenGenerator;
import account.AccountDAO;
import account.AccountDTO;
import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SendPasswordServlet", urlPatterns = {"/SendPasswordServlet"})
public class SendPasswordServlet extends HttpServlet {

    final String subject = "[DentaCare] Reset Password ";
    private static final long TOKEN_EXPIRATION_TIME = 60000;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String mail_raw = request.getParameter("mail");
        AccountDAO d = new AccountDAO();
        AccountDTO account = d.findAccountByEmail(mail_raw);

        try {
            if (account == null) {
                request.setAttribute("error", "Your email has not been registered !");
            } else {
                String token = TokenGenerator.generateToken(TOKEN_EXPIRATION_TIME);
                String link = "http://localhost:8080/DentistBooking/ForgetPasswordServlet?key=" + mail_raw + "&action=changePage" + "&token=" + token;
                String body = "<!DOCTYPE html>"
                        + "<html>"
                        + "<head>"
                        + "<style>"
                        + "body { font-family: Arial, sans-serif; font-size: 16px; color: #333; height: 100vh; margin: 0; background-color: #f4f4f4; display: flex; align-items: center; justify-content: center; }"
                        + ".button-link { background-color: #007bff; color: #fff; text-decoration: none; padding: 10px 20px; display: inline-block; border-radius: 5px; }"
                        + ".button-link:hover { background-color: #0056b3; color: #fff;}"
                        + "</style>"
                        + "</head>"
                        + "<body>"
                        + "<div class=''>"
                        + "Hello,<br><br>"
                        + "You have requested to reset your password. Please click the button below to reset your password:<br><br>"
                        + "<a class='button-link' style='color: #fff' href='" + link + "'>Reset Password</a>"
                        + "<br><br>"
                        + "If you did not request a password reset, please ignore this email.<br><br>"
                        + "Thank you,<br>"
                        + "DentaCare"
                        + "</div>"
                        + "</body>"
                        + "</html>";

                SendEmail send = new SendEmail(account.getEmail(), subject, body);
                request.setAttribute("sendEmail", send);
                request.setAttribute("email", mail_raw);
                request.setAttribute("success", "Please check your Email for further information !");
            }
            // Correctly forward to the JSP page
            request.getRequestDispatcher("forgetPassword.jsp").forward(request, response);
        } catch (Exception e) {
            // Log the error for debugging
            e.printStackTrace();
            // Optionally, forward to an error page
            request.setAttribute("error", "An error occurred while processing your request.");
            request.getRequestDispatcher("error.jsp").forward(request, response);
        }
    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
