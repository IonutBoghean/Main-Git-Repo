public class ContactSearch {
    public static List<Contact> searchForContacts(String lastName, String postalCode) {
        List<Contact> records;
        try {
            records = [SELECT Name FROM Contact WHERE LastName = :lastName AND MailingPostalCode = :postalCode];
        } catch(Exception ex) {
            records = new List<Contact>();
        }
        return records;
    }
}