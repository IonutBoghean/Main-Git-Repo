@isTest
private class OpportunityMergeExtensionTest {
    static testmethod void controllerTest() {
        Account testAccount = new Account(
            Name = 'Test'
        );
        insert testAccount;
        Opportunity masterOpportunity = new Opportunity(
            Name = 'Test',
            AccountId = testAccount.Id,
            StageName = 'New',
            CloseDate = System.today().addDays(1),
            Amount = 1000
        );
        Opportunity backendOpportunity = new Opportunity(
            Name = 'Test 1',
            AccountId = testAccount.Id,
            StageName = 'New',
            CloseDate = System.today().addDays(1),
            Amount = 500
        );
        insert new List<Opportunity>{masterOpportunity, backendOpportunity};
        ApexPages.StandardController stdController = new ApexPages.StandardController(masterOpportunity);
        System.Test.setCurrentPage(Page.OpportunityMerge);
        System.Test.startTest();
            OpportunityMergeExtension extensionObject = new OpportunityMergeExtension(stdController);
            ApexPages.currentPage().getParameters().put('selectedOppId', backendOpportunity.Id);
            extensionObject.mergeFields[0].isSelected = true;
            extensionObject.mergeRecords();
        System.Test.stopTest();
    }
}