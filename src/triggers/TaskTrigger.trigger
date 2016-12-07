trigger TaskTrigger on Task (
    before insert, 
    before update, 
    before delete, 
    after insert, 
    after update, 
    after delete, 
    after undelete) {

        if (Trigger.isBefore) {
            //call your handler.before method
        
        } else if (Trigger.isAfter) {
            //call handler.after method
            system.debug(trigger.new[0].subject);
        }
}