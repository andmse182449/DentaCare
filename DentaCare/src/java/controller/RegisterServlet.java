package controller;

import account.AccountDAO;
import account.AccountDTO;
import java.io.IOException;
import jakarta.servlet.ServletException;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.sql.SQLException;
import java.time.Year;
import java.util.logging.Level;
import java.util.logging.Logger;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class RegisterServlet extends HttpServlet {

    private static final String regex = "^[a-zA-Z0-9_+&*-]+(?:\\.[a-zA-Z0-9_+&*-]+)*@(?:[a-zA-Z0-9-]+\\.)+[a-zA-Z]{2,7}$";

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        String mail = request.getParameter("key");
        String action = request.getParameter("action");
        HttpSession session = request.getSession();
        boolean res = false;
        String url = "login.jsp";
        try {
            AccountDAO accountDAO = new AccountDAO();
            if (action.equalsIgnoreCase("verify")) {
                AccountDAO d = new AccountDAO();
                AccountDTO account = d.findAccountByEmail(mail);
                if (account == null) {
                    request.setAttribute("ac", " active");
                    request.setAttribute("email", mail);
                } else {
                    url = "error.jsp";
                }
                request.getRequestDispatcher(url).forward(request, response);
            } else if (action.equalsIgnoreCase("checkEmail")) {
                Pattern pattern = Pattern.compile(regex);
                Matcher matcher = pattern.matcher(mail);
                boolean chk = matcher.matches() == ("invalid".equals("invalid"));
                if (mail.equalsIgnoreCase(accountDAO.checkExistEmail(mail))) {
                    request.setAttribute("error", "Email registed !");
                    request.setAttribute("ac", " active");
                    url = "userWeb-verifyEmail.jsp";
                } else if (chk == false) {
                    request.setAttribute("error", "Email is invalid !");
                    request.setAttribute("ac", " active");
                    url = "userWeb-verifyEmail.jsp";
                } else {
                    url = "SendEmailServlet?mail=" + mail;
                }
                request.getRequestDispatcher(url).forward(request, response);
            } else if (action.equalsIgnoreCase("register")) {
                String username = request.getParameter("register-name");
                String pass = request.getParameter("register-pass");
                int numOfUsers = accountDAO.countUserAccount();
                AccountDTO existed = accountDAO.checkExistAccount(username, pass);
                if (existed == null) {
                    String accountId = "CUS" + Year.now().getValue() % 100 + String.format("%05d", numOfUsers + 1);
                    AccountDTO newAccount = accountDAO.createAnNormalAccount(username, pass, mail, accountId);
                    session.setAttribute("account", newAccount);
                    request.setAttribute("success", "Registered Successfully!");
                } else {
                    res = true;
                }
                if (res == true) {
                    request.setAttribute("error", "User Name existed !");
                    request.setAttribute("ac", " active");
                }
                request.getRequestDispatcher(url).forward(request, response);
            }
        } catch (SQLException ex) {
            Logger.getLogger(RegisterServlet.class.getName()).log(Level.SEVERE, null, ex);
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
