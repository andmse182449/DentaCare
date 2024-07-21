package GoogleVerify;

import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "SendEmailServlet", urlPatterns = {"/SendEmailServlet"})
public class SendEmailServlet extends HttpServlet {

    final String subject = "[DentaCare] Register Account";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String mail_raw = request.getParameter("mail");

        try {
                String link = "http://localhost:8080/DentistBooking/RegisterServlet?key=" + mail_raw + "&action=verify";
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
                        + "You have requested to register your account. Please click the button below to access register page:<br><br>"
                        + "<a class='button-link' style='color: #fff' href='" + link + "'>Register Account</a>"
                        + "<br><br>"
                        + "If you did not request your account registered, please ignore this email.<br><br>"
                        + "Thank you,<br>"
                        + "DentaCare"
                        + "</div>"
                        + "</body>"
                        + "</html>";

                SendEmail send = new SendEmail(mail_raw, subject, body);
                request.setAttribute("sendEmail", send);
                request.setAttribute("email", mail_raw);
                request.setAttribute("success", "Please check your Email for further information !");
            
            request.getRequestDispatcher("userWeb-verifyEmail.jsp").forward(request, response);
        } catch (ServletException | IOException e) {
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
