/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
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
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

/**
 *
 * @author ROG STRIX
 */
@WebServlet(name = "EditDentistServlet", urlPatterns = {"/EditDentistServlet"})
public class EditDentistServlet extends HttpServlet {

    private static final long serialVersionUID = 1L;

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
        String image = "Bs-Nguyen-Xuan-Nhi.png";

        // Get the upload directory path relative to the web application context
        String appPath = request.getServletContext().getRealPath("");
        String savePath = "/build/web/images/" + image;

        // Create the directory if it does not exist
        File fileSaveDir = new File(savePath);
        if (!fileSaveDir.exists()) {
            fileSaveDir.mkdirs();
        }

        // Process the uploaded file
        for (Part part : request.getParts()) {
            String fileName = extractFileName(part);
            if (fileName != null && !fileName.isEmpty()) {
                // Write the file to the specified directory
                try (InputStream fileContent = part.getInputStream(); FileOutputStream fos = new FileOutputStream(new File(savePath + File.separator + fileName))) {
                    int read;
                    final byte[] bytes = new byte[1024];
                    while ((read = fileContent.read(bytes)) != -1) {
                        fos.write(bytes, 0, read);
                    }
                    response.getWriter().println("File uploaded successfully: " + fileName);
                } catch (IOException e) {
                    response.getWriter().println("Error saving file: " + e.getMessage());
                }
            }
        }

        String gender = jsonInput.get("gender");
        boolean gen = false;
        if (gender.equalsIgnoreCase("male")) {
            gen = true;
        }
        String address = jsonInput.get("address");
        // major detail
//        String specialty = jsonInput.get("specialty");
        String bio = jsonInput.get("bio");
        // clinic
        String clinicID = jsonInput.get("clinic");

        AccountDAO denDAO = new AccountDAO();
        try {

            if (denDAO.updateDentist(name, phone, address, localDate, gen, image, Integer.parseInt(clinicID), id) && denDAO.updateDentistBio(bio, id) == true) {
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

    private String extractFileName(Part part) {
        String contentDisp = part.getHeader("content-disposition");
        String[] items = contentDisp.split(";");
        for (String s : items) {
            if (s.trim().startsWith("filename")) {
                return s.substring(s.indexOf("=") + 2, s.length() - 1);
            }
        }
        return null;
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
