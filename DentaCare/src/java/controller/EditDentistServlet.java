package controller;

import account.AccountDAO;
import com.google.gson.Gson;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;

import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.BufferedReader;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.HashMap;
import java.util.Map;
import java.util.logging.Level;
import java.util.logging.Logger;

import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.io.*;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;
/**
 *
 * @author ROG STRIX
 */
@WebServlet(name = "EditDentistServlet", urlPatterns = {"/EditDentistServlet"})
public class EditDentistServlet extends HttpServlet {

    public String getPath() throws UnsupportedEncodingException {
        String path = this.getClass().getClassLoader().getResource("").getPath();
        String fullPath = URLDecoder.decode(path, "UTF-8");
        String pathArr[] = fullPath.split("/build/web/WEB-INF/classes/");
        fullPath = pathArr[0];
        return fullPath;
    }

    private static String removeLeadingSlash(String path) {
        // Check if the path starts with a leading slash and remove it
        if (path.startsWith("/")) {
            return path.substring(1);
        }
        return path;
    }

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

        //account
        String id = jsonInput.get("id");

        String name = jsonInput.get("fullname");
        String dob = jsonInput.get("dob");
        LocalDate localDate = LocalDate.parse(dob);
        String phone = jsonInput.get("phone");
        String image2 = jsonInput.get("image");

        Part filePart = request.getPart("edit-image");
        System.out.println(filePart);

        String gender = jsonInput.get("gender");
        boolean gen = false;
        if (gender.equalsIgnoreCase("male")) {
            gen = true;
        }
        String address = jsonInput.get("address");
        String bio = jsonInput.get("bio");
        // clinic
        String clinicID = jsonInput.get("clinic");

        AccountDAO denDAO = new AccountDAO();
        try {

            denDAO.updateDentist(name, phone, address, localDate, gen, image2, Integer.parseInt(clinicID), id);
            denDAO.updateDentistBio(bio, id);

        } catch (SQLException e) {
            Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, e);
        }

        // Prepare the response data
        Map<String, Object> responseData = new HashMap<>();
        responseData.put("success", true);
//        responseData.put("comment", commentText);

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
