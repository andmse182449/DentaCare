/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package payment;

import java.time.LocalDate;

/**
 *
 * @author Admin
 */
public class PaymentDTO {
    private String paymentID;
    private float amount;
    private String orderInfo;
    private int responseCode;
    private String transactionNo;
    private String bankCode;
    private LocalDate paymentDay;
    private String bookingID;

    public PaymentDTO(String paymentID, float amount, String orderInfo, int responseCode, String transactionNo, String bankCode, LocalDate paymentDay, String bookingID) {
        this.paymentID = paymentID;
        this.amount = amount;
        this.orderInfo = orderInfo;
        this.responseCode = responseCode;
        this.transactionNo = transactionNo;
        this.bankCode = bankCode;
        this.paymentDay = paymentDay;
        this.bookingID = bookingID;
    }

    public PaymentDTO() {
    }

    public String getPaymentID() {
        return paymentID;
    }

    public void setPaymentID(String paymentID) {
        this.paymentID = paymentID;
    }

    public float getAmount() {
        return amount;
    }

    public void setAmount(float amount) {
        this.amount = amount;
    }

    public String getOrderInfo() {
        return orderInfo;
    }

    public void setOrderInfo(String orderInfo) {
        this.orderInfo = orderInfo;
    }

    public int getResponseCode() {
        return responseCode;
    }

    public void setResponseCode(int responseCode) {
        this.responseCode = responseCode;
    }

    public String getTransactionNo() {
        return transactionNo;
    }

    public void setTransactionNo(String transactionNo) {
        this.transactionNo = transactionNo;
    }

    public String getBankCode() {
        return bankCode;
    }

    public void setBankCode(String bankCode) {
        this.bankCode = bankCode;
    }

    public LocalDate getPaymentDay() {
        return paymentDay;
    }

    public void setPaymentDay(LocalDate paymentDay) {
        this.paymentDay = paymentDay;
    }

    public String getBookingID() {
        return bookingID;
    }

    public void setBookingID(String bookingID) {
        this.bookingID = bookingID;
    }

    @Override
    public String toString() {
        return "PaymentDTO{" + "paymentID=" + paymentID + ", amount=" + amount + ", orderInfo=" + orderInfo + ", responseCode=" + responseCode + ", transactionNo=" + transactionNo + ", bankCode=" + bankCode + ", paymentDay=" + paymentDay + ", bookingID=" + bookingID + '}';
    }
    
    
}