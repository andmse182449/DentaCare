/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.File;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Paths;
import java.util.Collection;
import java.util.UUID;

/**
 *
 * @author ROG STRIX
 */
@WebServlet(name = "UploadImage", urlPatterns = {"/UploadImage"})
@MultipartConfig
public class UploadImage extends HttpServlet {

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
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {

            try {
                Part filePart = request.getPart("edit-image");
                System.out.println(filePart);
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
                System.out.println(fileName);
//                String uploadPath = getServletContext().getRealPath("") + File.separator;
//                System.out.println(uploadPath);
//                File uploadDir = new File(uploadPath);

                String correctedPath = removeLeadingSlash(getPath());
//                System.out.println("File uploadPath: " + uploadPath);
                System.out.println("File name: " + correctedPath +  "/web/images/"+  fileName);
                filePart.write(correctedPath +  "/web/images/"+ fileName);
            } catch (Exception e) {
                out.println("Error: " + e.getMessage());
                e.printStackTrace(new PrintWriter(out));
            }
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
