public class AccountHandler {
    public static Account insertNewAccount(String name) {
        Account record = new Account(Name = name);
		//test a commit
        try {
            insert record;
        } catch(Exception ex) {
            return null;
        }
        return record;
    }
}