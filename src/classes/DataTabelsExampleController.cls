public with sharing class DataTabelsExampleController 
{
    public transient List<sObject> records {get;set;}
    public transient String objectType {get;set;}
    public transient String fieldSetNameSuffix {get;set;}
    public DataTabelsExampleController()
    {
        fieldSetNameSuffix = 'DataTabelsFieldSet';
        objectType = ApexPages.currentPage().getParameters().get('objectType');
        queryRecords();
    }
    
    private void queryRecords()
    {
        String query = buildSobjectQuery();
        try {
            records = Database.query(query);
        } catch(Exception ex) {
            //handle exceptions
            System.debug(ex.getStackTraceString());
        }
    }
    
    private String buildSobjectQuery()
    {
        String query = 'SELECT Id, Name';
        for(Schema.FieldSetMember f : this.getFields()) {
            query += ', ' + f.getFieldPath();
        }
        query += ' FROM ' + objectType;
        return query;
    }
    
    private List<Schema.FieldSetMember> getFields()
    {
        Map<String, Schema.SObjectType> GlobalDescribeMap = Schema.getGlobalDescribe(); 
        Schema.SObjectType SObjectTypeObj = GlobalDescribeMap.get(objectType);
        Schema.DescribeSObjectResult DescribeSObjectResultObj = SObjectTypeObj.getDescribe();
        Schema.FieldSet fieldSetObj = DescribeSObjectResultObj.FieldSets.getMap().get(objectType + fieldSetNameSuffix);
        return fieldSetObj.getFields(); 
    }  
    
}