package BadWordFilter;

import java.nio.file.*;
import java.util.*;
import java.util.regex.*;
import java.io.IOException;
import java.io.PrintStream;
import java.nio.charset.StandardCharsets;

public class BadWordFilter {
    // List to hold bad words read from file
    private static List<String> badWords;

    // Static block to load bad words from file
    static {
        try {
            // Read all lines from badwords.txt
            badWords = Files.readAllLines(Paths.get("C:\\Users\\ROG STRIX\\Downloads\\badwords.txt"));
        } catch (IOException e) {
            System.err.println("Error reading bad words file: " + e.getMessage());
            // Initialize with an empty list if reading fails
            badWords = new ArrayList<>();
        }
    }

    public String filterBadWords(String text) {
        // Create a regex pattern that matches any bad word
        String patternString = String.join("|", badWords);
        Pattern pattern = Pattern.compile(patternString, Pattern.CASE_INSENSITIVE);
        Matcher matcher = pattern.matcher(text);

        // Use StringBuffer to efficiently replace bad words
        StringBuffer filteredText = new StringBuffer();
        while (matcher.find()) {
            // Replace bad word with asterisks
            String replacement = "*".repeat(matcher.group().length());
            matcher.appendReplacement(filteredText, replacement);
        }
        matcher.appendTail(filteredText);

        return filteredText.toString();
    }

//    public static void main(String[] args) {
//        System.setOut(new PrintStream(System.out, true, StandardCharsets.UTF_8));
//        String inputText = "Tôi không muốn nghe từ địt hoặc lồn trong câu chuyện này.";
//        String filteredText = filterBadWords(inputText);
//        
//        System.out.println(filteredText); // Output: "Tôi không muốn nghe từ *** hoặc *** trong câu chuyện này."
//    }
}
