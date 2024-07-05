
import account.AccountDAO;
import account.AccountDTO;
import account.Encoder;
import account.StaffAccountDAO;
import java.io.IOException;
import java.io.PrintWriter;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.MultipartConfig;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;
import jakarta.servlet.http.Part;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.nio.file.Paths;
import java.sql.SQLException;
import java.time.LocalDate;
import java.time.format.DateTimeFormatter;
import java.time.format.DateTimeParseException;
import java.util.logging.Level;
import java.util.logging.Logger;

@WebServlet(name = "ProfileStaffServlet", urlPatterns = {"/ProfileStaffServlet"})
@MultipartConfig // This annotation enables file uploads
public class ProfileStaffServlet extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            String action = request.getParameter("action");
            HttpSession session = request.getSession();
            StaffAccountDAO dao = new StaffAccountDAO();
            AccountDAO accountDao = new AccountDAO();
            if (action == null) {
                session.getAttribute("account");
                request.getRequestDispatcher("staffWeb-ProfileStaff.jsp").forward(request, response);
            } else if (action.equals("updateProfileStaff")) {
                String accountId = request.getParameter("accountId");
                String userName = request.getParameter("username");
                String fullName = request.getParameter("fullName");
                String phone = request.getParameter("phone");
                String address = request.getParameter("address");
                String dobStr = request.getParameter("dob");
                String genderStr = request.getParameter("gender");
                boolean gender = "Male".equals(genderStr);
                String email = request.getParameter("email");
                Part filePart = request.getPart("edit-image");
                String fileName = Paths.get(filePart.getSubmittedFileName()).getFileName().toString();

                String correctedPath = removeLeadingSlash(getPath());

                // If no new file is uploaded, use the existing image
                if (fileName.isEmpty()) {
                    AccountDTO currentAccount = (AccountDTO) session.getAttribute("account");
                    fileName = currentAccount.getImage();
                } else {
                    try {
                        filePart.write(correctedPath + "/web/images/" + fileName);
                    } catch (IOException e) {
                        e.printStackTrace();
                        response.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, "Error writing file: " + e.getMessage());
                        return;
                    }
                }

                if (phone == null || address == null || dobStr == null) {
                    phone = "";
                    address = "";
                    dobStr = "";
                }
                LocalDate dob = null;
                if (dobStr != null && !dobStr.isEmpty()) {
                    try {
                        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("dd/MM/yyyy");
                        dob = LocalDate.parse(dobStr, formatter);
                    } catch (DateTimeParseException e) {
                        try {
                            DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyyy-MM-dd");
                            dob = LocalDate.parse(dobStr, formatter);
                        } catch (DateTimeParseException ex) {
                            ex.printStackTrace();
                        }
                    }
                }

                AccountDTO staff = new AccountDTO();
                staff.setAccountID(accountId);
                staff.setUserName(userName);
                staff.setFullName(fullName);
                staff.setPhone(phone);
                staff.setAddress(address);
                staff.setDob(dob);
                staff.setGender(gender);
                staff.setImage(fileName);
                staff.setEmail(email);
                dao.UpdateProfileStaff(staff);

                session.setAttribute("account", staff);
                request.getRequestDispatcher("staffWeb-ProfileStaff.jsp").forward(request, response);
            } else if (action.equals("changePassword")) {
                request.getRequestDispatcher("staffWeb-ChangePassword.jsp").forward(request, response);
            } else if (action.equals("updatePassword")) {
                AccountDTO staff = (AccountDTO) session.getAttribute("account");
                Encoder encoder = new Encoder();
                String oldPassword = request.getParameter("oldPassword");
                String newPassword1 = request.getParameter("newPassword1");
                String newPassword2 = request.getParameter("newPassword2");

                if (oldPassword == null || newPassword1 == null || newPassword2 == null) {
                    String error = "Fill all fields";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("ProfileStaffServlet?action=changePassword").forward(request, response);
                    return;
                }

                if (!encoder.encode(oldPassword).equals(staff.getPassword())) {
                    String error = "Old password is incorrect";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("ProfileStaffServlet?action=changePassword").forward(request, response);
                    return;
                }

                if (!newPassword1.equals(newPassword2)) {
                    String error = "New passwords do not match";
                    request.setAttribute("error", error);
                    request.getRequestDispatcher("ProfileStaffServlet?action=changePassword").forward(request, response);
                    return;
                }

                accountDao.changePasswordFirstLogin(newPassword1, staff.getAccountID());
                request.setAttribute("error", "Update Password Successfully");
                request.getRequestDispatcher("ProfileStaffServlet?action=changePassword").forward(request, response);
            }
            System.out.println(action);
        }

    }

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProfileStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(ProfileStaffServlet.class.getName()).log(Level.SEVERE, null, ex);
        }
    }

    @Override
    public String getServletInfo() {
        return "Short description";
    }
}
