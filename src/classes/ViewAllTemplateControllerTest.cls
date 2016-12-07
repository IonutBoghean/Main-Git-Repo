@isTest
private class ViewAllTemplateControllerTest {

    static testMethod void testHappyFlow() {
        createTestAccount();
        PageReference viewAllPageRef = Page.ViewAllTemplate;
        viewAllPageRef.getParameters().put('objectType', 'Account');
        Test.setCurrentPage(viewAllPageRef);
        Test.startTest();
        ViewAllTemplateController controller = new ViewAllTemplateController();
        Test.stopTest();
        System.assertNotEquals(controller.records.size(), 0);
    }
    
    private static void createTestAccount() {
        Account testRecord = new Account(
            Name = 'test record'
        );
        insert testRecord;
    }
    
}