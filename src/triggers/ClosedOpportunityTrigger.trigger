trigger ClosedOpportunityTrigger on Opportunity (after insert, after update) {
	List<Task> newTaskRecords = new List<Task>();
    for(Opportunity record :Trigger.new) {
        if(record.StageName == 'Closed Won') {
            newTaskRecords.add(new Task(
                Subject = 'Follow Up Test Task',
                WhatId = record.Id
            ));
        }
    }
    if(!newTaskRecords.isEmpty()) {
        insert newTaskRecords;
    }
}