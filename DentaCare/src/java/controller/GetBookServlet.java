package controller; // Ensure this matches your package structure

import account.AccountDTO;
import java.io.*;
import jakarta.servlet.*;
import jakarta.servlet.http.*;
import com.google.gson.*;
import java.util.List;
import booking.BookingDTO;
import booking.BookingDAO;
import jakarta.servlet.annotation.WebServlet;
import java.util.Map;

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
        HttpSession session = request.getSession();
        AccountDTO account = (AccountDTO) session.getAttribute("account");
        System.out.println(account);
        try {
            BufferedReader reader = request.getReader();
            JsonObject jsonObject = gson.fromJson(reader, JsonObject.class);
            String selectedDate = jsonObject.get("selectedDate").getAsString();

            BookingDAO bDAO = new BookingDAO();
            List<Map<String, Object>> getAllBookingForDen = bDAO.getAllBookingForDen2(account.getAccountID(), selectedDate);
            JsonObject jsonResponse = new JsonObject();
            jsonResponse.addProperty("status", "success");
            jsonResponse.addProperty("message", "Date received: " + selectedDate);

            JsonArray bookingsArray = gson.toJsonTree(getAllBookingForDen).getAsJsonArray();
            jsonResponse.add("bookings", bookingsArray);

            System.out.println("JSON Response: " + jsonResponse.toString());

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
