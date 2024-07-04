package controller;

import account.AccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.Part;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.time.LocalDate;
import java.util.logging.Level;
import java.util.logging.Logger;

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
        String id = request.getParameter("edit-id");
        String name = request.getParameter("edit-fullname");
        String dob = request.getParameter("edit-dob");
        LocalDate localDate = LocalDate.parse(dob);
        String phone = request.getParameter("edit-phone");
        String gender = request.getParameter("edit-gender");
        boolean gen = false;
        if (gender.equalsIgnoreCase("male")) {
            gen = true;
        }
        String address = request.getParameter("edit-address");
        String bio = request.getParameter("edit-bio");
        String clinicID = request.getParameter("clinic");
        Part filePart = request.getPart("edit-image");

        try (PrintWriter out = response.getWriter()) {
            String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();
            String correctedPath = removeLeadingSlash(getPath());
//                System.out.println("File name: " + correctedPath + "/web/images/" + fileName);
            AccountDAO denDAO = new AccountDAO();
            System.out.println("name: " +name + ", " 
                    + "phone: " + phone + ", " 
                    + "address: " + address + ", " 
                    + "localDate: " + localDate + ", " 
                    + "gen: " + gen + ", " 
                    + "fileName: " + fileName + ", " 
                    + "clinicID: " + Integer.parseInt(clinicID) + ", " 
                    + "id: " + id);
            try {

                denDAO.updateDentist(name, phone, address, localDate, gen, fileName, Integer.parseInt(clinicID), id);
                denDAO.updateDentistBio(bio, id);
                filePart.write(correctedPath + "/web/images/" + fileName);
//                 request.getRequestDispatcher("ForDentistInfo?action=forward").forward(request, response);
                 response.sendRedirect("ForDentistInfo?action=edit&denID=" + id);
            } catch (SQLException e) {
                Logger.getLogger(CommentServlet.class.getName()).log(Level.SEVERE, null, e);
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
