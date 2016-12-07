trigger EmailMessageTrigger on EmailMessage (after insert) {
    System.debug('works');
}