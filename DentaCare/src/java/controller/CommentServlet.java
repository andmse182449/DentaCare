/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import account.AccountDTO;
import com.google.gson.Gson;
import feedback.FeedbackDAO;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import java.io.BufferedReader;
import java.io.IOException;
import java.sql.SQLException;
import java.time.LocalDateTime;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;
/**
 *
 * @author ROG STRIX
 */
@WebServlet(name = "CommentServlet", urlPatterns = {"/CommentServlet"})
public class CommentServlet extends HttpServlet {

    private String generateUniqueFeedbackID() {
        // Your logic to generate a unique feedback ID
        return "FB-" + System.currentTimeMillis(); // Simple example using current time
    }
//    private static final long serialVersionUID = 1L;

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");

        // Read JSON data from request body
        StringBuilder sb = new StringBuilder();
        try (BufferedReader reader = request.getReader()) {
            String line;
            while ((line = reader.readLine()) != null) {
                sb.append(line);
            }
        } catch (IOException e) {
            e.printStackTrace();
        }

        // Parse JSON string to a Java object using Gson
        Gson gson = new Gson();
        Map<String, String> jsonInput = gson.fromJson(sb.toString(), Map.class);

        String commentText = jsonInput.get("comment");
        String fbID = generateUniqueFeedbackID();
        HttpSession session = request.getSession();
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        AccountDTO account = (AccountDTO) session.getAttribute("account");
        try {

            if (feedbackDAO.addComment(fbID, LocalDateTime.now() , commentText, account.getAccountID()) == true) {
                System.out.println("oke em iu");
            } else {
                System.out.println("như");
            }
        } catch (SQLException ex) {
            Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, ex);
        }

        // Prepare the response data
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("success", true);
        responseData.put("comment", commentText);

        // Convert the response data to JSON
        String jsonResponse = gson.toJson(responseData);

        // Send the JSON response
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse);
            out.flush();
        } catch (IOException e) {
            e.printStackTrace();
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
    }// </editor-fold>

}
