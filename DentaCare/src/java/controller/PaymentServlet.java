/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/JSP_Servlet/Servlet.java to edit this template
 */
package controller;

import com.google.gson.Gson;
import com.google.gson.JsonObject;
import java.io.IOException;
import java.io.PrintWriter;
import java.net.URLEncoder;
import java.nio.charset.StandardCharsets;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Collections;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.TimeZone;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import payment.Config;

/**
 *
 * @author Admin
 */
@WebServlet(name = "PaymentServlet", urlPatterns = {"/PaymentServlet"})
public class PaymentServlet extends HttpServlet {

    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        String vnp_Version = "2.1.0";
                        String vnp_Command = "pay";
                        String orderType = "other";
                        String deposit= request.getParameter("deposit").replaceAll("[^\\d]", "");
                        String price = request.getParameter("price");
                        
                        int amount = Integer.parseInt(deposit) * 100;
                        String clinicID = request.getParameter("clinicID");
                        String serviceID = request.getParameter("serviceID");
                        String slotID = request.getParameter("slotID");
                        String appointmentDay = request.getParameter("appointmentDay");
                        
                        String bankCode = request.getParameter("bankCode");

                        String vnp_TxnRef = Config.getRandomNumber(8);
                        String vnp_IpAddr = Config.getIpAddress(request);

                        String vnp_TmnCode = Config.vnp_TmnCode;                    

                        Map<String, String> vnp_Params = new HashMap<>();
                        vnp_Params.put("vnp_Version", vnp_Version);
                        vnp_Params.put("vnp_Command", vnp_Command);
                        vnp_Params.put("vnp_TmnCode", vnp_TmnCode);
                        vnp_Params.put("vnp_Amount", String.valueOf(amount));
                        vnp_Params.put("vnp_CurrCode", "VND");

                        if (bankCode != null && !bankCode.isEmpty()) {
                            vnp_Params.put("vnp_BankCode", bankCode);
                        }
                        vnp_Params.put("vnp_TxnRef", vnp_TxnRef);
                        vnp_Params.put("vnp_OrderInfo", appointmentDay + " " + price + " " + clinicID + " " + serviceID + " " + slotID);
                        vnp_Params.put("vnp_OrderType", orderType);

                        String locate = request.getParameter("language");
                        if (locate != null && !locate.isEmpty()) {
                            vnp_Params.put("vnp_Locale", locate);
                        } else {
                            vnp_Params.put("vnp_Locale", "vn");
                        }
                        vnp_Params.put("vnp_ReturnUrl", Config.vnp_ReturnUrl);
                        vnp_Params.put("vnp_IpAddr", vnp_IpAddr);

                        Calendar cld = Calendar.getInstance(TimeZone.getTimeZone("Etc/GMT+7"));
                        SimpleDateFormat formatter3 = new SimpleDateFormat("yyyyMMddHHmmss");
                        String vnp_CreateDate = formatter3.format(cld.getTime());
                        vnp_Params.put("vnp_CreateDate", vnp_CreateDate);

                        cld.add(Calendar.MINUTE, 15);
                        String vnp_ExpireDate = formatter3.format(cld.getTime());
                        vnp_Params.put("vnp_ExpireDate", vnp_ExpireDate);

                        List fieldNames = new ArrayList(vnp_Params.keySet());
                        Collections.sort(fieldNames);
                        StringBuilder hashData = new StringBuilder();
                        StringBuilder query = new StringBuilder();
                        Iterator itr = fieldNames.iterator();
                        while (itr.hasNext()) {
                            String fieldName = (String) itr.next();
                            String fieldValue = (String) vnp_Params.get(fieldName);
                            if ((fieldValue != null) && (fieldValue.length() > 0)) {
                                //Build hash data
                                hashData.append(fieldName);
                                hashData.append('=');
                                hashData.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                                //Build query
                                query.append(URLEncoder.encode(fieldName, StandardCharsets.US_ASCII.toString()));
                                query.append('=');
                                query.append(URLEncoder.encode(fieldValue, StandardCharsets.US_ASCII.toString()));
                                if (itr.hasNext()) {
                                    query.append('&');
                                    hashData.append('&');
                                }
                            }
                        }
                        String queryUrl = query.toString();
                        String vnp_SecureHash = Config.hmacSHA512(Config.secretKey, hashData.toString());
                        queryUrl += "&vnp_SecureHash=" + vnp_SecureHash;
                        String paymentUrl = Config.vnp_PayUrl + "?" + queryUrl;
                        com.google.gson.JsonObject job = new JsonObject();
                        job.addProperty("code", "00");
                        job.addProperty("message", "success");
                        job.addProperty("data", paymentUrl);
                        Gson gson = new Gson();
                        response.getWriter().write(gson.toJson(job));
        
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
