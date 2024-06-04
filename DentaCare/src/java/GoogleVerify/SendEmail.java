package GoogleVerify;

import java.util.Date;
import java.util.Properties;
import javax.mail.Authenticator;
import javax.mail.Message;
import javax.mail.MessagingException;
import javax.mail.PasswordAuthentication;
import javax.mail.Session;
import javax.mail.Transport;
import javax.mail.internet.InternetAddress;
import javax.mail.internet.MimeMessage;
import javax.mail.internet.MimeBodyPart;
import javax.mail.internet.MimeMultipart;
import javax.mail.Multipart;

public class SendEmail {

    final String senderEmail = "andmse182449@fpt.edu.vn";
    final String senderPassword = "mavo rmkz xmpf xelw";
    final String emailSMTPserver = "smtp.gmail.com";
    final String emailServerPort = "587";
    String receiverEmail = null;
    String emailSubject;
    String emailBody;

    public SendEmail() {
    }
  

    public SendEmail(String receiverEmail, String subject, String body) {
        this.receiverEmail = receiverEmail;
        this.emailSubject = subject;
        this.emailBody = body;

        try {
            Properties pr = new Properties();
            pr.setProperty("mail.smtp.host", emailSMTPserver);
            pr.setProperty("mail.smtp.port", emailServerPort);
            pr.setProperty("mail.smtp.auth", "true");
            pr.setProperty("mail.smtp.starttls.enable", "true");

            Session session = Session.getInstance(pr, new Authenticator() {
                @Override
                protected PasswordAuthentication getPasswordAuthentication() {
                    return new PasswordAuthentication(senderEmail, senderPassword);
                }
            });

            Message msg = new MimeMessage(session);
            msg.setFrom(new InternetAddress(senderEmail));
            msg.setRecipient(Message.RecipientType.TO, new InternetAddress(this.receiverEmail));
            msg.setSubject(this.emailSubject);
            msg.setSentDate(new Date());

            // Create a multipar message
            Multipart multipart = new MimeMultipart();

            // Create the body part
            MimeBodyPart messageBodyPart = new MimeBodyPart();
            messageBodyPart.setContent(this.emailBody, "text/html");

            // Add body part to multipart
            multipart.addBodyPart(messageBodyPart);

            // Set the multipart content to the message
            msg.setContent(multipart);

            // Setting headers
            msg.setHeader("X-Priority", "1");
            msg.setHeader("X-MSMail-Priority", "High");
            msg.setHeader("Importance", "High");

            Transport.send(msg);

        } catch (MessagingException e) {
            e.printStackTrace();
        }
    }
}
