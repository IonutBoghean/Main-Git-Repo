public class PP_Helper {
    private static Set<String> componentFamilies = new Set<String>();
    private static Set<String> componentTypes = new Set<String>();
    private static List<PP_ComponentWrapper> componentWrappers = new List<PP_ComponentWrapper>();
    public static List<PP_ComponentWrapper> getComponentWrappers(Id opportunityId) {
        Map<Id, OpportunityLineItem> lineItemsByProductId = new Map<Id, OpportunityLineItem>();
        for(OpportunityLineItem lineItemRecord :[SELECT Id, Product2Id, Quantity, Product2.Name, Product2.Internal_Cost__c, Product2.Proxy_Prices__c, Product2.Family, 
            Product2.Component_Type__c, Product2.IsTickbox__c FROM OpportunityLineItem WHERE OpportunityId = :opportunityId]) {
            lineItemsByProductId.put(lineItemRecord.Product2Id, lineItemRecord);
        }
        for(Product2 component :[SELECT Id, Name, Internal_Cost__c, Proxy_Prices__c, Family, Component_Type__c, IsTickbox__c FROM Product2 WHERE Component_Type__c != null AND Family != null]) {
            if(lineItemsByProductId.containsKey(component.Id)) {
                updateComponentWrappers(lineItemsByProductId.get(component.Id));
            } else {
                updateComponentWrappers(component);
            }
        }
        return componentWrappers;
    }
       
    private static void updateComponentWrappers(OpportunityLineItem lineItemRecord) {
        PP_ComponentWrapper familyObject;
        PP_ComponentWrapper.ComponentType typeObject;
        PP_ComponentWrapper.ComponentItem itemObject;
        if(componentFamilies.contains(lineItemRecord.Product2.Family)) {
            if(componentTypes.contains(lineItemRecord.Product2.Family + lineItemRecord.Product2.Component_Type__c)) {
                typeObject = findComponentType(lineItemRecord.Product2.Family, lineItemRecord.Product2.Component_Type__c);
                itemObject = new PP_ComponentWrapper.ComponentItem(lineItemRecord);
                typeObject.items.add(itemObject);
            } else {
                familyObject = findComponentFamily(lineItemRecord.Product2.Family);
                typeObject = new PP_ComponentWrapper.ComponentType(lineItemRecord.Product2.Component_Type__c, lineItemRecord.Product2.IsTickbox__c);
                itemObject = new PP_ComponentWrapper.ComponentItem(lineItemRecord);
                typeObject.items.add(itemObject);
                familyObject.types.add(typeObject);
                componentTypes.add(lineItemRecord.Product2.Family + lineItemRecord.Product2.Component_Type__c);
            }
        } else {
            familyObject = new PP_ComponentWrapper(lineItemRecord.Product2.Family);
            typeObject = new PP_ComponentWrapper.ComponentType(lineItemRecord.Product2.Component_Type__c, lineItemRecord.Product2.IsTickbox__c);
            itemObject = new PP_ComponentWrapper.ComponentItem(lineItemRecord);
            typeObject.items.add(itemObject);
            familyObject.types.add(typeObject);
            componentWrappers.add(familyObject);
            componentTypes.add(lineItemRecord.Product2.Family + lineItemRecord.Product2.Component_Type__c);
            componentFamilies.add(lineItemRecord.Product2.Family);
        }
    }
    
    private static void updateComponentWrappers(Product2 productRecord) {
        PP_ComponentWrapper familyObject;
        PP_ComponentWrapper.ComponentType typeObject;
        PP_ComponentWrapper.ComponentItem itemObject;
        if(componentFamilies.contains(productRecord.Family)) {
            if(componentTypes.contains(productRecord.Family + productRecord.Component_Type__c)) {
                typeObject = findComponentType(productRecord.Family, productRecord.Component_Type__c);
                itemObject = new PP_ComponentWrapper.ComponentItem(productRecord);
                typeObject.items.add(itemObject);
            } else {
                familyObject = findComponentFamily(productRecord.Family);
                typeObject = new PP_ComponentWrapper.ComponentType(productRecord.Component_Type__c, productRecord.IsTickbox__c);
                itemObject = new PP_ComponentWrapper.ComponentItem(productRecord);
                typeObject.items.add(itemObject);
                familyObject.types.add(typeObject);
                componentTypes.add(productRecord.Family + productRecord.Component_Type__c);
            }
        } else {
            familyObject = new PP_ComponentWrapper(productRecord.Family);
            typeObject = new PP_ComponentWrapper.ComponentType(productRecord.Component_Type__c, productRecord.IsTickbox__c);
            itemObject = new PP_ComponentWrapper.ComponentItem(productRecord);
            typeObject.items.add(itemObject);
            familyObject.types.add(typeObject);
            componentWrappers.add(familyObject);
            componentTypes.add(productRecord.Family + productRecord.Component_Type__c);
            componentFamilies.add(productRecord.Family);
        }
    }
    
    private static PP_ComponentWrapper findComponentFamily(String family) {
        for(PP_ComponentWrapper familyObject :componentWrappers) {
            if(family.equals(familyObject.family)) {
                return familyObject;
            }
        }
        return null;
    }
    
    private static PP_ComponentWrapper.ComponentType findComponentType(String family, String cType) {
        for(PP_ComponentWrapper familyObject :componentWrappers) {
            if(family.equals(familyObject.family)) {
                for(PP_ComponentWrapper.ComponentType typeObject :familyObject.types) {
                    if(cType.equals(typeObject.cType)) {
                        return typeObject;
                    }
                }
            }
        }
        return null;
    }
}