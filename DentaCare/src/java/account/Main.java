/*
 * Click nbfs://nbhost/SystemFileSystem/Templates/Licenses/license-default.txt to change this license
 * Click nbfs://nbhost/SystemFileSystem/Templates/Classes/Class.java to edit this template
 */
package account;

import java.time.LocalDate;
import java.util.*;

public class Main {

    public static void main(String[] args) {
        List<AccountDTO> entries = new ArrayList<>();

        // Example entries (replace with your actual data insertion logic)
        AccountDTO entry1 = new AccountDTO("DEN2400021", "abc@gmail.com", LocalDate.of(1900, 6, 6), "phuc1", "0961792119", "123 NXN", "bac-dung.jpg", true, 1, "DentaCare2", "lợi", "về quá trời");
        AccountDTO entry3 = new AccountDTO("DEN2400021", "abc@gmail.com", LocalDate.of(1900, 6, 6), "phuc1", "0961792119", "123 NXN", "bac-dung.jpg", true, 1, "DentaCare2", "rang", "về quá trời");

        // Add entries to the list
        entries.add(entry1);
        entries.add(entry3);

 // Map to store aggregated entries
        Map<String, AccountDTO> aggregatedEntries = new HashMap<>();

        // Process each entry
        for (AccountDTO entry : entries) {
            String key = entry.getAccountID()+ "-" + entry.getMajorName(); // Create key based on id and majorName

            if (aggregatedEntries.containsKey(key)) {
                // Entry with this id and majorName already exists, append majorName to the first one
                AccountDTO existingEntry = aggregatedEntries.get(key);
                existingEntry. setMajorName(existingEntry.getMajorName()+ ", " + entry.getMajorName()); // Append majorName
            } else {
                // Entry with this id and majorName does not exist, add it to the map
                aggregatedEntries.put(key, entry);
            }
        }

        // Convert map values to list of entries (if needed)
        List<AccountDTO> aggregatedList = new ArrayList<>(aggregatedEntries.values());

        // Print aggregated entries
        for (AccountDTO entry : aggregatedList) {
            System.out.println(entry.getAccountID()+ " " + entry.getMajorName() + " " + entry.getIntroduction());
        }
    }
}
