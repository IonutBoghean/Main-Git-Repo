public class AccountHandler {
    public static Account insertNewAccount(String name) {
        Account record = new Account(Name = name);
        try {
            insert record;
        } catch(Exception ex) {
            return null;
        }
        return record;
    }
}