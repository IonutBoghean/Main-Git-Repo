@isTest
public class TestRestrictContactByName {
	static testmethod void testTrigger() {
        Contact record = new Contact(LastName = 'INVALIDNAME');
        System.Test.startTest();
        	Database.SaveResult result = System.Database.insert(record);
        System.Test.stopTest();
    }
}