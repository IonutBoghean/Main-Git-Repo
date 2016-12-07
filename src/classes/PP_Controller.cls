public class PP_Controller {
    @AuraEnabled
    public static List<PP_ComponentWrapper> getComponents(Id opportunityId) {
        List<PP_ComponentWrapper> components = PP_Helper.getComponentWrappers(opportunityId);
        return components;
    }
    
    @AuraEnabled
    public static Opportunity getOpp() {
        return [select id, name from opportunity limit 1];
    }
    /*public static List<PP_ComponentWrapper> gettest() {
        List<PP_ComponentWrapper> components = new List<PP_ComponentWrapper>();
        PP_ComponentWrapper tempComp = new PP_ComponentWrapper();
        tempComp.family = 'Family 1';
        PP_ComponentWrapper.ComponentType tempType = new PP_ComponentWrapper.ComponentType();
        tempType.cType = 'Type 1';
        tempType.isTickbox = false;
        PP_ComponentWrapper.ComponentItem tempItem = new PP_ComponentWrapper.ComponentItem(new Product2(Name = 'Quantity', Internal_Cost__c = 10, Proxy_Prices__c = 10), 10, false);
        tempType.items = new List<PP_ComponentWrapper.ComponentItem>{tempItem};
        tempComp.types = new List<PP_ComponentWrapper.ComponentType>{tempType};
        components.add(tempComp);
        PP_ComponentWrapper tempComp1 = new PP_ComponentWrapper();
        tempComp1.family = 'Family 2';
        PP_ComponentWrapper.ComponentType tempType1 = new PP_ComponentWrapper.ComponentType();
        tempType1.cType = 'Type 2';
        tempType1.isTickbox = true;
        PP_ComponentWrapper.ComponentItem tempItem1 = new PP_ComponentWrapper.ComponentItem(new Product2(Name = 'Tickbox', Internal_Cost__c = 10, Proxy_Prices__c = 10), 10, true);
        tempType1.items = new List<PP_ComponentWrapper.ComponentItem>{tempItem1};
        tempComp1.types = new List<PP_ComponentWrapper.ComponentType>{tempType1};
            components.add(tempComp1);
        return components;
    }*/
}