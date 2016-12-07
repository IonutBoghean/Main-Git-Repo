public with sharing class OpportunityMergeExtension {
    public Map<Id, Opportunity> backendRecords {get; set;}
    public List<MergeField> mergeFields {get; set;}
    private String masterOpportunityId;
    public Integer beckendRecordsSize {get; set;}
    public OpportunityMergeExtension(ApexPages.StandardController stdController) {
        this.masterOpportunityId = stdController.getId();
        this.backendRecords = new Map<Id, Opportunity>([SELECT Id, Name, Amount, CloseDate FROM Opportunity WHERE Id != :stdController.getId() limit 10]);
        this.beckendRecordsSize = this.backendRecords.size();
        List<String> fieldNames = System.Label.FieldsToMerge.split(',');
        this.mergeFields = new List<MergeField>();
        for(String fieldName :fieldNames) {
            this.mergeFields.add(new MergeField(fieldName));
        }
    }
    
    public PageReference mergeRecords() {
        String selectedOpporutnityId = Apexpages.currentPage().getParameters().get('selectedOppId');
        Opportunity masterRecord = new Opportunity(Id = masterOpportunityId);
        for(MergeField field :mergeFields) {
            if(field.isSelected) {
                masterRecord.put(field.apiName, this.backendRecords.get(selectedOpporutnityId).get(field.apiName));
            }
        }
        try {
            update masterRecord;
            delete this.backendRecords.get(selectedOpporutnityId);
        } catch(Exception ex) {
            
        }
        PageReference masterOpportunityDetail = new PageReference('/' + masterOpportunityId);
        masterOpportunityDetail.setRedirect(true);
        return masterOpportunityDetail;
    }
    
    public static String getFieldLabel(String fieldApiName) {
        Map<String, Schema.SObjectType> schemaMap = Schema.getGlobalDescribe();
        Schema.SObjectType leadSchema = schemaMap.get('Opportunity');
        Map<String, Schema.SObjectField> fieldMap = leadSchema.getDescribe().fields.getMap();
        return fieldMap.get(fieldApiName).getDescribe().getLabel();
    }
    
    public class MergeField {
        public String apiName {get; set;}
        public String label {get; set;}
        public Boolean isSelected {get; set;}
        public MergeField(String apiName) {
            this.apiName = apiName;
            this.label = getFieldLabel(apiName);
            this.isSelected = false;
        }
    }
}