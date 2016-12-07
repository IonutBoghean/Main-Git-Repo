@isTest
public class TestVerifyDate {
    static testmethod void testController() {
        VerifyDate.CheckDates(System.today(), System.today().addDays(1));
        VerifyDate.CheckDates(System.today(), System.today().addDays(-1));
        VerifyDate.CheckDates(System.today(), System.today().addDays(40));
    }
}