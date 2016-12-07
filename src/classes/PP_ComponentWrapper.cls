public class PP_ComponentWrapper {
    @AuraEnabled
    public String family {get; set;}
    
    @AuraEnabled
    public List<ComponentType> types {get; set;}
    
    public PP_ComponentWrapper(String family) {
        this.family = family;
        this.types = new List<ComponentType>();
    }
    
    public class ComponentType {
        @AuraEnabled
        public String cType {get; set;}
        
        @AuraEnabled
        public Boolean isTickbox {get; set;}
        
        @AuraEnabled
        public List<ComponentItem> items {get; set;}
        
        public ComponentType(String cType, Boolean isTickbox) {
            this.cType = cType;
            this.isTickbox = isTickbox;
            this.items = new List<ComponentItem>();
        }
    }
    
    public class ComponentItem{
        @AuraEnabled
        public Integer quantity {get; set;}
        
        @AuraEnabled
        public Boolean isSelected {get; set;}
        
        @AuraEnabled
        public Product2 record {get; set;}
        
        @AuraEnabled
        public OpportunityLineItem lineItemRecord {get; set;}
        
        public ComponentItem(Product2 record) {
            this.record = record;
            this.quantity = 0;
            this.isSelected = false;
        }
        
        public ComponentItem(OpportunityLineItem lineItemRecord) {
            this.lineItemRecord = lineItemRecord;
            this.record = new Product2(
                Name = lineItemRecord.Product2.Name,
                Internal_Cost__c = lineItemRecord.Product2.Internal_Cost__c,
                Proxy_Prices__c = lineItemRecord.Product2.Proxy_Prices__c,
                IsTickbox__c = lineItemRecord.Product2.IsTickbox__c
            );
            this.quantity = lineItemRecord.Quantity.intValue();
            this.isSelected = lineItemRecord.Product2.IsTickbox__c;
        }
    }
    
}