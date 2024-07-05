<%-- 
    Document   : staffWeb-viewInvoice
    Created on : Jun 20, 2024, 12:39:28 PM
    Author     : ADMIN
--%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.4.0/css/all.min.css"
              integrity="sha512-iecdLmaskl7CVkqkXNQ/ZH/XLlvWZOJyj7Yy7tcenmpD1ypASozpmT/E0iPtmFIB46ZmdtAc9eNBvH0H/ZpiBw=="
              crossorigin="anonymous" referrerpolicy="no-referrer" />
        <title>Dental Invoice</title>
        <link rel="stylesheet" href="admin-front-end/css/styleViewInvoice.css">
        <style>
            .warning {
                display: none;
                padding: 10px;
                margin-top: -13px;
                margin-bottom: 15px;
                color: #721c24;
                ${css}
                border-radius: 5px;
                font-weight: bold;
                display: flex;
                align-items: center;
                justify-content: center;
            }

            .warning i {
                margin-right: 10px;
                font-size: 20px;
            }
            .back-link {

                font-size: 16px;
                color: #000;
                margin-bottom: 10px;
                display: inline-block;

            }
            .back-link:hover{
                color: #007BFF;
            }

            .header-container {
                display: flex;
                align-items: center;
                justify-content: space-between;
                margin-bottom: 20px;
            }

            .header-container .header-title {
                text-align: center;
                flex-grow: 1;
            }

            .header-container .header-title i {
                font-size: 80px;
                display: block;
            }

            .header-container .header-title h1 {
                margin: 0;
                font-size: 2em;
            }
        </style>
    </head>
    <body>
        <div class="invoice">
            <div id="warningMessage" class="warning">
                <i class="${icon}"></i>
                ${error}
            </div>
            <div class="header-container">
                <div><a class="back-link" href="StaffViewBooking">Back</a></div>
                <div class="header-title">
                    <i class="fa-solid fa-tooth"></i>
                    <h1>DENTAL INVOICE</h1>
                </div>
            </div>
            <div class="bill-info">
                <div class="bill-from">
                    <h2>Bill From</h2>
                    <p>Name: ${bookingInvoice.fullNameDentist}</p>
                    <p>Company Name: ${clinic.clinicName}</p>
                    <p>Street Address: ${clinic.clinicAddress}</p>
                    <p>City, ST ZIP Code: ${clinic.city}</p>
                    <p>Phone: ${clinic.hotline}</p>
                </div>
                <div class="bill-to">
                    <h2>Bill To</h2>
                    <p>Name: ${customer.fullName}</p>
                    <p>Street Address: ${customer.address}</p>
                    <p>Phone: ${customer.phone}</p>
                </div>
                <div class="invoice-details">
                    <p>Invoice No. ${invoice.invoiceID}</p>
                    <p>Invoice Date: ${invoice.invoiceDate}</p>
                    <c:choose>
                        <c:when test="${invoice.invoiceStatus == 1}">
                            <p>Invoice Status: Complete</p>
                        </c:when>
                        <c:when test="${invoice.invoiceStatus == 0}">
                            <p>Invoice Status: Not complete</p>
                        </c:when>
                        <c:otherwise>
                            Status: Unknown
                        </c:otherwise>
                    </c:choose>
                    <p>Booking ID: ${bookingInvoice.bookingID}</p>
                </div>
            </div>
            <table>
                <thead>
                    <tr>
                        <th>Description</th>
                        <th>Appointment Time/Date</th>
                        <th>Price ($)</th>
                    </tr>
                </thead>
                <tbody>
                    <!-- Example rows -->
                    <tr>
                        <td>${bookingInvoice.service.serviceName}</td>
                        <td>${bookingInvoice.timeSlot.timePeriod} ${bookingInvoice.appointmentDay}</td>
                        <td class="money-format">${bookingInvoice.price}</td>
                    </tr>
                </tbody>
            </table>

            <div class="totals">
                <p class="money-format">Subtotal: ${bookingInvoice.price}</p>
                <p class="money-format">Deposit: ${bookingInvoice.deposit}</p>
                <c:set var="total" value="${bookingInvoice.price - bookingInvoice.deposit}" />
                <p class="money-format">Total: <c:out value="${total}" /></p>
            </div>

            <form style="text-align: right" action="./SendBookingNotificationServlet" method="post">
                <input name="bookingInvoiceID" value="${bookingInvoice.bookingID}" type="hidden" />
                <input name="customerID" value="${customer.accountID}" type="hidden" />
                <input id="exportButton" class="export" type="submit" value="Export" onclick="return checkInvoiceStatus();" /> 
            </form>
            <div class="terms">
                <p>Terms and Conditions</p>
            </div>
        </div>
        <script>
            document.addEventListener('DOMContentLoaded', function () {
                const moneyElements = document.querySelectorAll('.money-format');

                moneyElements.forEach(element => {
                    const text = element.textContent;
                    const amount = text.match(/[\d,.]+/);
                    if (amount) {
                        const moneyValue = parseFloat(amount[0].replace(/,/g, ''));
                        const formattedMoney = new Intl.NumberFormat('vi-VN', {style: 'currency', currency: 'VND'}).format(moneyValue);
                        element.textContent = text.replace(amount[0], formattedMoney);
                    }
                });
            });
        </script>
    </body>
</html>
