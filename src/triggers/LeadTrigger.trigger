trigger LeadTrigger on Lead (after update) {
    if(Trigger.new[0].Status == 'Closed - Converted' && Trigger.new[0].isconverted == false) {
        Database.LeadConvert lcr = new Database.LeadConvert();
        Lead test = new Lead(Id=Trigger.new[0].id);
        lcr.setLeadId(test.id);
        LeadStatus convertStatus = [SELECT Id, MasterLabel FROM LeadStatus WHERE IsConverted=true LIMIT 1];
lcr.setConvertedStatus(convertStatus.MasterLabel);

        Database.convertLead(lcr);
    }
}