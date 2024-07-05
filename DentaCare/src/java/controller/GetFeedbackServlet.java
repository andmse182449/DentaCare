package controller;

import com.google.gson.Gson;
import feedback.FeedbackDAO;
import feedback.FeedbackDTO;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.List;
import java.util.logging.Level;
import java.util.logging.Logger;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

@WebServlet(name = "GetFeedbackServlet", urlPatterns = {"/GetFeedbackServlet"})
public class GetFeedbackServlet extends HttpServlet {

    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        PrintWriter out = response.getWriter();

        // Retrieve the bookingID from the request parameters
        String bookingID = request.getParameter("bookingID");

        // Check if bookingID is valid
        if (bookingID == null || bookingID.isEmpty()) {
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.println("{\"error\": \"Invalid booking ID.\"}");
            return;
        }

        // Initialize DAO and Gson
        FeedbackDAO feedbackDAO = new FeedbackDAO();
        Gson gson = new Gson();

        try {
            // Fetch feedback using the bookingID
            List<FeedbackDTO> feedbackList = feedbackDAO.getFeedbackByBookingID(bookingID);

            // Convert feedbackList to JSON format
            String feedbackJson = gson.toJson(feedbackList);

            // Return the JSON response
            out.print(feedbackJson);
            response.setStatus(HttpServletResponse.SC_OK);
        } catch (SQLException e) {
            Logger.getLogger(GetFeedbackServlet.class.getName()).log(Level.SEVERE, null, e);
            response.setStatus(HttpServletResponse.SC_INTERNAL_SERVER_ERROR);
            out.println("{\"error\": \"An error occurred while fetching feedback.\"}");
        } finally {
            out.close();
        }
    }

    // Override doGet method to handle GET requests
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    // Override doPost method to handle POST requests if needed
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    @Override
    public String getServletInfo() {
        return "Servlet to fetch feedback by booking ID and return as JSON.";
    }
}
