package feedback;

public class FeedbackDTO {

    private String feedbackID;
    private String feedbackDay;
    private String feedbackContent;
    private String fullName;

    public FeedbackDTO() {
    }

    public FeedbackDTO(String feedbackID, String feedbackDay, String feedbackContent, String fullName) {
        this.feedbackID = feedbackID;
        this.feedbackDay = feedbackDay;
        this.feedbackContent = feedbackContent;
        this.fullName = fullName;

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

    public String getFullName() {
        return fullName;
    }

    public void setFullName(String fullName) {
        this.fullName = fullName;
    }
    
    @Override
    public String toString() {
        return super.toString(); // Generated from nbfs://nbhost/SystemFileSystem/Templates/Classes/Code/OverriddenMethodBody
    }

}
