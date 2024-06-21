package controller; // Ensure this matches your package structure

import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.google.gson.*;
import java.util.List;
import booking.BookingDTO;
import booking.BookingDAO;
import jakarta.servlet.annotation.WebServlet;

@WebServlet(name = "GetBookServlet", urlPatterns = {"/GetBookServlet"})
public class GetBookServlet extends HttpServlet {

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
        response.setContentType("application/json");
        response.setCharacterEncoding("UTF-8");
        response.setHeader("Access-Control-Allow-Origin", "*");
        response.setHeader("Access-Control-Allow-Methods", "POST, GET, OPTIONS, DELETE");
        response.setHeader("Access-Control-Max-Age", "3600");
        response.setHeader("Access-Control-Allow-Headers", "Content-Type, Access-Control-Allow-Headers, Authorization, X-Requested-With");
        PrintWriter out = response.getWriter();
        Gson gson = new Gson();

        try {
            // Read JSON payload from the request
            BufferedReader reader = request.getReader();
            JsonObject jsonObject = gson.fromJson(reader, JsonObject.class);
            String selectedDate = jsonObject.get("selectedDate").getAsString();

            // Get the booking list
            BookingDAO bDAO = new BookingDAO();
            List<BookingDTO> res = bDAO.getAllBookingList();

            // Create a JSON response object
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("status", "success");
            jsonResponse.addProperty("message", "Date received: " + selectedDate);

            // Convert the booking list to JSON and add it to the response
            JsonArray bookingsArray = gson.toJsonTree(res).getAsJsonArray();
            jsonResponse.add("bookings", bookingsArray);

            // Send the JSON response back to the client
            out.print(jsonResponse.toString());
        } catch (Exception e) {
            e.printStackTrace();
            JsonObject errorResponse = new JsonObject();
            errorResponse.addProperty("status", "error");
            errorResponse.addProperty("message", "Failed to process request: " + e.getMessage());
            response.setStatus(HttpServletResponse.SC_BAD_REQUEST);
            out.print(errorResponse.toString());
        } finally {
            out.flush();
        }
    }
}
