global with sharing class ViewAllTemplateController 
{
    public List<ViewAllWrapper> records {get;set;}
    public String objectType {get;set;}
    public String objectLabel {get;set;}
    public String objectLabelPlural {get;set;}
    public String fieldSetNameSuffix {get;set;}
    public ViewAllTemplateController()
    {
        fieldSetNameSuffix = 'ViewAllFieldSet';
        objectType = ApexPages.currentPage().getParameters().get('objectType');
        Map<String, Schema.SObjectType> globalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType sObjectTypeObj = globalDescribeMap.get(objectType);
        Schema.DescribeSObjectResult describeSObjectResultObj = sObjectTypeObj.getDescribe();
        objectLabel = describeSObjectResultObj.getLabel();
        objectLabelPlural = describeSObjectResultObj.getLabelPlural();
        queryRecords(describeSObjectResultObj);
    }
    
    private void queryRecords(Schema.DescribeSObjectResult describeSObjectResultObj)
    {
        String query = buildSobjectQuery(describeSObjectResultObj);
        try {
            //records = Database.query(query);
            records = new List<ViewAllWrapper>();
            for(Sobject sObj : Database.query(query)){
                records.add(new ViewAllWrapper(sObj));
            }
        } catch(Exception ex) {
            //handle exceptions
            System.debug(ex.getStackTraceString());
        }
    }

    private String buildSobjectQuery(Schema.DescribeSObjectResult describeSObjectResultObj)
    {
        String query = 'SELECT Id, Name';
        for(Schema.FieldSetMember f : this.getFields(describeSObjectResultObj)) {
            query += ', ' + f.getFieldPath();
        }
        query += ' FROM ' + objectType;
        return query;
    }
    
    private List<Schema.FieldSetMember> getFields(Schema.DescribeSObjectResult describeSObjectResultObj)
    {
        Schema.FieldSet fieldSetObj = describeSObjectResultObj.FieldSets.getMap().get(objectLabel + fieldSetNameSuffix);
        return fieldSetObj.getFields(); 
    }  
    
    @RemoteAction
    global static List<User> getUsers(){
        return [SELECT Id,Name FROM User WHERE IsActive = TRUE];
    }
}