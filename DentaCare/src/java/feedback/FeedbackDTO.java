package feedback;

import java.time.LocalDateTime;
public class FeedbackDTO {

    private String feedbackID;
    private String feedbackDay;
    private String feedbackContent;
    private String accountID;
    private int clinicID;

    public FeedbackDTO() {
    }

    public FeedbackDTO(String feedbackID, String feedbackDay, String feedbackContent, String accountID, int clinicID) {
        this.feedbackID = feedbackID;
        this.feedbackDay = feedbackDay;
        this.feedbackContent = feedbackContent;
        this.accountID = accountID;
        this.clinicID = clinicID;
    }

    public String getFeedbackID() {
        return feedbackID;
    }

    public void setFeedbackID(String feedbackID) {
        this.feedbackID = feedbackID;
    }

    public String getFeedbackDay() {
        return feedbackDay;
    }

    public void setFeedbackDay(String feedbackDay) {
        this.feedbackDay = feedbackDay;
    }

    public String getFeedbackContent() {
        return feedbackContent;
    }

    public void setFeedbackContent(String feedbackContent) {
        this.feedbackContent = feedbackContent;
    }

    public String getAccountID() {
        return accountID;
    }

    public void setAccountID(String accountID) {
        this.accountID = accountID;
    }

    public int getClinicID() {
        return clinicID;
    }

    public void setClinicID(int clinicID) {
        this.clinicID = clinicID;
    }

    @Override
    public String toString() {
        return super.toString(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }
    

}
