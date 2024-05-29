/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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

/**
 *
 * @author Admin
 */
public class SendDentistAccountServlet extends HttpServlet {
    private static final long TOKEN_EXPIRATION_TIME = 60000;
    final String subject = "[DentaCare] Login Account Information";
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String mail_raw = request.getParameter("mail");
        AccountDAO dao = new AccountDAO();
        AccountDTO account = null;

        try {
            if (account == null) {
                request.setAttribute("error", "Your email has not been registered !");
            } else {
                String token = TokenGenerator.generateToken(TOKEN_EXPIRATION_TIME);
                String link = "<a href='http://localhost:8080/DentistBooking/ForgetPasswordServlet?key=" + mail_raw + "&action=changePage" + "&token=" + token + "' style='color: #007bff; text-decoration: none;'>Reset Password</a>";
                String link2 = "http://localhost:8080/DentistBooking/ForgetPasswordServlet?key=" + mail_raw + "&action=changePage" + "&token=" + token;
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
                        + "<a class='button-link' style='color: #fff' href='" + link2 + "'>Reset Password</a>"
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

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}
