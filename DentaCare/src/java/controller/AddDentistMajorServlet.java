package controller;

import com.google.gson.Gson;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import major.MajorDAO;
import major.MajorDTO;

import java.io.BufferedReader;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "AddDentistMajorServlet", urlPatterns = {"/AddDentistMajorServlet"})
public class AddDentistMajorServlet extends HttpServlet {

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
        }

        // Parse JSON string to a Java object using Gson
        Gson gson = new Gson();
        Map<String, String> jsonInput = gson.fromJson(sb.toString(), Map.class);

        // Get the majorName from the parsed JSON
//        String majorName = jsonInput.get("dentistNames");
        String accountID = jsonInput.get("tagId");
        String major = jsonInput.get("majorName");

        MajorDAO mdao = new MajorDAO();

        List<MajorDTO> res = new ArrayList<>();
        List<MajorDTO> denLeft = new ArrayList<>();

        // Prepare response data
        Map<String, Object> responseData = new HashMap<>();

        if (accountID == null || accountID.isEmpty()) {
            // Validate input and handle the case where majorName is missing or empty
            responseData.put("success", false);
            responseData.put("message", "Major name is required.");
        } else {
            try {
                int mid = mdao.getMajorByName(major);
                mdao.addNewDenMajor(mid, accountID);

                res = mdao.getAllDenByMajors(major);
                denLeft = mdao.getAllDenNotByMajors(major);

                responseData.put("success", true);
//                responseData.put("majorName", majorName);
                responseData.put("dentist", res); // Add the list of results to the response
                responseData.put("Notdentist", denLeft);
            } catch (SQLException ex) {
                Logger.getLogger(ViewDentistServlet.class.getName()).log(Level.SEVERE, null, ex);
                responseData.put("success", false);
                responseData.put("message", "SQL error: " + ex.getMessage());
            }
        }

        // Convert the response data to JSON
        String jsonResponse = gson.toJson(responseData);

        // Send the JSON response
        try (PrintWriter out = response.getWriter()) {
            out.print(jsonResponse);
            out.flush();
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
