public class RandomContactFactory {
    public static List<Contact> generateRandomContacts(Integer noOfRecords, String lastName) {
        List<Contact> newRecords = new List<Contact>();
        for(Integer i = 0; i < noOfRecords; i++) {
            newRecords.add(new Contact(
                LastName = lastName,
                FirstName = 'C' + String.valueOf(i)
            ));
        }
        return newRecords;
    }
}