/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package invoice;

import java.util.Date;

/**
 *
 * @author ADMIN
 */
public class InvoiceDTO {
    private String invoiceID;
    private Date invoiceDate;
    private int invoiceStatus;

    public InvoiceDTO(String invoiceID, Date invoiceDate, int invoiceStatus) {
        this.invoiceID = invoiceID;
        this.invoiceDate = invoiceDate;
        this.invoiceStatus = invoiceStatus;
    }

    public InvoiceDTO() {
    }

    public String getInvoiceID() {
        return invoiceID;
    }

    public Date getInvoiceDate() {
        return invoiceDate;
    }

    public int getInvoiceStatus() {
        return invoiceStatus;
    }

    public void setInvoiceID(String invoiceID) {
        this.invoiceID = invoiceID;
    }

    public void setInvoiceDate(Date invoiceDate) {
        this.invoiceDate = invoiceDate;
    }

    public void setInvoiceStatus(int invoiceStatus) {
        this.invoiceStatus = invoiceStatus;
    }

    
}
