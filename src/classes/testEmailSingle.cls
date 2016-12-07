public class testEmailSingle{
public testEmailSingle(){}
public void sendEmail() {
Messaging.SingleEmailMessage emailMessage = new Messaging.SingleEmailMessage();
            emailMessage.setTargetObjectId('00324000009WXfu');
            emailMessage.setSubject('test');
            emailMessage.setPlainTextBody('test');
            emailMessage.setUseSignature(false);
            emailMessage.setOrgWideEmailAddressId('0D2240000004FGj');
            Messaging.sendEmail(new List<Messaging.SingleEmailMessage>{ emailMessage });
}
}