trigger AccountAddressTrigger on Account (before insert, before update) {
    for(Account record :Trigger.new) {
        if(record.Match_Billing_Address__c && String.isNotBlank(record.BillingPostalCode)) {
            record.ShippingPostalCode = record.BillingPostalCode;
        }
    }
}