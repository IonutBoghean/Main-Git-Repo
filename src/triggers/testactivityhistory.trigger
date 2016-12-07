trigger testactivityhistory on Task (before insert) {
    System.debug('works');
}