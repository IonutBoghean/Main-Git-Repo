public class ContactAndLeadSearch {
    public static List<List< SObject>> searchContactsAndLeads(String text) {
        List<List< SObject>> soslResults;
        try {
            soslResults = [FIND :text IN NAME FIELDS 
                           RETURNING Contact(FirstName, LastName), Lead(FirstName, LastName)];
        } catch(Exception ex) {
            soslResults = new List<List<sObject>>();
        }
        return soslResults;
    }
}