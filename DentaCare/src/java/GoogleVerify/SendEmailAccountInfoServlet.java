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
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

/**
 *
 * @author Admin
 */
public class SendEmailAccountInfoServlet extends HttpServlet {

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
        String mail_raw = (String) request.getAttribute("mail");
        AccountDAO dao = new AccountDAO();
        AccountDTO account = dao.findAccountByEmail(mail_raw);
        System.out.println(account.toString());
        String verify_code_page = "";
        if (account.getRoleID()== 1) {
            verify_code_page = "1234";
        } else if (account.getRoleID() == 2) {
            verify_code_page = "4321";
        }
        try {
            if (account == null) {
                request.setAttribute("error", "Your email has not been registered !");
            } else {
                String token = TokenGenerator.generateToken(TOKEN_EXPIRATION_TIME);
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
                        + "Hello " + account.getFullName() + ",<br><br>"
                        + "You have been registered an account in our DentaCare system.<br><br>"
                        + "Here is your account information:"
                        + "<br>"
                        + "\t - Username: " + account.getUserName() + "<br>"
                        + "\t - Password: " + "abc@demo" + "<br>"
                        + "\t - Verify Code page: " + verify_code_page
                        + "<br><br>"
                        + "Remember to change your password on the firs time login.<br>"
                        + "For security reasons, do not share information with anyone<br><br>"
                        + "Thank you,<br>"
                        + "DentaCare"
                        + "</div>"
                        + "</body>"
                        + "</html>";

                SendEmail send = new SendEmail(account.getEmail(), subject, body);
                request.setAttribute("message", "Create successfully!");
            }
            // Correctly forward to the JSP page
            request.getRequestDispatcher("coWeb-dentist.jsp").forward(request, response);
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
